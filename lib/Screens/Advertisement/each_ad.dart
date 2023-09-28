import 'package:flutter/material.dart';
import 'package:samahat_barter/Screens/Advertisement/ads_viewing_page.dart';



class EachAd extends StatelessWidget {
  final double? width;
  final double? height;

  const EachAd({
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
            image: AssetImage("assets/images/voda.png"),
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
                    AdsViewPage()),
          );
        },

      ),
    );
  }
}