
import 'dart:convert';

import 'package:flutter/material.dart';




class NotificationPage extends StatefulWidget {
  static String routeName = "/notifications";

  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {



  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                  Text("Notifications", style: TextStyle(fontSize: 16),),
                  Row(
                    children: [

                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 17,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blue.shade100,
                          child: Column(
                            children: [
                              GestureDetector(
                                child: ListTile(
                                  title: Text("Helloo New Notification",
                                      style: TextStyle(fontWeight: FontWeight.w500)),
                                  subtitle: Text("You proposed trade to Samantha is accepted. you have joined her auction"),
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage("assets/images/user_profile.png"),
                                  ),
                                  trailing: Icon(Icons.more_horiz),
                                ),
                                onTap: () {},
                              ),

                            ],
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }




  Container buildTitleRow(String title) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //SizedBox(width: 10,),
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }



}



