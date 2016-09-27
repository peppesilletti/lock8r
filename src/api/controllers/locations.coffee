mongoose = require 'mongoose'
Loc = mongoose.model 'Location'

locationsListByDistance = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

locationsCreate = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

locationsReadOne = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

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