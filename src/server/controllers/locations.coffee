request = require 'request'

apiOption = {
  server: "http://localhost:3000"
}

if process.env.NODE_ENV == 'production'
  apiOption.server = "https://limitless-anchorage-45612.herokuapp.com"

# GET 'home' page 
homelist 	 = (req, res) ->
  path = '/api/locations'

  requestOptions = {
    url: apiOption.server + path,
    method: "GET",
    json: {},
    qs: {
      lng: -0.7992599,
      lat: 51.378091,
      maxDistance: 20
    }
  }

  request requestOptions, (err, response, body) ->
    data = body
    if response.statusCode == 200 && data.length
      data[i].distance = _formatDistance data[i].distance for i in [0..data.length - 1]

    renderHomepage req, res, data

 # GET 'Location info' page 
locationInfo = (req, res) ->

  path = "/api/locations/" + req.params.locationid

  requestOptions = {
    url : apiOption.server + path,
    method : "GET",
    json: {}
  }

  request requestOptions, (err, response, body) ->
    data = body

    data.coords = {
      lng : body.coords[0],
      lat : body.coords[1]
    }

    renderDetailPage req, res, data

# GET 'Add review' page 
addReview 	 = (req, res) ->
  res.render 'location-review-form', { title: 'Add review' }


renderHomepage = (req, res, responseBody) ->

  if !(responseBody instanceof Array)
    message = "API lookup error"
    responseBody = []
  else
    if !responseBody.length
      message = "No places found nearby"

  res.render 'locations-list', { 
      title: 'Loc8r - find a place to work with wifi',
      pageHeader: {
          title: 'Loc8r',
          strapline: 'Find places to work with wifi near you!'
        },
      sidebar: "Looking for wifi and a seat? Loc8r helps you find places to work when out and about.
                Perhaps with coffee, cake or a pint? Let Loc8r help you find the place you're looking for.",
      locations: responseBody,
      message: message
      }


renderDetailPage = (req, res, locDetail) ->
  res.render 'location-info', {
    title : locDetail.name,
    pageHeader : {title: locDetail.name},
    sidebar: {
      context: 'is on Loc8r because it has accessible wifi and space to sit 
      down with your laptop and get some work done.'
      callToAction: 'If you\'ve been and you like it - or if you don\'t - 
      please leave a review to help other people just like you.'
    },
    location: locDetail
  }


_formatDistance = (distance) ->

  if !distance 
    console.log "Distance not present"

  else if !isFinite(String(distance))
    console.log "Distance is not a number"

  else

    if distance > 1
      numDistance = parseFloat(distance).toFixed 1
      unit = 'km'
    else
      numDistance = parseInt distance * 1000,10
      unit = 'm'

    numDistance + unit

module.exports.homelist 	= homelist
module.exports.locationInfo = locationInfo
module.exports.addReview 	= addReview