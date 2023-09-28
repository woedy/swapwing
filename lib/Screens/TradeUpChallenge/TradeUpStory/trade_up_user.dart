import 'package:flutter/material.dart';

import '../FeedScreen/feed_screen.dart';


class TradeUpUser extends StatelessWidget {
  final double? width;
  final double? height;

  const TradeUpUser({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        image: DecorationImage(
            image: AssetImage("assets/images/Image Banner 2.png"),
            fit: BoxFit.cover
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: InkWell(
        onTap: (){

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FeedScreen()),
          );
        },
        child: Container(

          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: CircleAvatar(
                  radius: 30,
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}