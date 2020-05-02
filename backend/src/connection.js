//include the mongoose library
const mongoose = require('mongoose');

const nameOfDB = 'storedb';

//url of the database
const database_url = `mongodb://localhost:27017/${nameOfDB}`;

const database_options = {
    // Added flag to allow users to fall back to the old deprecated parser, if they find a bug in the new parser
    useNewUrlParser: true,

    // Set to true to make Mongoose's default index build use createIndex() instead of ensureIndex() to avoid deprecation warnings from the MongoDB driver.
    useCreateIndex: true,

    // Set to true to opt in to using the MongoDB driver's new connection management engine.
    useUnifiedTopology: true
}

//open a connection to a database
mongoose.connect(database_url, database_options, function(err) {
    if (err) {
        throw err;
    }
    console.log('Database: Connected')
});

//mongoose.connect(database_url, database_options).then(db => console.log('Database: Connected'));