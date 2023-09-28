
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:samahat_barter/constants.dart';

class MeetUpLocation extends StatefulWidget {
  final data;

  const MeetUpLocation({Key? key, required this.data}) : super(key: key);

  @override
  _MeetUpLocationState createState() => _MeetUpLocationState();
}



class _MeetUpLocationState extends State<MeetUpLocation> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  late String location = "Search Location";


  String? meetup_location = "";
  double? meetup_location_lat = 0.0;
  double? meetup_location_lng = 0.0;




  String? _currentAddress;
  Position? _currentPosition;




  Set<Marker> markers = Set();



  @override
  void initState() {
    get_user_location_marker();
    super.initState();
    _getCurrentPosition();

  }


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }


  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }


  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text("Meetup Location", style: TextStyle(fontSize: 15),),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            child: Stack(

              children: <Widget>[

                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    zoom: 14.4746,
                  ),
                  markers: markers, //markers to show on map
                  //polylines: Set<Polyline>.of(polylines.values),
                  onMapCreated: (controller) { //method called when map is created
                    setState(() {
                      mapController = controller;
                    });
                  },
                ),

                //search autoconplete input
                Form(
                  key: _formKey,
                  child: Positioned(  //search input bar
                      top:10,
                      right: 0,
                      left: 0,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: barterPrimary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(

                          children: [
                            Text("Enter your meetup location", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            SizedBox(height: 10),
                            InkWell(
                                onTap: () async {
                                  var place = await PlacesAutocomplete.show(
                                      context: context,
                                      apiKey: googleAPiKey,
                                      mode: Mode.overlay,
                                      types: [],
                                      strictbounds: false,
                                      //components: [Component(Component.locality, 'np')],
                                      //google_map_webservice package
                                      onError: (err){
                                        print(err);
                                      }
                                  );

                                  if(place != null){
                                    setState(() {
                                      meetup_location = place.description.toString();

                                    });

                                    //form google_maps_webservice package
                                    final plist = GoogleMapsPlaces(apiKey:googleAPiKey,
                                      apiHeaders: await GoogleApiHeaders().getHeaders(),
                                      //from google_api_headers package
                                    );
                                    String placeid = place.placeId ?? "0";
                                    final detail = await plist.getDetailsByPlaceId(placeid);
                                    final geometry = detail.result.geometry!;
                                    final lat = geometry.location.lat;
                                    final lang = geometry.location.lng;
                                    var newlatlang = LatLng(lat, lang);

                                    meetup_location_lat = lat;
                                    meetup_location_lng = lang;
                                    //move map camera to selected place with animation

                                   setState(() {
                                     mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));


                                     markers.add(Marker( //add start location marker
                                       markerId: MarkerId(newlatlang.toString()),
                                       position: LatLng(lat, lang), //position of marker
                                       infoWindow: const InfoWindow( //popup info
                                         title: 'Pick up location',
                                         snippet: 'Pick up location',
                                       ),
                                       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                                     ));
                                   });
                                  }
                                },
                                child:Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Card(
                                    child: Container(
                                        padding: EdgeInsets.all(0),
                                        width: MediaQuery.of(context).size.width - 40,
                                        child: ListTile(
                                          title:Text(meetup_location == "" ? _currentAddress! : meetup_location!.toString(), style: TextStyle(fontSize: 16),),
                                          trailing: Icon(Icons.location_on, color: Colors.green,),
                                          dense: true,
                                        )
                                    ),
                                  ),
                                )
                            ),


                          ],
                        ),
                      )
                  ),
                ),

           /*     Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: DefaultButton(
                      text: 'Continue',
                      press: () async {

                        _submitForm();




                      },
                    ),
                  ),
                ),*/


              ], //<Widget>[]
            ), //Stack
          ), //SizedBox
        ) //Center
    );
  }


  _submitForm() async {
    final form = _formKey.currentState;



    if (form!.validate()) {
      form.save();

      if (meetup_location == "") {
        widget.data.pickupLocationName = _currentAddress;
        widget.data.pickupLocationLat = _currentPosition!.latitude;
        widget.data.pickupLocationLng = _currentPosition!.longitude;
      } else if (meetup_location != "") {
        widget.data.pickupLocationName = meetup_location;
        widget.data.pickupLocationLat = meetup_location_lat.toString();
        widget.data.pickupLocationLng = meetup_location_lng.toString();
      }








     /* Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RecipientInfo(data: widget.data),

        ),
      );
*/

    }
  }

  void get_user_location_marker() {

    var newlatlang = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(newlatlang.toString()),
      position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), //position of marker
      infoWindow: const InfoWindow( //popup info
        title: 'Your Location ',
        snippet: 'Your location Marker',
      ),
      icon: BitmapDescriptor.defaultMarker,//Icon for Marker
    ));

    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 15)));

  }


}