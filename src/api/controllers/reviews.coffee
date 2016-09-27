reviewsCreate = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

reviewsReadOne = (req, res) ->
	sendJsonResponse res, 200, { "status" : "success" }

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