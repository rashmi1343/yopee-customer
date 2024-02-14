import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Presenter/YopeeProvider.dart';
import 'Home/Dashboard.dart';

class GoogleMapScreen extends StatefulWidget {
  double lat;
  double long;

  @override
  GoogleMapScreenState createState() => GoogleMapScreenState();

  GoogleMapScreen({
    required this.lat,
    required this.long,
  });
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  //final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);

  Set<Marker> markers = Set(); //markers for google map

  int numDeltas = 50; //number of delta to devide total distance
  int delay = 50; //milliseconds of delay to pass each delta
  var i = 0;
  double? deltaLat;
  double? deltaLng;
  var position; //position variable while moving marker

  @override
  void initState() {
    position = [
      LatLng(widget.lat, widget.long).latitude,
      LatLng(widget.lat, widget.long).longitude
    ];

    getLocationName();

    addMarkers();
    super.initState();
  }

  Future<void> getLocationName() async {
    Provider.of<YopeeProvider>(context, listen: false).placemarks =
        await placemarkFromCoordinates(widget.lat, widget.long);
    setState(() {
      //get place name from lat and lang
      Provider.of<YopeeProvider>(context, listen: false).location =
          Provider.of<YopeeProvider>(context, listen: false)
                  .placemarks
                  .first
                  .street
                  .toString() +
              ", " +
              Provider.of<YopeeProvider>(context, listen: false)
                  .placemarks
                  .first
                  .locality
                  .toString() +
              ", " +
              Provider.of<YopeeProvider>(context, listen: false)
                  .placemarks
                  .first
                  .subLocality
                  .toString() +
              ", " +
              Provider.of<YopeeProvider>(context, listen: false)
                  .placemarks
                  .first
                  .administrativeArea
                  .toString() +
              ", " +
              Provider.of<YopeeProvider>(context, listen: false)
                  .placemarks
                  .first
                  .postalCode
                  .toString();
    }); //initial position of moving marker
  }

  addMarkers() async {
    markers.add(
      Marker(
        onTap: () {
          print('Tapped');
        },
        draggable: true,
        markerId: MarkerId(LatLng(widget.lat, widget.long).toString()),
        position: LatLng(widget.lat, widget.long),
        icon: BitmapDescriptor.defaultMarker,
        // onDragStart: ((newPosition) async {
        //   print("Old Lat:${widget.lat}");
        //   print("Old Long:${widget.long}");
        //   List<Placemark> placemarks =
        //       await placemarkFromCoordinates(widget.lat, widget.long);
        //   setState(() {
        //     //get place name from lat and lang
        //     location = placemarks.first.street.toString() +
        //         ", " +
        //         placemarks.first.locality.toString() +
        //         ", " +
        //         placemarks.first.subLocality.toString() +
        //         ", " +
        //         placemarks.first.administrativeArea.toString() +
        //         ", " +
        //         placemarks.first.postalCode.toString();
        //   });
        // }),
        onDragEnd: ((newPosition) async {
          print("New Lat:${newPosition.latitude}");
          print("New Long:${newPosition.longitude}");
          Provider.of<YopeeProvider>(context, listen: false).placemarks =
              await placemarkFromCoordinates(
                  newPosition.latitude, newPosition.longitude);
          setState(() {
            //get place name from lat and lang
            Provider.of<YopeeProvider>(context, listen: false).location =
                Provider.of<YopeeProvider>(context, listen: false)
                        .placemarks
                        .first
                        .street
                        .toString() +
                    ", " +
                    Provider.of<YopeeProvider>(context, listen: false)
                        .placemarks
                        .first
                        .locality
                        .toString() +
                    ", " +
                    Provider.of<YopeeProvider>(context, listen: false)
                        .placemarks
                        .first
                        .subLocality
                        .toString() +
                    ", " +
                    Provider.of<YopeeProvider>(context, listen: false)
                        .placemarks
                        .first
                        .administrativeArea
                        .toString() +
                    ", " +
                    Provider.of<YopeeProvider>(context, listen: false)
                        .placemarks
                        .first
                        .postalCode
                        .toString();
          });
        }),
      ),
    );

    setState(() {
      //refresh UI
    });
  }

  transition(result) {
    i = 0;
    deltaLat = (result[0] - position[0]) / numDeltas;
    deltaLng = (result[1] - position[1]) / numDeltas;
    moveMarker();
  }

  moveMarker() {
    position[0] += deltaLat;
    position[1] += deltaLng;
    var latlng = LatLng(position[0], position[1]);

    markers = {
      Marker(
        markerId: MarkerId("movingmarker"),
        position: latlng,
        icon: BitmapDescriptor.defaultMarker,
      )
    };

    setState(() {
      //refresh UI
    });

    if (i != numDeltas) {
      i++;
      Future.delayed(Duration(milliseconds: delay), () {
        moveMarker();
      });
    }
  }

  // void initState() {
  //   super.initState();
  //   _markers.add(Marker(
  //     // This marker id can be anything that uniquely identifies each marker.
  //     markerId: MarkerId(LatLng(widget.lat, widget.long).toString()),
  //     position: LatLng(widget.lat, widget.long),
  //     infoWindow: InfoWindow(
  //       title: 'Really cool place',
  //       snippet: '5 Star Rating',
  //     ),
  //     icon: BitmapDescriptor.defaultMarker,
  //   ));
  // }
  Future<bool> willPopCallback() async {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => Dashboard(),
      // transitionsBuilder: (BuildContext
      // context,
      //     Animation<double> animation,
      //     Animation<double>
      //     secondaryAnimation,
      //     Widget child) {
      //   return new SlideTransition(
      //     position: new Tween<Offset>(
      //       //Left to right
      //       begin: const Offset(-1.0, 0.0),
      //       end: Offset.zero,
      //
      //       //Right to left
      //       // begin:
      //       // const Offset(1.0, 0.0),
      //       // end: Offset.zero,
      //
      //       //top to bottom
      //       // begin: const Offset(0.0, -1.0),
      //       // end: Offset.zero,
      //
      //       //   bottom to top
      //       // begin: Offset(0.0, 1.0),
      //       // end: Offset.zero,
      //     ).animate(animation),
      //     child: child,
      //   );
      // }
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: page,
        );
      },
    ));
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback,
      child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0xff00000029),
                  offset: Offset(0, 0.0),
                  blurRadius: 6.0,
                )
              ]),
              child: AppBar(
                elevation: 4,
                shadowColor: Color(0xff00000029),
                toolbarHeight: 53,
                leading: IconButton(
                  iconSize: 25,
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    // Provider.of<YopeeProvider>(context, listen: false)
                    //     .setChangeLocation(
                    //         true,
                    //         Provider.of<YopeeProvider>(context, listen: false)
                    //             .location,
                    //         Provider.of<YopeeProvider>(context, listen: false)
                    //             .placemarks);
                    Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Dashboard(),
                      // transitionsBuilder: (BuildContext
                      // context,
                      //     Animation<double> animation,
                      //     Animation<double>
                      //     secondaryAnimation,
                      //     Widget child) {
                      //   return new SlideTransition(
                      //     position: new Tween<Offset>(
                      //       //Left to right
                      //       begin: const Offset(-1.0, 0.0),
                      //       end: Offset.zero,
                      //
                      //       //Right to left
                      //       // begin:
                      //       // const Offset(1.0, 0.0),
                      //       // end: Offset.zero,
                      //
                      //       //top to bottom
                      //       // begin: const Offset(0.0, -1.0),
                      //       // end: Offset.zero,
                      //
                      //       //   bottom to top
                      //       // begin: Offset(0.0, 1.0),
                      //       // end: Offset.zero,
                      //     ).animate(animation),
                      //     child: child,
                      //   );
                      // }
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, page) {
                        var begin = 0.0;
                        var end = 1.0;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return ScaleTransition(
                          scale: animation.drive(tween),
                          child: page,
                        );
                      },
                    ));
                    //  Navigator.of(context).pushNamed('/dashboard');
                  },
                ),
                centerTitle: true,
                title: Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "SemiBold",
                      color: Color(0xff313131)),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
          body: Stack(children: [
            GoogleMap(
              //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true,
              myLocationEnabled: false, //enable Zoom in, out on map
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.long),
                zoom: 11.0,
              ),
              markers: markers,
              mapType: MapType.normal, //map type
            ),
            // Center(
            //   //picker image on google map
            //   child: Image.asset(
            //     "assets/images/picker.png",
            //     width: 80,
            //   ),
            // ),
            Positioned(
                //widget to display location name
                bottom: 80,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Card(
                    child: Container(
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            "assets/images/picker.svg",
                            color: Colors.red,
                            width: 25,
                          ),
                          title: Text(
                            "${Provider.of<YopeeProvider>(context, listen: false).location}",
                            style: TextStyle(
                                fontSize: 11.5,
                                fontFamily: "SemiBold",
                                color: Colors.black),
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              Provider.of<YopeeProvider>(context, listen: false)
                                  .setChangeLocation(
                                      true,
                                      Provider.of<YopeeProvider>(context,
                                              listen: false)
                                          .location,
                                      Provider.of<YopeeProvider>(context,
                                              listen: false)
                                          .placemarks);
                              Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 400),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Dashboard(),
                                // transitionsBuilder: (BuildContext
                                // context,
                                //     Animation<double> animation,
                                //     Animation<double>
                                //     secondaryAnimation,
                                //     Widget child) {
                                //   return new SlideTransition(
                                //     position: new Tween<Offset>(
                                //       //Left to right
                                //       begin: const Offset(-1.0, 0.0),
                                //       end: Offset.zero,
                                //
                                //       //Right to left
                                //       // begin:
                                //       // const Offset(1.0, 0.0),
                                //       // end: Offset.zero,
                                //
                                //       //top to bottom
                                //       // begin: const Offset(0.0, -1.0),
                                //       // end: Offset.zero,
                                //
                                //       //   bottom to top
                                //       // begin: Offset(0.0, 1.0),
                                //       // end: Offset.zero,
                                //     ).animate(animation),
                                //     child: child,
                                //   );
                                // }
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, page) {
                                  var begin = 0.0;
                                  var end = 1.0;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  return ScaleTransition(
                                    scale: animation.drive(tween),
                                    child: page,
                                  );
                                },
                              ));
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SemiBold",
                                  color: Colors.green),
                            ),
                          ),
                          dense: true,
                        )),
                  ),
                ))
          ])),
    );
  }
}
