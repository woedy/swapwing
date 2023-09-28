import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Screens/Advertisement/each_ad.dart';


class AdsPageScreen extends StatefulWidget {
  AdsPageScreen({Key? key}) : super(key: key);

  @override
  _AdsPageScreenState createState() => _AdsPageScreenState();
}

class _AdsPageScreenState extends State<AdsPageScreen> {
  @override
  Widget build(BuildContext context) {
    var columnCount = 2;

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
                      child: Icon(Icons.close, color: Colors.white, size: 23,)),
                  Text("Advertisements", style: TextStyle(fontSize: 16),),

                ],
              ),
            ),
            Expanded(
              child: Container(
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
                              child: EachAd(),
                            ),
                          ),
                        );
                      },
                    ),
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