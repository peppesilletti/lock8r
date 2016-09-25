# GET 'home' page 
homelist 	 = (req, res) ->
  res.render 'locations-list', { 
  		title: 'Loc8r - find a place to work with wifi',
  		pageHeader: {
	  			title: 'Loc8r',
	  			strapline: 'Find places to work with wifi near you!'
  			},

  		locations: [{
  				name: 'Starcups',
  				address: '125 High Street, Reading, RG6 1PS',
  				rating: 3,
  				facilities: ['Hot drinks', 'Food', 'Premium wifi'],
  				distance: '100m'
  			}, {
  				name: 'Cafe Hero',
  				address: '125 High Street, Reading, RG6 1PS',
  				rating: 4,
  				facilities: ['Hot drinks', 'Food', 'Premium wifi'],
  				distance: '200m'
  			}, {
  				name: 'Burger Queen',
  				address: '125 High Street, Reading, RG6 1PS',
  				rating: 2,
  				facilities: ['Food', 'Premium wifi'],
  				distance: '250m'
  			}]
  		}

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

module.exports.homelist 	= homelist
module.exports.locationInfo = locationInfo
module.exports.addReview 	= addReview