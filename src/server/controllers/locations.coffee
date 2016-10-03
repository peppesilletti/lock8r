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
  res.render 'location-info', { 
  		title: 'Location info',

  		location: {
  				name: 'Starcups',
  				address: '125 High Street, Reading, RG6 1PS',
  				rating: 3,
  				facilities: ['Hot drinks', 'Food', 'Premium wifi'],
  				distance: '100m',
  				coords: [ lat: '51.455041', lng: '-0.9690884'],
  				openHours: ['Monday - Friday : 7:00am - 7:00pm', 'Saturday : 8:00am - 5:00pm', 'Sunday : closed']
		  		reviews: [
		  			{
		  				rating: 5,
		  				author: 'Simon Holmes',
		  				date: '16 July 2013',
		  				text: "What a great place. I can't say enough good things about it."
		  			},
		  			{
		  				rating: 3,
		  				author: 'Giuseppe Silletti',
		  				date: '16 July 2013',
		  				text: "It was okay. Coffee wasn't great, but the wifi was fast."
		  			}
		  		]
  		}
  	}

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