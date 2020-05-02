let mongoose = require('mongoose')

let productSchema = mongoose.Schema({
    productName: {
        type: String,
        required: true,
    },
    productDescription: String,
    productCondition: String,
    pickupAddress: {
        id: {
          type: String,
          required: true
        },
        name: {
          type: String,
          required: true
        },
        coordinates: {
          type: [Number],
          required: true
        }
      },
    contactPhoneNumber: String,
    contactEmail: String,
    image: {
        fileName: String,
        data: Buffer,
        required: false,
    },
    create: {
        type: Date,
        default: Date.now
    }
});

//exporting the model in a variable called "Product"
let Product = module.exports = mongoose.model('product', productSchema);

module.exports.get = function(callback, limit) {
    Product.find(callback).limit(limit);
}