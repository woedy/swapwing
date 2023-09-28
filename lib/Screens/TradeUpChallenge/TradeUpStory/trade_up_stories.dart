import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Screens/TradeUpChallenge/TradeUpStory/trade_up_user.dart';



class TradeUpStories extends StatefulWidget {
  TradeUpStories({Key? key}) : super(key: key);

  @override
  _TradeUpStoriesState createState() => _TradeUpStoriesState();
}

class _TradeUpStoriesState extends State<TradeUpStories> {
  @override
  Widget build(BuildContext context) {
    var columnCount = 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Trade Up Stories"),
      ),
      body: Container(
        child: AnimationLimiter(
          child: GridView.count(

            //maxCrossAxisExtent: 200,
            childAspectRatio: 1 / 1.5,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            // padding: const EdgeInsets.all(8.0),
            crossAxisCount: columnCount,
            children: List.generate(
              100,
                  (int index) {
                return AnimationConfiguration.staggeredGrid(
                  columnCount: columnCount,
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: const ScaleAnimation(
                    scale: 0.5,
                    child: FadeInAnimation(
                      child: TradeUpUser(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}