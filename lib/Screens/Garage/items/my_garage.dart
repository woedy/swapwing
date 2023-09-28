import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_intro.dart';
import 'package:samahat_barter/Screens/Garage/models/user_garage_model.dart';
import 'package:samahat_barter/Screens/Garage/services/my_services.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;

import 'garage_item_details.dart';


Future<UserGarageModel> getUserGarage() async {

  print("###########");
  print("LOAAADDD....");

  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  print(user_id);
  print(api_k);

  final response = await http.get(
    Uri.parse(hostName + '/api/garage/user-garage?user_id=' + user_id.toString()),
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
    return UserGarageModel.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 422) {
    print(jsonDecode(response.body));
    return UserGarageModel.fromJson(jsonDecode(response.body));
  }else if (response.statusCode == 404) {
    print(jsonDecode(response.body));
    return UserGarageModel.fromJson(jsonDecode(response.body));
  }else {

    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to load data.');
  }
}


class MyGarage extends StatefulWidget {
  const MyGarage({Key? key}) : super(key: key);

  @override
  State<MyGarage> createState() => _MyGarageState();
}

class _MyGarageState extends State<MyGarage> {

  Future<UserGarageModel>? _futureUserGarage;

  @override
  void initState() {
   _futureUserGarage = getUserGarage();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return (_futureUserGarage == null) ? buildColumn() : buildFutureBuilder();



  }

  Widget buildColumn() {
    return Scaffold(
      body: Container(),
    );

  }



  FutureBuilder<UserGarageModel> buildFutureBuilder() {
    return FutureBuilder<UserGarageModel>(
      future: _futureUserGarage,
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
                body: Container(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Icon(Icons.close, color: Colors.white, size: 23,),
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                            ),
                            Text("My Garage", style: TextStyle(fontSize: 16),),
                            Row(
                              children: [
                                  InkWell(
                                    onTap: (){

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddItemIntro()),
                                      );
                                    },
                                      child: Icon(Icons.add_box, color: Colors.white, size: 23,)),
                               SizedBox(
                                  width: 15,
                                ),
                                if(data.data!.open == true)...[
                                  Icon(Icons.home_filled, color: Colors.yellow, size: 23,),
                                ]else...[
                                  Icon(Icons.home_filled, color: Colors.grey, size: 23,),

                                ]
                              ],
                            )
                          ],
                        ),
                      ),
                      if(data.data!.garageItems!.length == 0)...[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.ac_unit_outlined, color: Colors.white, size: 100,),
                              SizedBox(
                                height: 10,
                              ),
                              Text("You have no items available.")
                            ],
                          ),
                        )
                      ]else...[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10
                            ),
                            itemCount: data.data!.garageItems!.length,
                            itemBuilder: (BuildContext ctx, index) {

                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GarageItemDetail(item_id: data.data!.garageItems![index].itemId)));

                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    //color: Colors.green,
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            //color: Colors.blue,
                                              borderRadius: BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  image: NetworkImage(hostName + data.data!.garageItems![index].garageItemImages!.image.toString()),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 5,
                                            left: 5,
                                            right: 5,
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.3),
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Center(
                                                child: Text(data.data!.garageItems![index].itemName.toString(), style: TextStyle(shadows: [
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
                                          left: 5,
                                          right: 5,
                                          child: Container(
                                          //height: 40,
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Row(
                                                children: [
                                                  if(data.data!.garageItems![index].isListed == false)...[
                                                    Icon(Icons.list, size: 20, color: Colors.white,shadows: [
                                                      Shadow(
                                                        offset: Offset(1.0, 1.0),
                                                        blurRadius: 3.0,
                                                        color: Color.fromARGB(255, 0, 0, 0),
                                                      ),
                                                    ],),
                                                  ]else...[
                                                    Icon(Icons.list, size: 20, color: barterPrimary2,shadows: [
                                                      Shadow(
                                                        offset: Offset(1.0, 1.0),
                                                        blurRadius: 3.0,
                                                        color: Color.fromARGB(255, 0, 0, 0),
                                                      ),
                                                    ],),
                                                  ],
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  if(data.data!.garageItems![index].hidden == false)...[
                                                    Icon(Icons.remove_red_eye, size: 20, color: Colors.white,shadows: [
                                                      Shadow(
                                                        offset: Offset(1.0, 1.0),
                                                        blurRadius: 3.0,
                                                        color: Color.fromARGB(255, 0, 0, 0),
                                                      ),
                                                    ],),
                                                  ]else...[
                                                    Icon(Icons.remove_red_eye, size: 20, color: barterPrimary2,shadows: [
                                                      Shadow(
                                                        offset: Offset(1.0, 1.0),
                                                        blurRadius: 3.0,
                                                        color: Color.fromARGB(255, 0, 0, 0),
                                                      ),
                                                    ],),
                                                  ],

                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(data.data!.garageItems![index].reactions!.length.toString(), style: TextStyle(color: barterPrimary2, shadows: [
                                                    Shadow(
                                                      offset: Offset(1.0, 1.0),
                                                      blurRadius: 2.0,
                                                      color: Color.fromARGB(
                                                          255, 168, 168, 168),
                                                    ),
                                                  ]),)

                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                      ]
                    ],
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                  isExtended: true,

                  label: Text('My Services'),
                  backgroundColor: barterPrimary2,
                  onPressed: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyServices(data: data.data!.garageServices!),
                        ));


                  },
                )

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
