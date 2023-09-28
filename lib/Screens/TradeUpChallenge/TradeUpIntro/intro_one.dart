import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/constants.dart';




import '../ForFun/treade_for_fun.dart';
import 'intro_two.dart';
import 'leaderboard.dart';

class TradeUpIntroOne extends StatefulWidget {
  TradeUpIntroOne({Key? key}) : super(key: key);

  @override
  _TradeUpIntroOneState createState() => _TradeUpIntroOneState();
}

class _TradeUpIntroOneState extends State<TradeUpIntroOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimationLimiter(
          child: SingleChildScrollView(
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
                            child: Icon(Icons.close, color: Colors.white, size: 23,)),
                        Text("", style: TextStyle(fontSize: 16),),
                        Row(
                          children: [

                          ],
                        )
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 4,
                      child: Image(
                          height: 100,
                          image: AssetImage("assets/images/tradeIntro1.png",), fit: BoxFit.contain,)),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "Welcome to Samahat Barter Trade up Challenge",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "What if you can challenge yourself to trade the smallest unwanted item in your garage to bigger and better items",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                      child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TradeUpIntroTwo(),

                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: barterPrimary2),
                          child: Center(
                            child: Text(
                              "Join Challenge",
                              style: TextStyle(color: barterPrimary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TradeUpForFun(),

                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: barterPrimary2),
                          child: Center(
                            child: Text(
                              "Trade Up for fun",
                              style: TextStyle(color: barterPrimary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Leaderboard(),

                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: barterPrimary2),
                          child: Center(
                            child: Text(
                              "View Leaderboard",
                              style: TextStyle(color: barterPrimary),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
