var fs = require("fs"); // image tutorial

Product = require('../models/productModel');

exports.index = (req, res) => {
    Product.get( (err, product) => {
        if (err) {
            res.json({
                status: 'err',
                code: 500,
                message: err
            });
        }

        res.json(product);
    })
}

//create function for adding a new product
exports.add = function(req, res) {
    
    let product = new Product();

    var name = req.body.fileName;
    console.log(name);
    var img = req.body.base64Image;
    if (img) 
    {
        product.image.data = Buffer.from(img.toString(),"base64");
        product.image.fileName = name;

        // product.image.data = fs.writeFile(name, realFile, function(err) {
        //     if(err)
        //         console.log(err);
        // });
    }

    product.productName = req.body.productName;
    product.productDescription = req.body.productDescription;
    product.productCondition = req.body.productCondition;
    product.pickupAddress.id = req.body.pickupAddressId;
    product.pickupAddress.name = req.body.pickupAddressName;
    //console.log(req.body.pickupAddressCoord1);
    //console.log(req.body.pickupAddressCoord2);
    product.pickupAddress.coordinates.push(req.body.pickupAddressCoord1);
    product.pickupAddress.coordinates.push(req.body.pickupAddressCoord2);
    //console.log(product.pickupAddress.coordinates);
    product.contactPhoneNumber = req.body.contactPhoneNumber;
    product.contactEmail = req.body.contactEmail;

    product.save(function(err) {
        if (err) {
            res.json({
                status: 'err',
                code: 500,
                message: err
            })
            console.log(err);
            return;
        }
        res.json({
            status: 'success',
            code: 200,
            message: 'Product saved',
            data: product
        })
    })
}

//create function for viewing a new product
exports.view = function(req, res) {
    Product.findById(req.params.id, function(err, product) {

        // var imageDataBufferFormat = product.image.data;
        // if(product.image)
        //     product.image.data = imageDataBufferFormat.toString('ascii');

        if (err) {
            res.json({
                status: 'err',
                code: 500,
                message: err
            })
        }
        res.json({
            status: 'success',
            code: 200,
            message: 'Product view',
            data: product
        })
    })
}

//create function for updating a product
exports.update = function(req, res) {
    Product.findById(req.params.id, function(err, product) {
        if (err) {
            res.json({
                status: 'err',
                code: 500,
                message: err
            })
        }

        //let product = new Product();

        var name = req.body.fileName;
        console.log(name);
        var img = req.body.base64Image;
        if (img) 
        {
            product.image.data = Buffer.from(img.toString(),"base64");
            product.image.fileName = name;
    
            // product.image.data = fs.writeFile(name, realFile, function(err) {
            //     if(err)
            //         console.log(err);
            // });
        }
    
        product.productName = req.body.productName;
        product.productDescription = req.body.productDescription;
        product.productCondition = req.body.productCondition;
        product.pickupAddress.id = req.body.pickupAddressId;
        product.pickupAddress.name = req.body.pickupAddressName;
        //console.log(req.body.pickupAddressCoord1);
        //console.log(req.body.pickupAddressCoord2);
        product.pickupAddress.coordinates.push(req.body.pickupAddressCoord1);
        product.pickupAddress.coordinates.push(req.body.pickupAddressCoord2);
        //console.log(product.pickupAddress.coordinates);
        product.contactPhoneNumber = req.body.contactPhoneNumber;
        product.contactEmail = req.body.contactEmail;

        
        product.save(function(err) {
            if (err) {
                res.json({
                    status: 'err',
                    code: 500,
                    message: err
                })
            }

            res.json({
                status: 'success',
                code: 200,
                message: 'Product updated',
                data: product
            })
        })
    })
}

//create function for deleting a product
exports.delete = function(req, res) {
    Product.deleteOne({_id: req.params.id}, function(err, product) {
        if (err) {
            res.json({
                status: 'err',
                code: 500,
                message: err
            })
        }

        res.json({
            status: 'success',
            code: 200,
            message: 'Product deleted',
            data: product
        })
    })
}