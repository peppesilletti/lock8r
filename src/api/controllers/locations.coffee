mongoose = require 'mongoose'
Loc = mongoose.model 'Location'

theEarth = do ->
	earthRadius = 6371

	getDistanceFromRads = (rads) ->
		parseFloat rads * earthRadius

	getRadsFromDistance = (distance) ->
		parseFloat distance / earthRadius

	{
		getDistanceFromRads: getDistanceFromRads
		getRadsFromDistance: getRadsFromDistance
	}

locationsListByDistance = (req, res) ->
	lng = parseFloat req.query.lng
	lat = parseFloat req.query.lat

	point = {
		type: "Point",
		coordinates: [lng, lat]
	}

	geoOptions = {
		spherical: true
		#maxDistance: theEarth.getRadsFromDistance(20),
		num: 10
	}

	if !lng && lng!=0 || !lat && lat!=0
		sendJsonResponse res, 404, {
			"message": "lng and lat query parameters are required"
		}
		return

	Loc.geoNear point, geoOptions, (err, results, stats) ->
		locations = []
		if err 
			sendJsonResponse res, 404, err
		else
			results.forEach (doc) ->
				locations.push {
					distance: theEarth.getDistanceFromRads(doc.dis),
					name: doc.obj.name,
					address: doc.obj.address,
					rating: doc.obj.rating,
					facilities: doc.obj.facilities,
					_id: doc.obj._id
				}

			sendJsonResponse res, 200, locations

locationsCreate = (req, res) ->
	Loc.create {
		name: req.body.name,
		address: req.body.address,
		facilities: req.body.facilities.split(","),
		coords: [parseFloat req.body.lng, parseFloat req.body.lat],
		openingTimes: [{
			days: req.body.days1,
			opening: req.body.opening1,
			closing: req.body.closing1,
			closed: req.body.closed1,
			}, {
				days: req.body.days2,
				opening: req.body.opening2,
				closing: req.body.closing2,
				closed: req.body.closed2,
				}]
			}, (err, location) ->
				if err
					sendJsonResponse res, 400, err
				else
					sendJsonResponse res, 201, location

locationsReadOne = (req, res) ->

	if req.params && req.params.locationid 
		Loc
		.findById req.params.locationid, (err, location) ->
			if !location
				console.log "locationid not found"
				sendJsonResponse res, 404, {message: "locationid not found"}	
			else if err
				console.err err
				sendJsonResponse res, 404, err
				

			sendJsonResponse res, 200, location
	else
		console.log "No locationid in request"
		sendJsonResponse res, 404, {message: "No locationid in request"}


locationsUpdateOne = (req, res) ->
	if !req.params.locationid
	  sendJSONresponse res, 404, 'message': 'Not found, locationid is required'
	  
	Loc.findById(req.params.locationid).select('-reviews -rating').exec (err, location) ->
	  if !location
	    sendJSONresponse res, 404, 'message': 'locationid not found'
	  else if err
	    sendJSONresponse res, 400, err
	    
	  location.name = req.body.name
	  location.address = req.body.address
	  location.facilities = req.body.facilities.split(',')
	  location.coords = [
	    parseFloat(req.body.lng)
	    parseFloat(req.body.lat)
	  ]
	  location.openingTimes = [
	    {
	      days: req.body.days1
	      opening: req.body.opening1
	      closing: req.body.closing1
	      closed: req.body.closed1
	    }
	    {
	      days: req.body.days2
	      opening: req.body.opening2
	      closing: req.body.closing2
	      closed: req.body.closed2
	    }
	  ]
	  location.save (err, location) ->
	    if err
	      sendJSONresponse res, 404, err
	    else
	      sendJSONresponse res, 200, location
	

locationsDeleteOne = (req, res) ->
	if locationid
	  Loc.findByIdAndRemove(locationid).exec (err, location) ->
	    if err
	      console.log err
	      sendJSONresponse res, 404, err
	      
	    console.log 'Location id ' + locationid + ' deleted'
	    sendJSONresponse res, 204, null
	else
	  sendJSONresponse res, 404, 'message': 'No locationid'


module.exports.locationsListByDistance 	= locationsListByDistance
module.exports.locationsCreate 			= locationsCreate
module.exports.locationsReadOne 		= locationsReadOne
module.exports.locationsUpdateOne 		= locationsUpdateOne
module.exports.locationsDeleteOne 		= locationsDeleteOne

sendJsonResponse = (res, status, content) ->
	res.status status
	res.json content