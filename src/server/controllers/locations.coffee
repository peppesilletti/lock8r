# GET 'home' page 
homelist 	 = (req, res) ->
  res.render 'locations-list', { title: 'Home' }

 # GET 'Location info' page 
locationInfo = (req, res) ->
  res.render 'location-info', { title: 'Location info' }

# GET 'Add review' page 
addReview 	 = (req, res) ->
  res.render 'location-review-form', { title: 'Add review' }

module.exports.homelist 	= homelist
module.exports.locationInfo = locationInfo
module.exports.addReview 	= addReview