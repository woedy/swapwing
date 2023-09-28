import 'package:flutter/material.dart';
import 'package:samahat_barter/constants.dart';


class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

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
      scrollDirection: Axis.vertical,
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
                        image: AssetImage("assets/images/feen.png"),
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
                              child: Icon(Icons.backspace, color: Colors.white,),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              child: Icon(Icons.add, size: 20, color: Colors.white,),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.red.withOpacity(0.2)
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/images/user_profile.png"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      ],
                    ),

              )),
              Positioned(
                  bottom: 40,
                  left: 10,
                  child: Container(
                    width: 310,
                    decoration: BoxDecoration(
                      //color: Colors.red
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("@sandra_mensah", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                SizedBox(
                                  width:3,
                                ),
                                Icon(Icons.check_circle_sharp, size: 13, color: Colors.lightBlueAccent,)
                              ],
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    //color: Colors.blue,
                                    width: 310,
                                    child: Text("Trade 1 😃✌️.. New Owner just revealed the house in town revealed the house in town ewsfc ewdsfcsd ew ewf ewfew ew ewdsfcsd ew ewf ewfew ew", maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        )

                      ],
                    ),
                  )
              ),
              Positioned(
                  bottom: 1,
                  left: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [

                            Icon(Icons.list_sharp, color: Colors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Playlist -", style: TextStyle(color: Colors.white, ),),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Season 1", style: TextStyle(color: Colors.white, ),)

                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.arrow_drop_up, color: Colors.white),


                          ],
                        )
                      ],
                    ),
                  )
              ),
              Positioned(
                  right: 20,
                  bottom:30,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: Icon(Icons.thumb_up, size: 20, color: Colors.white,),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.2)
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("24.4k", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: Icon(Icons.comment, size: 20, color: Colors.white,),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.2)
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("24.4k", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: Icon(Icons.share, size: 20, color: Colors.white,),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.2)
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("24.4k", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: Icon(Icons.more_horiz, size: 20, color: Colors.white,),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.2)
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("24.4k", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),



                    ],
                  )
              )
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