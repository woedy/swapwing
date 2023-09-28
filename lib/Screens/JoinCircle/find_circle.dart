
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Screens/MyTrades/trade_detail.dart';
import 'package:samahat_barter/Screens/UserProfile/other_user_profile.dart';
import 'package:samahat_barter/constants.dart';


class FindCircle extends StatefulWidget {
  static String routeName = "/my_trades";

  FindCircle({Key? key, this.title}) : super(key: key);
  String? title;

  @override
  _FindCircleState createState() => _FindCircleState();
}

class _FindCircleState extends State<FindCircle> {

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
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

                      Text("Find Circle", style: TextStyle(fontSize: 16),),
                      InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: Colors.white, size: 23,)),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.1))),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        //hintText: 'Enter Username/Email',

                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal),
                        labelText: "Search...",
                        labelStyle:
                        TextStyle(fontSize: 13, color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: InputBorder.none,),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(225)
                      ],
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      onSaved: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: Container(

                      child: ListView.builder(
                          itemCount: 10,

                          itemBuilder: (context, index) {
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OtherUserProfile()));

                                        },
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AssetImage('assets/images/user_profile.png'),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Mensah Sandra",
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "@akua_mensah",
                                                  style: TextStyle(color: Colors.white, ),
                                                ),
                                              ],
                                            ),
                                          ],
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
                                              width: 110,
                                              //height: 55,
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  color: barterPrimary2,
                                                  borderRadius: BorderRadius.circular(100)),
                                              child: Align(
                                                child: Container(
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Join Circle",
                                                        style: TextStyle(
                                                            fontSize: 12, color: barterPrimary),
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
                            );

                          })
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }





}
