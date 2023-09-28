
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';




class TradeDetail extends StatefulWidget {
  static String routeName = "/my_trades";

  String? trade_id;

  TradeDetail({Key? key, this.title, this.trade_id}) : super(key: key);
  String? title;

  @override
  _TradeDetailState createState() => _TradeDetailState();
}

class _TradeDetailState extends State<TradeDetail> {





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
            //color: youPrimaryColor2,
            height: double.infinity,
            child: Container(
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
                        Text("Trade Details", style: TextStyle(fontSize: 16),),
                        Row(
                          children: [

                          ],
                        )
                      ],
                    ),
                  ),
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
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/feen.png'),
                                              fit: BoxFit.cover
                                          )
                                      ),               ),
                                  )
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
                                      Text('Samantha')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/feen.png'),
                                              fit: BoxFit.cover
                                          )
                                      ),               ),
                                  ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green
                              ),
                              child: Center(
                                child: Icon(Icons.check, color: Colors.white,),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(10),
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red
                              ),
                              child: Center(
                                child: Icon(Icons.close, color: Colors.white,),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text("12-13-32"),
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
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
