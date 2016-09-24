#GET 'about us' page 

about = (req, res) ->
  res.render 'generic-text', { title: 'About' }

module.exports.about = about