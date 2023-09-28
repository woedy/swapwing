import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/constants.dart';


import 'challenges.dart';

class TradeUpIntroThree extends StatefulWidget {
  TradeUpIntroThree({Key? key}) : super(key: key);

  @override
  _TradeUpIntroThreeState createState() => _TradeUpIntroThreeState();
}

class _TradeUpIntroThreeState extends State<TradeUpIntroThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: AnimationLimiter(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        "Tips",
                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "You have to be energetic and loving on your first trade, Because this is setting the bar for the entire challenge",
                        style: TextStyle(color: Colors.white, ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Having a great social media following is a great plus, since you can convince businesses",
                        style: TextStyle(color: Colors.white, ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sometimes you get a No. But it about how you take that No,You can’t always get a yes when trading everytime. Is all part of the game.",
                        style: TextStyle(color: Colors.white, ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Text(
                        "Show love, Say thank you and move on. you will go very far.",
                        style: TextStyle(color: Colors.white, ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Text(
                        "Always seek permission before taking video of others",
                        style: TextStyle(color: Colors.white, ),
                      ),
                    ],
                  ),
                ),


                SizedBox(
                  height: 30,
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TradeUpChallenges(),

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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
