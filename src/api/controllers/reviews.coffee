mongoose = require 'mongoose'
Loc = mongoose.model 'Location'

reviewsCreate = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

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
	sendJsonResponse res, 200, { "status" : "success" }

reviewsDeleteOne = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }


module.exports.reviewsCreate 	= reviewsCreate
module.exports.reviewsReadOne 	= reviewsReadOne
module.exports.reviewsUpdateOne = reviewsUpdateOne
module.exports.reviewsDeleteOne = reviewsDeleteOne

sendJsonResponse = (res, status, content) ->
	res.status status
	res.json content