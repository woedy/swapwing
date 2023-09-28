import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Screens/Garage/services/my_services.dart';
import 'package:samahat_barter/Screens/Listings/models/listing_detail.dart';
import 'package:samahat_barter/Screens/Listings/other_user_garage.dart';
import 'package:samahat_barter/Screens/UserProfile/other_user_profile.dart';
import 'package:samahat_barter/Screens/Listings/no_reactions.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;


Future<ListingDetailModel> getListingDetails(String item_id) async {


  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  print(user_id);
  print(api_k);

  final response = await http.get(
    Uri.parse(hostName + '/api/listings/listing-detail?user_id=' + user_id.toString() + '&item_id=' + item_id),
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
    print("################");
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    return ListingDetailModel.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 422) {
    print(jsonDecode(response.body));
    return ListingDetailModel.fromJson(jsonDecode(response.body));
  }else if (response.statusCode == 404) {
    print(jsonDecode(response.body));
    return ListingDetailModel.fromJson(jsonDecode(response.body));
  }else {

    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to load data.');
  }
}



class OtherItemDetail extends StatefulWidget {
  final item_id;
  const OtherItemDetail({Key? key, required this.item_id}) : super(key: key);

  @override
  State<OtherItemDetail> createState() => _OtherItemDetailState();
}



class _OtherItemDetailState extends State<OtherItemDetail> {
  Future<ListingDetailModel>? _futureListingDetails;

  @override
  void initState() {
    _futureListingDetails = getListingDetails(widget.item_id);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // Check the initial premium status of the item

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return buildColumn();
    //return (_futureListingDetails == null) ? buildColumn() : buildFutureBuilder();

  }



  Widget buildColumn(){
    return Scaffold(
      body: Container(

        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
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
                                Icon(Icons.star, color: Colors.white, size: 23,),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(Icons.list, color: Colors.white, size: 23,),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(Icons.delete, color: Colors.white, size: 23,),

                              ],
                            )
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 220,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/feen.png"),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),

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
                                              child: Text("Premium", style: TextStyle(color: barterPrimary, fontSize: 10),),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      )
                                  )



                                ],
                              ),

                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OtherUserProfile()));

                                    },
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundImage: AssetImage("assets/images/user_profile2.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Benard Newtons", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("benardnewtons@gmail.com", style: TextStyle(fontSize: 12, color: barterPrimary2), textAlign: TextAlign.center,),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("3.4km", style: TextStyle(fontSize: 12,), textAlign: TextAlign.center,),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OtherUserGarage()));

                                      },
                                      child: Align(
                                        child: Container(
                                          width: 130,
                                          //height: 55,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: barterPrimary2,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: Align(
                                            child: Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "View Garage",
                                                    style: TextStyle(
                                                        fontSize: 11, color: barterPrimary),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        color: Colors.grey.withOpacity(0.2),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NoReactionPage()));

                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Wrap(
                                      children: [
                                        Text("The Item name here", style: TextStyle(color: barterPrimary2, fontSize: 18, fontWeight: FontWeight.w600),),
                                      ],
                                    )
                                ),
                                Center(
                                    child: Wrap(
                                      children: [
                                        Text("8 person reacting to this", style: TextStyle(color: Colors.white, fontSize: 11,),),
                                      ],
                                    )
                                ),
                              ],
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
                        //color: Colors.grey.withOpacity(0.2),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
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
                                                image: AssetImage("assets/images/feen.png"),
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
                        //color: Colors.grey.withOpacity(0.2),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
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
                                          color: barterPrimary2,
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
                              subtitle: Text("Info here", style: TextStyle(color: Colors.white),),
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
                              subtitle: Text("Info here" + "% Good", style: TextStyle(color: Colors.white),),
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
                              subtitle: Text("Info here", style: TextStyle(color: Colors.white),),
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
                              subtitle: Text("Info here", style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
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
                                      child: Text("Info here", style: TextStyle(color: Colors.white, )),
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

              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Container(
                //color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Container(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: barterPrimary2,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.video_camera_back, color: barterPrimary,),
                            Icon(Icons.star, color: Colors.yellow, size: 15,),
                            SizedBox(
                              width: 5,
                            ),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: barterPrimary2,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.call, color: barterPrimary,),
                            Icon(Icons.star, color: Colors.yellow, size: 15,),
                            SizedBox(
                              width: 5,
                            ),

                          ],
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePageScreen()));

                        },
                        child: Align(
                          child: Container(
                            //width: 384,
                            //height: 55,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              //color: barterPrimary2,
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff08bf98),
                                  Color(0xff10141e),
                                ],
                              ),
                            ),
                            child: Align(
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.thumb_up, color: Colors.white, size: 12,),
                                        SizedBox(
                                          width: 10 ,
                                        ),
                                        Text(
                                          "Propose Trade",
                                          style: TextStyle(
                                            fontSize: 12, color: Colors.white,),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }


  FutureBuilder<ListingDetailModel> buildFutureBuilder() {

    return FutureBuilder<ListingDetailModel>(
      future: _futureListingDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: PopOutCard(subject: 'Connecting..', message: "Please wait..", icon: Icons.downloading,)

          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          var item_detail = data.data!.listingDetail!;

          if(data.response == "Successful") {

            print("OOOOOOOOOOOOOOOOOOO");
            return Scaffold(
              body: Container(

                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
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
                                        Icon(Icons.star, color: Colors.white, size: 23,),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.list, color: Colors.white, size: 23,),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.delete, color: Colors.white, size: 23,),

                                      ],
                                    )
                                  ],
                                ),
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 220,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: AssetImage("assets/images/feen.png"),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),

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
                                                      child: Text("Premium", style: TextStyle(color: barterPrimary, fontSize: 10),),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          )



                                        ],
                                      ),

                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OtherUserProfile()));

                                            },
                                            child: CircleAvatar(
                                              radius: 45,
                                              backgroundImage: AssetImage("assets/images/user_profile2.png"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("Benard Newtons", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("benardnewtons@gmail.com", style: TextStyle(fontSize: 12, color: barterPrimary2), textAlign: TextAlign.center,),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("3.4km", style: TextStyle(fontSize: 12,), textAlign: TextAlign.center,),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OtherUserGarage()));

                                              },
                                              child: Align(
                                                child: Container(
                                                  width: 130,
                                                  //height: 55,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: barterPrimary2,
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: Align(
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "View Garage",
                                                            style: TextStyle(
                                                                fontSize: 11, color: barterPrimary),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                color: Colors.grey.withOpacity(0.2),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NoReactionPage()));

                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Wrap(
                                              children: [
                                                Text("The Item name here", style: TextStyle(color: barterPrimary2, fontSize: 18, fontWeight: FontWeight.w600),),
                                              ],
                                            )
                                        ),
                                        Center(
                                            child: Wrap(
                                              children: [
                                                Text("8 person reacting to this", style: TextStyle(color: Colors.white, fontSize: 11,),),
                                              ],
                                            )
                                        ),
                                      ],
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
                                //color: Colors.grey.withOpacity(0.2),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
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
                                                        image: AssetImage("assets/images/feen.png"),
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
                                //color: Colors.grey.withOpacity(0.2),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 8,
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
                                                  color: barterPrimary2,
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
                                      subtitle: Text("Info here", style: TextStyle(color: Colors.white),),
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
                                      subtitle: Text("Info here" + "% Good", style: TextStyle(color: Colors.white),),
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
                                      subtitle: Text("Info here", style: TextStyle(color: Colors.white),),
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
                                      subtitle: Text("Info here", style: TextStyle(fontStyle:FontStyle.italic, color: Colors.white),),
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
                                              child: Text("Info here", style: TextStyle(color: Colors.white, )),
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

                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: Container(
                        //color: Colors.grey[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Container(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: barterPrimary2,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.video_camera_back, color: barterPrimary,),
                                    Icon(Icons.star, color: Colors.yellow, size: 15,),
                                    SizedBox(
                                      width: 5,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: barterPrimary2,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.call, color: barterPrimary,),
                                    Icon(Icons.star, color: Colors.yellow, size: 15,),
                                    SizedBox(
                                      width: 5,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePageScreen()));

                                },
                                child: Align(
                                  child: Container(
                                    //width: 384,
                                    //height: 55,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      //color: barterPrimary2,
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xff08bf98),
                                          Color(0xff10141e),
                                        ],
                                      ),
                                    ),
                                    child: Align(
                                      child: Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.thumb_up, color: Colors.white, size: 12,),
                                                SizedBox(
                                                  width: 10 ,
                                                ),
                                                Text(
                                                  "Propose Trade",
                                                  style: TextStyle(
                                                    fontSize: 12, color: Colors.white,),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
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
