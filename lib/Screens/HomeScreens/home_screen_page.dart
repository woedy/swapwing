import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/draggable_button.dart';
import 'package:samahat_barter/Components/popout_card.dart';
import 'package:samahat_barter/Components/popout_card_error.dart';
import 'package:samahat_barter/Screens/Advertisement/earn_credit_intro.dart';
import 'package:samahat_barter/Screens/Authentication/SignIn/sign_in_screen.dart';
import 'package:samahat_barter/Screens/Garage/items/my_garage.dart';
import 'package:samahat_barter/Screens/HomeScreens/episode_detail.dart';
import 'package:samahat_barter/Screens/HomeScreens/models/home_model.dart';
import 'package:samahat_barter/Screens/JoinCircle/find_circle.dart';
import 'package:samahat_barter/Screens/JoinCircle/join_circle_intro.dart';
import 'package:samahat_barter/Screens/MyTrades/my_trades.dart';
import 'package:samahat_barter/Screens/TradeUpChallenge/FeedScreen/feed_screen.dart';
import 'package:samahat_barter/Screens/TradeUpChallenge/TradeUpIntro/intro_one.dart';
import 'package:samahat_barter/Screens/UserProfile/user_profile.dart';
import 'package:samahat_barter/Screens/notifications/notification_screen.dart';
import 'package:samahat_barter/constants.dart';
import 'package:http/http.dart' as http;


import '../Listings/browse_trades.dart';

Future<HomeModel> get_home_data() async {

  var user_id = await getUserIDPref();
  var api_k = await getApiPref();

  final response = await http.get(
    Uri.parse(hostName + '/api/home_page/user-home?user_id=' + user_id.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Token ' + api_k.toString()
    },
  );

  if (response.statusCode == 200) {
    // If the server returned a 200 OK response,
    // then parse the JSON.
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    return HomeModel.fromJson(jsonDecode(response.body));

  } else if (response.statusCode == 422) {
    print(jsonDecode(response.body));
    return HomeModel.fromJson(jsonDecode(response.body));
  }else if (response.statusCode == 404) {
    print(jsonDecode(response.body));
    return HomeModel.fromJson(jsonDecode(response.body));
  }else {
    print("################");
    print(jsonDecode(response.statusCode.toString()));
    print(jsonDecode(response.body));
    throw Exception('Failed to load.');
  }
}



class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();



  AnimationController? _controller;
  Future<HomeModel>? _futureHome;


  @override
  void initState() {
    _futureHome = get_home_data();
    animatedCenter();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }


  void animatedCenter() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
  }


  @override
  Widget build(BuildContext context) {

    return (_futureHome == null) ? buildColumn() : buildFutureBuilder();



  }

  Widget buildColumn() {
    return Scaffold(
      body: Container(),
    );
  }


  FutureBuilder<HomeModel> buildFutureBuilder() {
    return FutureBuilder<HomeModel>(
      future: _futureHome,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Dialog(
              backgroundColor: Colors.transparent,
              child: PopOutCard(subject: 'Connecting..', message: "Please wait..", icon: Icons.downloading,)

          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          var user_data = data.data!.userData;

          if(data.response == "Successful") {
         /*   WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context){
                    return Dialog(
                        backgroundColor: Colors.transparent,
                        child: PopOutCard(
                          subject: 'Successful',
                          message: "",
                          icon: Icons.downloading,)

                    );
                  }
              );

            });
*/
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Stack(
                  children: [
                    Container(
                      //color: youPrimaryColor2,
                        width: MediaQuery.of(context).size.width,
                        child: SafeArea(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(

                                          child: Container(

                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                //color: barterPrimary2,
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color(0xff08bf98),
                                                    Color(0xff10141e),
                                                  ],
                                                )
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const UserProfile()));
                                                  },

                                                  child: CircleAvatar(
                                                    radius: 32,
                                                    backgroundImage: NetworkImage(hostName + user_data!.profilePhoto!.toString()),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text("Let's Keep Trading!", style: TextStyle(fontSize: 16, ),),
                                                    Text("Hi, " + user_data.firstName!.toString(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            ),

                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const NotificationPage()));
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color(0xff08bf98),
                                                    Color(0xff10141e),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.circular(500)
                                            ),
                                            child: Center(
                                              child: Stack(
                                                children: [
                                                  const Icon(Icons.notifications_active, color: Colors.white,),
                                                  if(data.data!.hasNotification == true)...[
                                                    const CircleAvatar(
                                                      radius: 5,
                                                      backgroundColor: Colors.red,
                                                    )
                                                  ]

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),),
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.symmetric(horizontal: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.white.withOpacity(0.1))),

                                          child: const Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Search our market", style: TextStyle(fontSize: 16),),
                                              Icon(Icons.search, color:Colors.white, size: 25)
                                            ],
                                          ),
                                        ),

                                        if(data.data!.allEpisodes!.length == 1)...[
                                          Expanded(
                                              child: Container(

                                                //color: Colors.red,
                                                child: ListView.builder(
                                                    itemCount: data.data!.allEpisodes!.length,
                                                    //scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, index){
                                                      return Container(

                                                        child: Stack(
                                                          children: [
                                                            InkWell(
                                                              onTap: (){
                                                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EpisodeDetails(data: data.data!.allEpisodes!)));
                                                              },
                                                              child: Center(
                                                                child: Container(
                                                                  height: 220,
                                                                  width: 500,


                                                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      //color: Colors.red,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(hostName + data.data!.allEpisodes![index].video!.toString()),
                                                                          fit: BoxFit.cover
                                                                      )
                                                                  ),

                                                                ),
                                                              ),
                                                            ),

                                                            Positioned(
                                                              top: 30,
                                                              right: 0,
                                                              left: 0,
                                                              child: Container(
                                                                width: 500,
                                                                height: 63,

                                                                margin: const EdgeInsets.symmetric(horizontal: 10, ),
                                                                decoration: BoxDecoration(
                                                                  color: barterPrimary2.withOpacity(0.7),
                                                                  borderRadius: const BorderRadius.only(
                                                                    topLeft: Radius.circular(10.0),
                                                                    topRight: Radius.circular(10.0),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Container(
                                                                      margin: const EdgeInsets.all(10),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text("Trending #" + data.data!.allEpisodes![index].trendingNo!.toString(), style: const TextStyle(fontWeight: FontWeight.w800, color: barterPrimary),),
                                                                          const SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          Text(data.data!.allEpisodes![index].title!.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets.all(10),
                                                                      //padding: EdgeInsets.all(2),
                                                                      width: 80,
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                          color: barterPrimary,
                                                                          borderRadius: BorderRadius.circular(40)
                                                                      ),
                                                                      child: const Center(
                                                                        child: Text("Watch",style: TextStyle(fontSize: 12),),
                                                                      ),
                                                                    )

                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 30,
                                                              right: 0,
                                                              left: 0,
                                                              child: Container(
                                                                //width: 300,
                                                                height: 50,
                                                                margin: const EdgeInsets.symmetric(horizontal: 10, ),
                                                                decoration: BoxDecoration(
                                                                  color: barterPrimary2.withOpacity(0.7),
                                                                  borderRadius: const BorderRadius.only(
                                                                    bottomLeft: Radius.circular(10.0),
                                                                    bottomRight: Radius.circular(10.0),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets.all(5),
                                                                      width: 60,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(
                                                                          color: barterPrimary,
                                                                          borderRadius: BorderRadius.circular(7)
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(Icons.thumb_up_off_alt_outlined, size: 15, color: Colors.white,),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(data.data!.allEpisodes![index].likes!.length.toString(), style: const TextStyle(fontSize: 12),)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets.all(5),
                                                                      width: 60,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(
                                                                          color: barterPrimary,
                                                                          borderRadius: BorderRadius.circular(7)
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(Icons.share_outlined, size: 15, color: Colors.white,),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(data.data!.allEpisodes![index].sharedEpisodes!.length.toString(), style: const TextStyle(fontSize: 12),)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets.all(5),
                                                                      width: 60,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(
                                                                          color: barterPrimary,
                                                                          borderRadius: BorderRadius.circular(7)
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(Icons.remove_red_eye_outlined, size: 15, color: Colors.white,),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(data.data!.allEpisodes![index].views!.toString(), style: const TextStyle(fontSize: 12),)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ))
                                        ]else...[
                                          Expanded(
                                              child: Container(

                                                //color: Colors.red,
                                                child: ListView.builder(
                                                    itemCount: data.data!.allEpisodes!.length,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, index){
                                                      return Container(

                                                        child: Stack(
                                                          children: [
                                                            InkWell(
                                                              onTap: (){
                                                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EpisodeDetails(data: data.data!.allEpisodes!)));
                                                              },
                                                              child: Center(
                                                                child: Container(
                                                                  height: 220,
                                                                  width: 300,


                                                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      //color: Colors.red,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(hostName + data.data!.allEpisodes![index].video!.toString()),
                                                                          fit: BoxFit.cover
                                                                      )
                                                                  ),

                                                                ),
                                                              ),
                                                            ),

                                                            Positioned(
                                                              top: 30,
                                                              right: 0,
                                                              left: 0,
                                                              child: Container(
                                                                width: 500,
                                                                height: 63,

                                                                margin: const EdgeInsets.symmetric(horizontal: 10, ),
                                                                decoration: BoxDecoration(
                                                                  color: barterPrimary2.withOpacity(0.7),
                                                                  borderRadius: const BorderRadius.only(
                                                                    topLeft: Radius.circular(10.0),
                                                                    topRight: Radius.circular(10.0),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Container(
                                                                      margin: const EdgeInsets.all(10),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text("Trending #" + data.data!.allEpisodes![index].trendingNo!.toString(), style: const TextStyle(fontWeight: FontWeight.w800, color: barterPrimary),),
                                                                          const SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          Text(data.data!.allEpisodes![index].title!.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets.all(10),
                                                                      //padding: EdgeInsets.all(2),
                                                                      width: 80,
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                          color: barterPrimary,
                                                                          borderRadius: BorderRadius.circular(40)
                                                                      ),
                                                                      child: const Center(
                                                                        child: Text("Watch",style: TextStyle(fontSize: 12),),
                                                                      ),
                                                                    )

                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 30,
                                                              right: 0,
                                                              left: 0,
                                                              child: Container(
                                                                //width: 300,
                                                                height: 50,
                                                                margin: const EdgeInsets.symmetric(horizontal: 10, ),
                                                                decoration: BoxDecoration(
                                                                  color: barterPrimary2.withOpacity(0.7),
                                                                  borderRadius: const BorderRadius.only(
                                                                    bottomLeft: Radius.circular(10.0),
                                                                    bottomRight: Radius.circular(10.0),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets.all(5),
                                                                      width: 60,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(
                                                                          color: barterPrimary,
                                                                          borderRadius: BorderRadius.circular(7)
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(Icons.thumb_up_off_alt_outlined, size: 15, color: Colors.white,),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(data.data!.allEpisodes![index].likes!.length.toString(), style: const TextStyle(fontSize: 12),)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets.all(5),
                                                                      width: 60,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(
                                                                          color: barterPrimary,
                                                                          borderRadius: BorderRadius.circular(7)
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(Icons.share_outlined, size: 15, color: Colors.white,),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(data.data!.allEpisodes![index].sharedEpisodes!.length.toString(), style: const TextStyle(fontSize: 12),)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets.all(5),
                                                                      width: 60,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(
                                                                          color: barterPrimary,
                                                                          borderRadius: BorderRadius.circular(7)
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(Icons.remove_red_eye_outlined, size: 15, color: Colors.white,),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(data.data!.allEpisodes![index].views!.toString(), style: const TextStyle(fontSize: 12),)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ))
                                        ]

                                      ],
                                    )
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          child: Align(
                                            child: _buildCenterAnimation(),
                                            //child: _buildContainer(500 * _controller!.value),
                                            /* child: Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        color: barterPrimary2,
                                        borderRadius: BorderRadius.circular(500)
                                      ),
                                    ),*/
                                          ),
                                        ),

                                        Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const MyGarage()));

                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              gradient: const LinearGradient(
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                                colors: [
                                                                  Color(0xff08bf98),
                                                                  Color(0xff10141e),
                                                                ],
                                                              ),
                                                              borderRadius: BorderRadius.circular(500)
                                                          ),
                                                          child: const Center(
                                                            child: Icon(Icons.home_filled, color: Colors.white,),
                                                          ),
                                                        ),
                                                        const Text("My Garage", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, shadows: [
                                                          Shadow(
                                                            offset: Offset(1.0, 1.0),
                                                            blurRadius: 3.0,
                                                            color: Color.fromARGB(255, 0, 0, 0),
                                                          ),
                                                        ]), )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => BrowseTradeScreen()));

                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 50,
                                                              decoration: BoxDecoration(
                                                                  gradient: const LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Color(0xff08bf98),
                                                                      Color(0xff10141e),
                                                                    ],
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(500)
                                                              ),
                                                              child: const Center(
                                                                child: Icon(Icons.list, color: Colors.white,),
                                                              ),
                                                            ),
                                                            const Text("Listings", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, shadows: [
                                                              Shadow(
                                                                offset: Offset(1.0, 1.0),
                                                                blurRadius: 3.0,
                                                                color: Color.fromARGB(255, 0, 0, 0),
                                                              ),
                                                            ]), )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [

                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MyTrades()));

                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 50,
                                                              decoration: BoxDecoration(
                                                                  gradient: const LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Color(0xff08bf98),
                                                                      Color(0xff10141e),
                                                                    ],
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(500)
                                                              ),
                                                              child: const Center(
                                                                child: Icon(Icons.list_alt, color: Colors.white,),
                                                              ),
                                                            ),
                                                            const Text("My Trades", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, shadows: [
                                                              Shadow(
                                                                offset: Offset(1.0, 1.0),
                                                                blurRadius: 3.0,
                                                                color: Color.fromARGB(255, 0, 0, 0),
                                                              ),
                                                            ]), )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const JoinCircleIntro()));

                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 50,
                                                              decoration: BoxDecoration(
                                                                  gradient: const LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Color(0xff08bf98),
                                                                      Color(0xff10141e),
                                                                    ],
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(500)
                                                              ),
                                                              child: const Center(
                                                                child: Icon(Icons.find_replace_rounded, color: Colors.white,),
                                                              ),
                                                            ),
                                                            const Text("Find Circle", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, shadows: [
                                                              Shadow(
                                                                offset: Offset(1.0, 1.0),
                                                                blurRadius: 3.0,
                                                                color: Color.fromARGB(255, 0, 0, 0),
                                                              ),
                                                            ]), )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [

                                                      InkWell(
                                                        onTap: (){
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const EarnCreditIntro()));
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 50,
                                                              decoration: BoxDecoration(
                                                                  gradient: const LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Color(0xff08bf98),
                                                                      Color(0xff10141e),
                                                                    ],
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(500)
                                                              ),
                                                              child: const Center(
                                                                child: Icon(Icons.credit_score, color: Colors.white,),
                                                              ),
                                                            ),
                                                            const Text("Earn Credits", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, shadows: [
                                                              Shadow(
                                                                offset: Offset(1.0, 1.0),
                                                                blurRadius: 3.0,
                                                                color: Color.fromARGB(255, 0, 0, 0),
                                                              ),
                                                            ]), )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TradeUpIntroOne()));
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                              gradient: const LinearGradient(
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                                colors: [
                                                                  Color(0xff08bf98),
                                                                  Color(0xff10141e),
                                                                ],
                                                              ),
                                                              borderRadius: BorderRadius.circular(500)
                                                          ),
                                                          child: const Center(
                                                            child: Icon(Icons.cloud_upload, color: Colors.white,),
                                                          ),
                                                        ),
                                                        const Text("Trade Up League", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, shadows: [
                                                          Shadow(
                                                            offset: Offset(1.0, 1.0),
                                                            blurRadius: 3.0,
                                                            color: Color.fromARGB(255, 0, 0, 0),
                                                          ),
                                                        ]), )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ))),
                    DraggableCircle()
                  ],
                ),
              ),
            );
          }

          else if (data.response == "Error") {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context){
                    return const Dialog(
                        backgroundColor: Colors.transparent,
                        child: PopOutCard(subject: 'Error', message: "Failed to authenticate.", icon: Icons.downloading,)


                    );
                  }
              );

            });


            Future.delayed(const Duration(seconds: 1), () {


              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                    (route) => false,
              );

              setState(() {

              });

            });
          }


        } else if (snapshot.hasError) {




          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context){
                  return const Dialog(
                      backgroundColor: Colors.transparent,
                      child: PopOutCardError(subject: 'Error', message: "Failed to load.", icon: Icons.error,)


                  );
                }
            );

          });

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (route) => false,
            );
          });

          // return const SizedBox();




        }

        return const SizedBox();
      },
    );
  }



  Widget _buildCenterAnimation() {
    return AnimatedBuilder(
      animation:
      CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(150 * _controller!.value),
            _buildContainer(200 * _controller!.value),
            _buildContainer(250 * _controller!.value),
            _buildContainer(300 * _controller!.value),
            _buildContainer(350 * _controller!.value),
            _buildContainer(400 * _controller!.value),
            Align(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: Center(
                        child: Image.asset("assets/images/sama logo.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: barterPrimary2.withOpacity(1 - _controller!.value),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();  // Make sure to dispose of the AnimationController
    super.dispose();
  }
}
