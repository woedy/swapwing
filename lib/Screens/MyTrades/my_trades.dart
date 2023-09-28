
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/MyTrades/trade_detail.dart';
import 'package:samahat_barter/constants.dart';


class MyTrades extends StatefulWidget {
  static String routeName = "/my_trades";

  MyTrades({Key? key, this.title}) : super(key: key);
  String? title;

  @override
  _MyTradesState createState() => _MyTradesState();
}

class _MyTradesState extends State<MyTrades> {

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            //color: barterPrimary2,
            height: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("My Trades", style: TextStyle(fontSize: 16),),
                      Row(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.close, color: Colors.white, size: 23,)),
                        ],
                      )
                    ],
                  ),
                ),

                TabBar(
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: barterPrimary2),
                  indicatorWeight: 0,
                  tabs: [
                    Tab(text: "Sent"),
                    Tab(text: "Received"),
                    Tab(text: "Trades Made"),

                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index){

                              return InkWell(

                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TradeDetail(),
                                        ));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child:  Container(
                                                padding: EdgeInsets.all(15),
                                                height: 250,
                                                color: Colors.grey.withOpacity(0.3),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: AssetImage('assets/images/user_profile.png'),

                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("You")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 170,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage('assets/images/feen.png'),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),               )
                                                  ],
                                                ),
                                              )),
                                              Expanded(child:  Container(
                                                padding: EdgeInsets.all(15),
                                                height: 250,
                                                color: Colors.grey.withOpacity(0.3),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: AssetImage('assets/images/user_profile.png'),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("Kwame")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 170,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage('assets/images/user_profile.png'),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),               )
                                                  ],
                                                ),
                                              )),

                                            ],
                                          ),
                                          Positioned(
                                              child: Container(
                                                height: 100,
                                                width:100,
                                                decoration: BoxDecoration(

                                                    image: DecorationImage(
                                                        image: AssetImage("assets/icons/sent2.png")
                                                    )
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("Can i have this.. it looks good."),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("12-01-23"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index){

                              return InkWell(

                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TradeDetail(),
                                        ));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child:  Container(
                                                padding: EdgeInsets.all(15),
                                                height: 250,
                                                color: Colors.grey.withOpacity(0.3),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: AssetImage('assets/images/user_profile.png'),

                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("You")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 170,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage('assets/images/feen.png'),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),               )
                                                  ],
                                                ),
                                              )),
                                              Expanded(child:  Container(
                                                padding: EdgeInsets.all(15),
                                                height: 250,
                                                color: Colors.grey.withOpacity(0.3),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: AssetImage('assets/images/user_profile.png'),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("Kwame")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 170,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage('assets/images/user_profile.png'),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),               )
                                                  ],
                                                ),
                                              )),

                                            ],
                                          ),
                                          Positioned(
                                              child: Container(
                                                height: 100,
                                                width:100,
                                                decoration: BoxDecoration(

                                                    image: DecorationImage(
                                                        image: AssetImage("assets/icons/sent2.png")
                                                    )
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("Can i have this.. it looks good."),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("12-01-23"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index){

                              return InkWell(

                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TradeDetail(),
                                        ));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(child:  Container(
                                                padding: EdgeInsets.all(15),
                                                height: 250,
                                                color: Colors.grey.withOpacity(0.3),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: AssetImage('assets/images/user_profile.png'),

                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("You")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 170,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage('assets/images/feen.png'),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),               )
                                                  ],
                                                ),
                                              )),
                                              Expanded(child:  Container(
                                                padding: EdgeInsets.all(15),
                                                height: 250,
                                                color: Colors.grey.withOpacity(0.3),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: AssetImage('assets/images/user_profile.png'),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("Kwame")
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 170,
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage('assets/images/user_profile.png'),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),               )
                                                  ],
                                                ),
                                              )),

                                            ],
                                          ),
                                          Positioned(
                                              child: Container(
                                                height: 100,
                                                width:100,
                                                decoration: BoxDecoration(

                                                    image: DecorationImage(
                                                        image: AssetImage("assets/icons/sent2.png")
                                                    )
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("Can i have this.. it looks good."),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey.withOpacity(0.3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("12-01-23"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              );
                            }
                        ),
                      ),

                    ],
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
