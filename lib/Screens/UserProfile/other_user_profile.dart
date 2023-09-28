import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/Garage/services/my_services.dart';
import 'package:samahat_barter/Screens/Listings/other_user_garage.dart';
import 'package:samahat_barter/constants.dart';

class OtherUserProfile extends StatefulWidget {
  const OtherUserProfile({Key? key}) : super(key: key);

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  @override
  Widget build(BuildContext context) {
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
                            Text("Samantha's Profile", style: TextStyle(fontSize: 16),),
                            Row(
                              children: [
                                Icon(Icons.message, color: Colors.white, size: 23,),

                              ],
                            )
                          ],
                        ),
                      ),

                      Row(
                        children: [

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage("assets/images/user_profile2.png"),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Bernard Newtown", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("bernardnewton@gmail.com", style: TextStyle(fontSize: 12, color: barterPrimary2), textAlign: TextAlign.center,),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("3.4km", style: TextStyle(fontSize: 12,), textAlign: TextAlign.center,),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
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
                                                        "Join Circle",
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
                        height: 70,
                        color: Colors.grey.withOpacity(0.2),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Wrap(
                                          children: [
                                            Text("Trades Made", style: TextStyle(color: Colors.white, fontSize: 11,),),
                                          ],
                                        )
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                        child: Wrap(
                                          children: [
                                            Text("1343", style: TextStyle(color: barterPrimary2, fontSize: 18, fontWeight: FontWeight.w600),),
                                          ],
                                        )
                                    ),

                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Wrap(
                                          children: [
                                            Text("Rating", style: TextStyle(color: Colors.white, fontSize: 11,),),
                                          ],
                                        )
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                        child: Wrap(
                                          children: [
                                            Row(
                                              children: [
                                                Text("4.5", style: TextStyle(color: barterPrimary2, fontSize: 18, fontWeight: FontWeight.w600),),
                                                Icon(Icons.star, size: 12, color: Colors.yellow,)
                                              ],
                                            ),
                                          ],
                                        )
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Text("Personal Information"),
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
                              title: Text("Lives in", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                              title: Text("Gender", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                              title: Text("Abaout me", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                              title: Text("Desires", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

          ],
        ),
      ),

    );
  }
}
