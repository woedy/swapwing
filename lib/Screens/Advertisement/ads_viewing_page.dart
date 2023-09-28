import 'package:flutter/material.dart';
import 'package:samahat_barter/constants.dart';


class AdsViewPage extends StatefulWidget {
  @override
  _AdsViewPageState createState() => _AdsViewPageState();
}

class _AdsViewPageState extends State<AdsViewPage> {

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: [
        MyPage1Widget(),
        MyPage1Widget(),
        MyPage1Widget(),



      ],
    );
  }
}

class MyPage1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: barterPrimary2,
                    image: DecorationImage(
                        image: AssetImage("assets/images/voda.png"),
                        fit: BoxFit.cover
                    )
                ),
                height: MediaQuery.of(context).size.height,

              ),
              Positioned(
                top: 35,
                  child: Container(
                    //color: Colors.red,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back, color: Colors.white,),
                            ),
                          ],
                        ),

                      ],
                    ),

              )),

            ],
          )
        ],
      ),
    );
  }
}



class MyPage2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: barterPrimary2,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Text("Woooooooo"),
          ),
        )
      ],
    );
  }
}


const lightBlue = Color(0xff00bbff);
const mediumBlue = Color(0xff00a2fc);
const darkBlue = Color(0xff0075c9);

final lightGreen = Colors.green.shade300;
final mediumGreen = Colors.green.shade600;
final darkGreen = Colors.green.shade900;

final lightRed = Colors.red.shade300;
final mediumRed = Colors.red.shade600;
final darkRed = Colors.red.shade900;

class MyBox extends StatelessWidget {
  final Color color;
  final double? height;
  final String? text;

  MyBox(this.color, {this.height, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        color: color,
        height: (height == null) ? 150 : height,
        child: (text == null)
            ? null
            : Center(
          child: Text(
            text!,
            style: TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}