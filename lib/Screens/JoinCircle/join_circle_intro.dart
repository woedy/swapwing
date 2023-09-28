import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/JoinCircle/find_circle.dart';

import '../../constants.dart';

class JoinCircleIntro extends StatefulWidget {
  const JoinCircleIntro({Key? key}) : super(key: key);

  @override
  State<JoinCircleIntro> createState() => _JoinCircleIntroState();
}

class _JoinCircleIntroState extends State<JoinCircleIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        child: Icon(Icons.backspace, color: Colors.white, size: 23,)),
                    Text("", style: TextStyle(fontSize: 16),),
                    Row(
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FindCircle()));
                            },
                            child: Icon(Icons.close, color: Colors.white, size: 23,)),

                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Follow different traders", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("to discover more items and traders in their circle.", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),

              Image(
                height: 200,
                image: AssetImage('assets/images/group.png',),)

            ],
          ),
        ),
      ),
    );
  }
}
