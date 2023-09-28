import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Garage/items/my_garage.dart';
import 'package:samahat_barter/Screens/Garage/models/item_detail_model.dart';
import 'package:samahat_barter/Screens/Garage/services/my_services.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;


Future<GarageItemDetailModel> getItemDetails(String item_id) async {

  print("###########");
  print("LOAAADDD....");

  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  print(user_id);
  print(api_k);

  final response = await http.get(
    Uri.parse(hostName + '/api/garage/garage-item-detail?user_id=' + user_id.toString() + '&item_id=' + item_id),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token ' + api_k.toString()
    },
  );

  if (response.statusCode == 200) {
    // If the server returned a 200 OK response,
    // then parse the JSON.
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    return GarageItemDetailModel.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 422) {
    print(jsonDecode(response.body));
    return GarageItemDetailModel.fromJson(jsonDecode(response.body));
  }else if (response.statusCode == 404) {
    print(jsonDecode(response.body));
    return GarageItemDetailModel.fromJson(jsonDecode(response.body));
  }else {

    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to login.');
  }
}



class GarageItemDetail extends StatefulWidget {
  final item_id;
  const GarageItemDetail({Key? key, required this.item_id}) : super(key: key);

  @override
  State<GarageItemDetail> createState() => _GarageItemDetailState();
}

class _GarageItemDetailState extends State<GarageItemDetail> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  Future<GarageItemDetailModel>? _futureItemDetails;

  bool isPremium = false;
  bool isListed = false;
  bool hidden = false;
  bool auto_relist = false;

  @override
  void initState() {
    _futureItemDetails = getItemDetails(widget.item_id);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // Check the initial premium status of the item
    _futureItemDetails?.then((value) {
      setState(() {
        isPremium = value.data!.garageItemDetail!.isPremium ?? false;
        isListed = value.data!.garageItemDetail!.isListed ?? false;
        hidden = value.data!.garageItemDetail!.hidden ?? false;
        auto_relist = value.data!.garageItemDetail!.autoRelist ?? false;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return (_futureItemDetails == null) ? buildColumn() : buildFutureBuilder();

  }


  Widget buildColumn(){
    return Scaffold(
      body: Container(),
    );
  }



  FutureBuilder<GarageItemDetailModel> buildFutureBuilder() {

    return FutureBuilder<GarageItemDetailModel>(
      future: _futureItemDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: PopOutCard(subject: 'Connecting..', message: "Please wait..", icon: Icons.downloading,)

          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          var item_detail = data.data!.garageItemDetail!;

          if(data.response == "Successful") {

            print("OOOOOOOOOOOOOOOOOOO");
            return Scaffold(
              body: Container(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.backspace_sharp, color: Colors.white, size: 23,)),
                          Text("Item Details", style: TextStyle(fontSize: 16),),
                          Row(
                            children: [
                              if (hidden)
                                InkWell(
                                    onTap: (){
                                      _hideShowItem();
                                    },
                                    child: Icon(Icons.remove_red_eye, color: barterPrimary2, size: 23,))
                              else
                                InkWell(
                                    onTap: (){
                                      _hideShowItem();
                                    },
                                    child: Icon(Icons.remove_red_eye, color: Colors.grey, size: 23,)),
                              SizedBox(
                                width: 15,
                              ),
                              if (isPremium)
                                InkWell(
                                  onTap: (){
                                    _set_premium();
                                  },
                                    child: Icon(Icons.star, color: Colors.yellow, size: 23,))
                              else
                                InkWell(
                                  onTap: (){
                                    _set_premium();
                                  },
                                    child: Icon(Icons.star, color: Colors.grey, size: 23,)),

                              SizedBox(
                                width: 15,
                              ),
                              if (isListed)
                                InkWell(
                                    onTap: (){
                                      _set_listed();
                                    },
                                    child: Icon(Icons.list, color: Colors.green, size: 23,))
                              else
                                InkWell(
                                    onTap: (){
                                      _set_listed();
                                    },
                                    child: Icon(Icons.list, color: Colors.grey, size: 23,)),


                              SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () async {
                                  await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Confirmation', style: TextStyle(color: Colors.red),),
                                      content: Text('Are you sure you want to delete?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop(false); // Return false to indicate cancellation
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Delete', style: TextStyle(color: Colors.red)),
                                          onPressed: () {
                                            _deleteItem();
                                          },
                                        ),
                                      ],
                                    );;
                                  },
                                  );
                                },
                                  child: Icon(Icons.delete, color: Colors.red, size: 23,)),

                            ],
                          )
                        ],
                      ),
                    ),

                    Container(
                      height: 220,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(hostName + data.data!.garageItemDetail!.garageItemImages![0].image!.toString()),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Positioned(
                              bottom: 5,
                              child: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Text(data.data!.garageItemDetail!.itemName.toString(),style: TextStyle(shadows: [
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ]),),
                                ),
                              )
                          ),


                            Positioned(
                              top: 10,
                              left: 10,
                              child: AnimatedOpacity(
                                opacity: isPremium ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Icon(Icons.star, size: 10),
                                      SizedBox(width: 2),
                                      Center(
                                        child: Text(
                                          "Premium",
                                          style: TextStyle(
                                            color: barterPrimary,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,

                            child: AnimatedOpacity(
                              opacity: hidden ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 500),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                //margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  //borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    "Hidden Item",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20, fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                            Positioned(
                            top: 10,
                            //left: 10,
                            right: 10,
                            child: AnimatedOpacity(
                              opacity: isListed ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 500),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Icon(Icons.list, size: 10, color: Colors.white,),
                                    SizedBox(width: 2),
                                    Center(
                                      child: Text(
                                        "Listed",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      color: Colors.grey.withOpacity(0.2),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Reactions", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: barterPrimary2,
                                                      borderRadius: BorderRadius.circular(50)
                                                  ),
                                                  child: Text("Join Auction", style: TextStyle(color: Colors.white, fontSize: 12 ),)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: item_detail.reactions!.length,
                                              itemBuilder: (context, index){
                                                return ListTile(
                                                  title: Text(item_detail.reactions![index].firstName!.toString() + " " +item_detail.reactions![index].lastName!.toString()),
                                                  leading: CircleAvatar(
                                                    backgroundImage: NetworkImage(hostName + item_detail.reactions![index].userPersonalInfo!.photo!.toString()),
                                                  ),
                                                  subtitle: Text(item_detail.reactions![index].username.toString()),
                                                );
                                              }
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                }
                            );

                          },
                          child: Center(
                              child: Wrap(
                                children: [
                                  Text(data.data!.garageItemDetail!.reactions!.length.toString()+ " person reacting to this"),
                                ],
                              )
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      color: Colors.grey.withOpacity(0.2),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Comments", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: item_detail.garageItemComments!.length,
                                              itemBuilder: (context, index){
                                                return ListTile(
                                                  title: Text(item_detail.garageItemComments![index].user!.firstName!.toString() + " " +item_detail.garageItemComments![index].user!.lastName!.toString()),
                                                  leading: CircleAvatar(
                                                    backgroundImage: NetworkImage(hostName + item_detail.garageItemComments![index].user!.userPersonalInfo!.photo.toString()),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(item_detail.garageItemComments![index].comment.toString()),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(convertToTimeAgo(item_detail.garageItemComments![index].createdAt.toString()), style: TextStyle(fontSize: 12),),
                                                    ],
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                }
                            );

                          },
                          child: Center(
                              child: Wrap(
                                children: [
                                  Text(item_detail.garageItemComments!.length.toString() + " comments"),
                                ],
                              )
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Text("Images"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      color: Colors.grey.withOpacity(0.2),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.data!.garageItemDetail!.garageItemImages!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                decoration: BoxDecoration(
                                  // color: youPrimaryColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                margin: EdgeInsets.all(5),
                                width: 100,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: (){


                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(hostName + data.data!.garageItemDetail!.garageItemImages![index].image!.toString()),
                                              fit: BoxFit.cover
                                          )
                                      ),

                                    ),
                                  ),
                                ));
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Videos"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      color: Colors.grey.withOpacity(0.2),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.data!.garageItemDetail!.garageItemVideos!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                decoration: BoxDecoration(
                                  // color: youPrimaryColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                margin: EdgeInsets.all(5),
                                width: 100,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.play_circle_fill, color: Colors.white,),
                                      ),

                                    ),
                                  ),
                                ));
                          }),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Text("Infos"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      //height: 500,
                      color: Colors.grey.withOpacity(0.2),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text("Item categories", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    for (var item in item_detail.itemCategory!)
                                      Text(item.categoryName.toString() + ", ", style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){

                                },
                                child: Icon(Icons.edit, color: barterPrimary2,),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text("Quality", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(item_detail.quality!.toString(), style: TextStyle(color: Colors.white),),
                              ],
                            ),

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text("Description", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(item_detail.description!.toString(), style: TextStyle(color: Colors.white),),
                              ],
                            ),

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text("Reason", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(item_detail.reason!.toString(), style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
                              ],
                            ),

                          ),

                          SizedBox(
                            height: 10,
                          ),

                          ListTile(
                            title: Text("Bid info", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Bid Starts at: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                        Text(item_detail.bidStarts!.toString(), style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Duration: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                        Text(item_detail.duration!.toString() + " Days", style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(" ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Days left: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                        Text(item_detail.duration!.toString() + " Days", style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
                                      ],
                                    ),
                                  ],
                                ),


                                ListTile(
                                  title: Text("Auto Relist", style: TextStyle(color: Colors.white,)),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if(auto_relist == true)...[
                                        InkWell(
                                            onTap: (){
                                              setState(() {
                                                auto_relist = !auto_relist!;
                                              });
                                            },
                                            child: Icon(Icons.check_box, color: barterPrimary2,)),
                                      ]else...[
                                        InkWell(
                                            onTap: (){
                                              setState(() {
                                                auto_relist = !auto_relist!;
                                              });
                                            },
                                            child: Icon(Icons.check_box_outline_blank, color: Colors.white,)),

                                      ]
                                    ],
                                  ),

                                ),
                              ],
                            ),

                          ),


                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text("Counter Info", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),

                                Wrap(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [


                                    if(item_detail.withAnything! == true)...[
                                      Text("With Anything.", style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
                                    ]else...[
                                      for(var item in item_detail.canCounterItem!)...[
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: barterPrimary2,
                                            borderRadius: BorderRadius.circular(50)
                                          ),
                                            child: Text(item.itemName!.toString(), style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),)),

                                      ]
                                    ]
                                  ],
                                ),
                              ],
                            ),

                          ),


                          SizedBox(
                            height: 10,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text("Meet up location", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(item_detail.meetUpLoc.toString(), style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
                                  ],
                                ),

                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 200,
                                color: Colors.grey.withOpacity(0.2),
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: _kGooglePlex,
                                  onMapCreated: (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                ),

                              ),
                            ],
                          ),


                          SizedBox(
                            height: 50,
                          ),




                        ],
                      ),


                    )
                    // ...... other list children.
                  ],
                ),
              ),

            );

          }

          else if (data.response == "Error") {
            return Scaffold(
              body: Container(
                child: Center(
                  child: Text("Failed to load data."),
                ),
              ),
            );

          }


        } else if (snapshot.hasError) {

          return Scaffold(
            body: Container(
              child: Center(
                child: Text("Unable to connect to server."),
              ),
            ),
          );


        }

        return const SizedBox();
      },
    );
  }

  void _set_premium() async {
    try {
      // Call the API to set or unset the item as premium based on the current status
      if (isPremium) {
        await setPremiumStatus(widget.item_id);
      } else {
        await setPremiumStatus(widget.item_id);
      }
      setState(() {
        isPremium = !isPremium; // Toggle the premium status
      });
    } catch (e) {
      print('Failed to toggle premium status: $e');
      // Handle the error, show a toast, or display an error message
    }
  }


  void _set_listed() async {
    try {
      if (isListed) {
        await setListedStatus(widget.item_id);
      } else {
        await setListedStatus(widget.item_id);
      }
      setState(() {
        isListed = !isListed; // Toggle the premium status
      });
    } catch (e) {
      print('Failed to toggle listed status: $e');
      // Handle the error, show a toast, or display an error message
    }
  }

  void _deleteItem() async {
    try {
      // Perform the delete operation
      await deleteItem(widget.item_id);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyGarage()),
      );

    } catch (e) {
      print('Failed to delete item: $e');
      // Handle the error, show a toast, or display an error message
    }
  }


  void _hideShowItem() async {
    try {
      if (hidden) {
        await setHiddenStatus(widget.item_id);
      } else {
        await setHiddenStatus(widget.item_id);
      }
      setState(() {
        hidden = !hidden; // Toggle the premium status
      });
    } catch (e) {
      print('Failed to toggle hidden status: $e');
      // Handle the error, show a toast, or display an error message
    }
  }



}




Future<void> setPremiumStatus(String item_id) async {
  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  final response = await http.post(
    Uri.parse(hostName + '/api/garage/set-garage-item-premium'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token ' + api_k.toString()
    },
    body: jsonEncode(<String, dynamic>{
      'user_id': user_id.toString(),
      'item_id': item_id,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    // Return success response or necessary data if needed
  } else {
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to set item as premium.');
  }
}




Future<void> setListedStatus(String item_id) async {
  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  final response = await http.post(
    Uri.parse(hostName + '/api/garage/list-garage-item'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token ' + api_k.toString()
    },
    body: jsonEncode(<String, dynamic>{
      'user_id': user_id.toString(),
      'item_id': item_id,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    // Return success response or necessary data if needed
  } else {
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to set item as listed.');
  }
}


Future<void> deleteItem(String item_id) async {
  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  final response = await http.post(
    Uri.parse(hostName + '/api/garage/delete-garage-item'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token ' + api_k.toString()
    },
    body: jsonEncode(<String, dynamic>{
      'user_id': user_id.toString(),
      'item_id': item_id,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    // Return success response or necessary data if needed

  } else {
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to set item as listed.');
  }
}


Future<void> setHiddenStatus(String item_id) async {
  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  final response = await http.post(
    Uri.parse(hostName + '/api/garage/hide-show-garage-item'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token ' + api_k.toString()
    },
    body: jsonEncode(<String, dynamic>{
      'user_id': user_id.toString(),
      'item_id': item_id,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    // Return success response or necessary data if needed

  } else {
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to set item as hide/show.');
  }
}