mongoose = require 'mongoose'
Loc = mongoose.model 'Location'

doAddReview = (req, res, location) ->
	if !location
		sendJsonResponse res, 404, {
			"message": "locationid not found"
		}
	else
		location.reviews.push {
			author: req.body.author,
			rating: req.body.rating,
			reviewText: req.body.reviewText
		}

		location.save = (err, location) ->
			if err
				sendJsonResponse res, 400, err
			else
				updateAverageRating location._id
				thisReview = location.reviews[location.reviews.length - 1]
				sendJsonResponse res, 201, thisReview


updateAverageRating = (locationid) ->
	Loc
	.findById locationid, 'rating reviews', (err, location) ->
		if !err
			doSetAverageRating location

doSetAverageRating = (location) ->
	if location.reviews && location.reviews.length > 0 
		reviewCount = location.reviews.length
		ratingTotal = 0
		ratingTotal = ratingTotal + location.reviews[i].rating for i in [0..reviewCount]
		ratingAverage = parseInt ratingTotal / reviewCount, 10
		location.rating = ratingAverage
		location.save = (err) ->
			if err
				console.log err
			else
				console.log "Average rating updated to", ratingAverage

# Controller functions

reviewsCreate = (req, res) ->
	locationid = req.params.locationid
	if locationid
		Loc
		.findById locationid, 'reviews', (err, location) ->
			if err
				sendJsonResponse res, 400, err
			else
				doAddReview req, res, location
	else
		sendJsonResponse res, 404, {
			"message": "Not found, locationid required"
		}

reviewsReadOne = (req, res) ->

	if req.params && req.params.locationid && req.params.reviewid
		Loc
		.findById req.params.locationid, 'name reviews', (err, location) ->
			if !location
				console.log "locationid not found"
				sendJsonResponse res, 404, {message: "locationid not found"}
				return
			else if err
				console.err err
				sendJsonResponse res, 404, err
				return

			if location.reviews && location.reviews.length > 0

				review = location.reviews.id(req.params.reviewid)

				if !review
					console.log "reviewid not found"
					sendJsonResponse res, 404, {message: "reviewid not found"}
				else
					response = {
						location: {
							name: location.name,
							id: req.params.locationid
						},
						review: review
					}

					sendJsonResponse res, 200, response
			else
				console.log "no reviews found"
				sendJsonResponse res, 404, {message: "Not found, locationid and reviewid are both required"}

	else
		console.log "No locationid in request"
		sendJsonResponse res, 404, {message: "No locationid in request"}

reviewsUpdateOne = (req, res) ->
	if !req.params.locationid or !req.params.reviewid
	  sendJSONresponse res, 404, 'message': 'Not found, locationid and reviewid are both required'
	Loc.findById(req.params.locationid).select('reviews').exec (err, location) ->
	  thisReview = undefined
	  if !location
	    sendJSONresponse res, 404, 'message': 'locationid not found'
	  else if err
	    sendJSONresponse res, 400, err
	    
	  if location.reviews and location.reviews.length > 0
	    thisReview = location.reviews.id(req.params.reviewid)
	    if !thisReview
	      sendJSONresponse res, 404, 'message': 'reviewid not found'
	    else
	      thisReview.author = req.body.author
	      thisReview.rating = req.body.rating
	      thisReview.reviewText = req.body.reviewText
	      location.save (err, location) ->
	        if err
	          sendJSONresponse res, 404, err
	        else
	          updateAverageRating location._id
	          sendJSONresponse res, 200, thisReview
	        
	  else
	    sendJSONresponse res, 404, 'message': 'No review to update'
	  

reviewsDeleteOne = (req, res) ->
	if !req.params.locationid or !req.params.reviewid
	  sendJSONresponse res, 404, 'message': 'Not found, locationid and reviewid are both required'
	Loc.findById(req.params.locationid).select('reviews').exec (err, location) ->

	  if !location
	    sendJSONresponse res, 404, 'message': 'locationid not found'
	  else if err
	    sendJSONresponse res, 400, err
	    
	  if location.reviews and location.reviews.length > 0
	    if !location.reviews.id(req.params.reviewid)
	      sendJSONresponse res, 404, 'message': 'reviewid not found'
	    else
	      location.reviews.id(req.params.reviewid).remove()
	      location.save (err) ->
	        if err
	          sendJSONresponse res, 404, err
	        else
	          updateAverageRating location._id
	          sendJSONresponse res, 204, null    
	  else
	    sendJSONresponse res, 404, 'message': 'No review to delete'
	  

module.exports.reviewsCreate 	= reviewsCreate
module.exports.reviewsReadOne 	= reviewsReadOne
module.exports.reviewsUpdateOne = reviewsUpdateOne
module.exports.reviewsDeleteOne = reviewsDeleteOne

sendJsonResponse = (res, status, content) ->
	res.status status
	res.json content