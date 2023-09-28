import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/constants.dart';


import '../FeedScreen/feed_screen.dart';



class TradeUpEpisodes extends StatefulWidget {
  TradeUpEpisodes({Key? key}) : super(key: key);

  @override
  _TradeUpEpisodesState createState() => _TradeUpEpisodesState();
}

class _TradeUpEpisodesState extends State<TradeUpEpisodes> {
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
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.backspace_sharp, color: Colors.white, size: 23,)),
                  Row(
                    children: [
                      Text("Your episodes for ", style: TextStyle(fontSize: 16),),
                      Text("T-Shirt Challenge", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: barterPrimary2),),
                    ],
                  ),

                ],
              ),
            ),
            Expanded(
              child: AnimationLimiter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Want to add an episode?", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),),
                      SizedBox(
                        height: 10,
                      ),


                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          //color: youPrimaryColor3,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: barterPrimary2,
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: Column(
                                    children: [
                                      Icon(Icons.video_call, color: barterPrimary,),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Go live", style: TextStyle(color: barterPrimary),)
                                    ],
                                  ),

                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: barterPrimary2,
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: Column(
                                    children: [
                                      Icon(Icons.photo, color: barterPrimary,),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Upload Video", style: TextStyle(color: barterPrimary),)
                                    ],
                                  ),

                                )),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Text("Season Episodes", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FeedScreen(),

                            ),
                          );
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                              color: barterPrimary3,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage("assets/images/feen.png"),fit: BoxFit.cover
                                        )
                                    ),

                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),


                                        child: Text("Episode 1",  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),


                                        child: Text("Trade 1 😃✌️.. New Owner just revealed the house in town the house in town the house in town the house in town the house in town", maxLines: 3, overflow: TextOverflow.ellipsis,  style: TextStyle(color: Colors.white),),

                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),


                                        child: Text("4.6M Views", style: TextStyle(color: barterPrimary2),),

                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
