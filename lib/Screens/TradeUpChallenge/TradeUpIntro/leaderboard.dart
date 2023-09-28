import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/constants.dart';



class Leaderboard extends StatefulWidget {
  Leaderboard({Key? key}) : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;


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
                      Text("Leaderboard", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: barterPrimary2),),
                    ],
                  ),

                ],
              ),
            ),
            Expanded(
              child: Container(
                child: AnimationLimiter(
                  child: Material(
                    color: Colors.transparent,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return Material(
                          color: Colors.transparent,
                          child: AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 44.0,
                              child: FadeInAnimation(
                                child:  _OpenContainerWrapper(
                                  transitionType: _transitionType,
                                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Container(

                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                color: barterPrimary
                                            ),

                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage: AssetImage('assets/images/user_profile.png'),
                                                  ),
                                                  title: Text("Mensah Sandra", style: TextStyle(color: Colors.white),),
                                                  subtitle: Text("Mensah Sandra", style: TextStyle(color: barterPrimary2),),
                                                  trailing: Text("1", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                ),

                                              ],
                                            ),

                                          ),

                                        ],
                                      ),
                                    );
                                  },
                                  onClosed: _showMarkedAsDoneSnackbar,
                                ),
                              ),
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






