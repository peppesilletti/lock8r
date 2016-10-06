mongoose = require "mongoose"

# Opening times schemas
openingTimeSchema = new mongoose.Schema {
	days	: {type: String, required: true},
	opening : String,
	closing	: String,
	closed	: {type: Boolean, required: true}
}

# Reviews schema
reviews = new mongoose.Schema {
	author		: {type: String, required: true},
	rating		: {type: Number, required: true, min: 0, max: 5},
	reviewText	: {type: String, required: true},
	createdOn	: {type: Date, "default": Date.now}
}

# Define schema
locationSchema	= new mongoose.Schema {
	name      	 : { type: String, required: true },
	address   	 : String,
	rating    	 : { type: Number, "default": 0, min: 0, max: 5 },
	facilities	 : [String],
	coords	  	 : { type: [Number], index: '2dsphere'},
	openingTimes : [openingTimeSchema]
	reviews      : [reviews]
}

mongoose.model 'Location', locationSchema