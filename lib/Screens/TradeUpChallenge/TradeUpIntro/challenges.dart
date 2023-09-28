import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/Screens/HomeScreens/home_screen_page.dart';
import 'package:samahat_barter/Screens/TradeUpChallenge/TradeUpIntro/trade_up_episodes.dart';
import 'package:samahat_barter/constants.dart';


class TradeUpChallenges extends StatefulWidget {
  TradeUpChallenges({Key? key}) : super(key: key);

  @override
  _TradeUpChallengesState createState() => _TradeUpChallengesState();
}

class _TradeUpChallengesState extends State<TradeUpChallenges> {

  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePageScreen()));
                        },
                        child: Icon(Icons.backspace_sharp, color: Colors.white, size: 23,)),
                    Text("Ongoing Challenges", style: TextStyle(fontSize: 16),),

                  ],
                ),
              ),
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 44.0,
                          child: FadeInAnimation(
                            child:  _OpenContainerWrapper(
                              transitionType: _transitionType,
                              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 270,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: barterPrimary
                                      ),

                                      child: Column(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("T-shirt challenge", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                                              SizedBox(
                                                height: 10,
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 130,
                                                            width: 130,
                                                            margin: EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: barterPrimary,
                                                                image: DecorationImage(
                                                                    image: AssetImage("assets/images/tshirt.png")
                                                                )
                                                            ),
                                                          ),
                                                          Positioned(
                                                              left: 0,
                                                              right: 0,
                                                              bottom: 0,
                                                              child: Container(

                                                                decoration: BoxDecoration(
                                                                    color: barterPrimary
                                                                ),
                                                                child: Center(
                                                                  child: Text("T-shirt"),
                                                                ),
                                                              ))
                                                        ],
                                                      )

                                                    ],
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Icon(Icons.arrow_forward, size: 50, color: Colors.white,),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 130,
                                                            width: 130,
                                                            margin: EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                //color: barterPrimary2,
                                                                image: DecorationImage(
                                                                    image: AssetImage("assets/images/ps4_console_blue_1.png")
                                                                )
                                                            ),
                                                          ),
                                                          Positioned(
                                                              left: 0,
                                                              right: 0,
                                                              bottom: 0,
                                                              child: Container(

                                                                decoration: BoxDecoration(
                                                                    color: barterPrimary
                                                                ),
                                                                child: Center(
                                                                  child: Text("X-box"),
                                                                ),
                                                              ))
                                                        ],
                                                      )

                                                    ],
                                                  ),

                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),

                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TradeUpEpisodes(),

                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 250,
                                                  decoration: BoxDecoration(color: barterPrimary2),
                                                  child: Center(
                                                    child: Text(
                                                      "Join Challenge",
                                                      style: TextStyle(color: barterPrimary, fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),

                                    ),
                                  ],
                                );
                              },
                              onClosed: _showMarkedAsDoneSnackbar,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
  }
}








class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      transitionDuration: Duration(milliseconds: 400),
      openBuilder: (BuildContext context, VoidCallback _) {
        return Container();
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}






