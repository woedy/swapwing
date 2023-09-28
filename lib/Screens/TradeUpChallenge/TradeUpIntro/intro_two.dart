import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/constants.dart';




import 'intro_three.dart';

class TradeUpIntroTwo extends StatefulWidget {
  TradeUpIntroTwo({Key? key}) : super(key: key);

  @override
  _TradeUpIntroTwoState createState() => _TradeUpIntroTwoState();
}

class _TradeUpIntroTwoState extends State<TradeUpIntroTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: AnimationLimiter(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      Text(" ", style: TextStyle(fontSize: 16),),
                      Row(
                        children: [

                        ],
                      )
                    ],
                  ),
                ),

                Expanded(
                  flex: 2,
                    child: Image(
                        height: 50,
                        image: AssetImage("assets/images/tradeIntro1.png",), fit: BoxFit.contain,)),
                SizedBox(
                  height: 20,
                ),

                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          "Pick a paper clip, and trade up to something more valuable and bigger",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Your goal is to get iphone someway somehow, Share your journey for everyone to see",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Something like a Motocycle or a car or a house will qualify as a high & up trade",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),


                Expanded(
                  flex: 1,
                    child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TradeUpIntroThree(),

                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(color: barterPrimary2),
                        child: Center(
                          child: Text(
                            "Continue to Challenge",
                            style: TextStyle(color: barterPrimary),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
