express 	  = require 'express'
router 		  = express.Router()
ctrlLocations = require '../controllers/locations'
ctrlOthers 	  = require '../controllers/others'

#Locations pages 
router.get '/', ctrlLocations.homelist
router.get '/location/:locationid', ctrlLocations.locationInfo
router.get '/location/:locationid/review/new', ctrlLocations.addReview
router.post '/location/:locationid/review/new', ctrlLocations.doAddReview

#Other pages 
router.get '/about', ctrlOthers.about

module.exports = router