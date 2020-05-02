import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/credentials/credentials.dart';
import 'package:new_app/models/Place.dart';
import 'package:new_app/widgets/dividerWithText.dart';

class LocationSearch extends StatefulWidget {
  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  TextEditingController _searchController = new TextEditingController();
  Timer _throttle;
  String _heading;
  //var uuid = new Uuid();
  //String _sessionToken;
  List<Place> _placesList;

  List<String> placeNameList = [
    "Strada Alexandru Vaida Voevod, Cluj-Napoca, Romania",
    "Piața Unirii, Cluj-Napoca, Romania",
    "Bulevardul 21 Decembrie 1989, Cluj-Napoca, Romania",
    "Strada Izlazului, Cluj-Napoca, Romania",
    "Piața Mărăști, Cluj-Napoca, Romania" 
    ];

  final List<Place> _suggestedList = [
    Place("Strada Alexandru Vaida Voevod, Cluj-Napoca, Romania","EjNTdHJhZGEgQWxleGFuZHJ1IFZhaWRhIFZvZXZvZCwgQ2x1ai1OYXBvY2EsIFJvbWFuaWEiLiosChQKEgkTi790OgxJRxHjCTPz7FG5pBIUChIJEwS3GEcMSUcRzvVwgxm-DMo", [46.7705618, 23.6271447]),
    Place("Piața Unirii, Cluj-Napoca, Romania", "EiNQaWHIm2EgVW5pcmlpLCBDbHVqLU5hcG9jYSwgUm9tYW5pYSIuKiwKFAoSCel7XWidDklHEcv8D6rUOV-mEhQKEgnjYLcLnQ5JRxGorzS2ygmgAQ",[46.76932799999999, 23.5892818]),
    Place("Bulevardul 21 Decembrie 1989, Cluj-Napoca, Romania", "EjJCdWxldmFyZHVsIDIxIERlY2VtYnJpZSAxOTg5LCBDbHVqLU5hcG9jYSwgUm9tYW5pYSIuKiwKFAoSCae2N-0hDElHEdceVADTgD7FEhQKEgnLhnMsHwxJRxEfM72ig0vxBA",[46.7753008, 23.6029601]),
    Place("Strada Izlazului, Cluj-Napoca, Romania","EiZTdHJhZGEgSXpsYXp1bHVpLCBDbHVqLU5hcG9jYSwgUm9tYW5pYSIuKiwKFAoSCSWujeN6DklHESR55ms9-Ee7EhQKEgnN8ZIWZg5JRxGMMN0-spd-FA",[46.7554258, 23.5602967]),
    Place("Piața Mărăști, Cluj-Napoca, Romania","EidQaWHIm2EgTcSDcsSDyJl0aSwgQ2x1ai1OYXBvY2EsIFJvbWFuaWEiLiosChQKEgnDtD2sEAxJRxGzk4sxT8z_8RIUChIJy4ZzLB8MSUcRHzO9ooNL8QQ",[46.7772119197085, 23.6133985197085])
  ];

  @override
  void initState() {
    super.initState();
    _heading = "Popular meeting places";
    _placesList = _suggestedList;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged());
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    // if (_sessionToken == null) {
    //   setState(() {
    //     _sessionToken = uuid.v4();
    //   });
    // }

    if (_throttle?.isActive ?? false) _throttle.cancel();
    _throttle = new Timer(Duration(milliseconds: 500), () {
      getLocationResults(_searchController.text);
    });
  }

  void getLocationResults(String input) async {
    if (input.isEmpty) {
      // setState(() {
      //   _heading = "Suggestions";
      // });
      return;
    }

    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    //https://developers.google.com/places/web-service/autocomplete
    String type = 'address';
    String request = '$baseURL?input=$input&key=$PLACES_API_KEY&type=$type';
    Response response = await Dio().get(request);

    print(response);

    final predictions = response.data['predictions'];
    List<Place> _displayResults = [];

    String predName;
    String predPlaceId;
    List<double> predLatLang;
    for (var i = 0; i < predictions.length; i++) {
      predName = predictions[i]['description'];
      predPlaceId = predictions[i]['place_id'];
      predLatLang = await getLocationGeoRef(predPlaceId);

      _displayResults.add(Place(predName, predPlaceId, predLatLang));
    }

    if (this.mounted){
    setState(() {
      _heading = "Results";
      _placesList = _displayResults;
    });
    }
  }

  
  Future<List<double>> getLocationGeoRef(placeId) async {
    String placeGeoRequest = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$PLACES_API_KEY';
    //&sessiontoken=$_sessionToken
    print(placeGeoRequest);
    Response placeDetails = await Dio().get(placeGeoRequest);
    print(placeDetails);
    List<double> latlong = [];
    latlong.add(placeDetails.data["result"]["geometry"]["location"]["lat"]);
    latlong.add(placeDetails.data["result"]["geometry"]["location"]["lng"]);
    // print(placeDetails.data["result"]["geometry"]["location"]["lat"]);
    // print(placeDetails.data["result"]["geometry"]["location"]["lng"]);
    return latlong;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(
      //   color: Colors.grey.shade600, //change your color here
      //   ),
      //   title: Text('PICK-UP ADDRESS',
      //   textAlign: TextAlign.center,
      //   style: GoogleFonts.roboto(
      //                       textStyle: Theme.of(context).textTheme.headline1,
      //                       fontSize: 25,
      //                       fontWeight: FontWeight.w700,
      //                       fontStyle: FontStyle.normal,
      //                       color: Colors.grey.shade600,
      //       ),),
      // ),
      body: SingleChildScrollView(
        child:
      Padding(
        padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  controller: _searchController,
                  // onChanged: (text) {
                  //   getLocationResults(text);
                  // },
                  decoration: InputDecoration(
                    hintText: "Search Location",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    icon: Icon(Icons.search),
                  ),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "field cannot be empty";
                    }
                    return "ok";
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFFFB0BB),
                          blurRadius: 20.0,
                          offset: Offset(0, 5)),
                    ]),
                child: Column(
                  children: <Widget>[
                    DividerWithText(
                      dividerText: _heading,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                        itemCount: _placesList.length,
                        itemBuilder: (BuildContext context, int index) =>
                          InkWell(
                          child: Container(
                            //color: Colors.red,
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: <Widget>[
                              Container(
                                // color: Colors.yellow,
                                padding:
                                    EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${_placesList[index].name}',
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.grey.shade500,
                                  ),
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                // color: Colors.yellow,
                                padding:
                                    EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                          ),
                          onTap: () async {

                          //List<double> geoReference = await getLocationGeoRef(_placesList[index].placeId);
                          // widget.trip.title = _placesList[index].name;
                          // widget.trip.photoReference = photoReference;

                          // setState(() {
                          //   _sessionToken = null;
                          // });
                          Navigator.pop(context, _placesList[index]);
                          }
                        ),
                      ),
                  
                  ],
                ),
              )
            ],
          ),
        ),
        //),
      ),
      ),
    );
  }
}
