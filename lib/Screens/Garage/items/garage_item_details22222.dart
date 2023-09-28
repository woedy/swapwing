import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/popout_card.dart';
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
  Future<GarageItemDetailModel>? _futureItemDetails;


  @override
  void initState() {
    _futureItemDetails = getItemDetails(widget.item_id);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
                              if(data.data!.garageItemDetail!.isPremium! == true)...[
                                Icon(Icons.star, color: Colors.yellow, size: 23,),
                              ]else...[
                                Icon(Icons.star, color: Colors.grey, size: 23,),
                              ],
                              SizedBox(
                                width: 15,
                              ),
                              if(data.data!.garageItemDetail!.isListed! == true)...[
                                Icon(Icons.list, color: Colors.yellow, size: 23,),
                              ]else...[
                                Icon(Icons.list, color: Colors.grey, size: 23,),

                              ],

                              SizedBox(
                                width: 15,
                              ),
                              Icon(Icons.delete, color: Colors.red, size: 23,),

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

                          if(data.data!.garageItemDetail!.isPremium == true)...[
                            Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(Icons.star, size: 10,),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Center(
                                        child: Text("Premium", style: TextStyle(color: barterPrimary, fontSize: 11),),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                )
                            )
                          ]
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
                                  Text("20 comments"),
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
                            title: Text("Item type", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Text(item_detail.itemType!.toString(), style: TextStyle(color: Colors.white),),
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
                            subtitle: Text(item_detail.quality!.toString(), style: TextStyle(color: Colors.white),),
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
                            title: Text("Description", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Text(item_detail.description!.toString(), style: TextStyle(color: Colors.white),),
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
                            title: Text("Reason", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Text(item_detail.reason!.toString(), style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
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
                            title: Text("Primary Materials", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            subtitle: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.all(10),

                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: barterPrimary2
                                    ),
                                    child: Center(
                                      child: Text(item_detail.primaryMaterial!.toString(), style: TextStyle(color: Colors.white, )),
                                    ),
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


}
