mongoose = require 'mongoose'
Loc = mongoose.model 'Location'

locationsListByDistance = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

locationsCreate = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

locationsReadOne = (req, res) ->

	if req.params && req.params.locationid 
		Loc
		.findById req.params.locationid, (err, location) ->
			if !location
				console.log "locationid not found"
				sendJsonResponse res, 404, {message: "locationid not found"}
				return
			else if err
				console.err err
				sendJsonResponse res, 404, err
				return

			sendJsonResponse res, 200, location
	else
		console.log "No locationid in request"
		sendJsonResponse res, 404, {message: "No locationid in request"}


locationsUpdateOne = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

locationsDeleteOne = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }


module.exports.locationsListByDistance 	= locationsListByDistance
module.exports.locationsCreate 			= locationsCreate
module.exports.locationsReadOne 		= locationsReadOne
module.exports.locationsUpdateOne 		= locationsUpdateOne
module.exports.locationsDeleteOne 		= locationsDeleteOne

sendJsonResponse = (res, status, content) ->
	res.status status
	res.json content