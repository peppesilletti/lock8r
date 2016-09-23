# GET home page.
homepageController = (req,res,next) ->
	res.render 'index',
    title: 'Express'

module.exports.index = homepageController