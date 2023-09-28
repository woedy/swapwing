

import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Listings/models/all_listings_model.dart';
import 'package:samahat_barter/constants.dart';

import 'other_user_item_details.dart';
import 'package:http/http.dart' as http;



Future<AllListingsModel> getAllListings() async {

  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  print(user_id);
  print(api_k);

  final response = await http.get(
    Uri.parse(hostName + '/api/listings/get-all-listings?user_id=' + user_id.toString()),
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
    return AllListingsModel.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 422) {
    print(jsonDecode(response.body));
    return AllListingsModel.fromJson(jsonDecode(response.body));
  }else if (response.statusCode == 404) {
    print(jsonDecode(response.body));
    return AllListingsModel.fromJson(jsonDecode(response.body));
  }else {

    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to load data.');
  }
}


class BrowseTradeScreen extends StatefulWidget {
  BrowseTradeScreen({Key? key}) : super(key: key);

  @override
  _BrowseTradeScreenState createState() => _BrowseTradeScreenState();
}

class _BrowseTradeScreenState extends State<BrowseTradeScreen> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;

  var columnCount = 2;
  Future<AllListingsModel>? _futureAllListings;


  @override
  void initState() {
    _futureAllListings = getAllListings();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return (_futureAllListings == null) ? buildColumn() : buildFutureBuilder();



  }


  Widget buildColumn() {
    return Scaffold(
      body: Container(),
    );

  }

  FutureBuilder<AllListingsModel> buildFutureBuilder() {
    return FutureBuilder<AllListingsModel>(
      future: _futureAllListings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: PopOutCard(subject: 'Connecting..', message: "Please wait..", icon: Icons.downloading,)

          );
        } else if (snapshot.hasData) {

          var data = snapshot.data!;

          if(data.response == "Successful") {
            return Scaffold(
              body: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height - 2,
                  child: AnimationLimiter(
                    child: Column(
                      children: [
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
                              Text("Browse Trades", style: TextStyle(fontSize: 16),),
                              Row(
                                children: [
                                  Icon(Icons.filter_alt_outlined, color: Colors.white, size: 23,),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(Icons.heart_broken, color: Colors.white, size: 23,),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(Icons.map, color: Colors.white, size: 23,),

                                ],
                              )
                            ],
                          ),
                        ),

                        Container(
                            height: 120,
                            //color: Colors.grey.withOpacity(0.15),
                            child: ListView.builder(
                                itemCount: data.data!.allPremiumItems!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final itemData = data.data!.allItems![index];

                                  return Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => OtherItemDetail(item_id: itemData.itemId!.toString(),),
                                            ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundImage: NetworkImage(hostName + itemData.garageItemImages!.image.toString()),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              itemData.distance.toString() + " km",
                                              style: TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );

                                })
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 230,
                          child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7// Number of columns
                              ),
                              itemCount: data.data!.allItems!.length,
                              itemBuilder: (context, index){
                                final itemData = data.data!.allItems![index];

                                return AnimationConfiguration.staggeredGrid(
                                  columnCount: 2,
                                  position: index,
                                  duration:  Duration(milliseconds: 375),
                                  child: ScaleAnimation(
                                    scale: 0.5,
                                    child: FadeInAnimation(
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OtherItemDetail(item_id: itemData.itemId!.toString(),),
                                              ));
                                        },
                                        child: Container(
                                          //height: 350,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 200,
                                                margin:  EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                                                decoration:  BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(hostName + itemData.garageItemImages!.image!.toString()), fit: BoxFit.cover),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4.0,
                                                      offset: Offset(0.0, 4.0),
                                                    ),
                                                  ],
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      padding: EdgeInsets.all(3),
                                                      //color: Colors.black.withOpacity(0.3),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          CircleAvatar(
                                                            backgroundImage: NetworkImage(hostName + itemData.garageItemImages!.image.toString()),
                                                          ),
                                                          SizedBox(
                                                            width: 60,
                                                          ),
                                                          Text(
                                                            itemData.distance.toString() + "km",
                                                            style: TextStyle(color: Colors.white),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                        bottom: 0,
                                                        child: Container(
                                                          height: 40,
                                                          width: MediaQuery.of(context).size.width,
                                                          padding: EdgeInsets.all(3),
                                                          color: Colors.black.withOpacity(0.3),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "Ends in " + itemData.endsIn.toString() + " Days",
                                                                style: TextStyle(color: Colors.white),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              if(itemData.itemOwner!.userPersonalInfo!.isOnline == true)...[
                                                                Container(
                                                                  height: 15,
                                                                  width: 15,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.green,
                                                                      borderRadius: BorderRadius.circular(100)),
                                                                )
                                                              ]

                                                            ],
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.all(10),


                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(itemData.itemName!.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(itemData.bidStarts.toString()),
                                                    ],
                                                  )),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                              }
                          )
                        ),
                      ],
                    ),
                  ),
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

}

