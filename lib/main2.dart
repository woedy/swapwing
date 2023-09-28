import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/theme.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_images.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_intro.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_name.dart';
import 'package:samahat_barter/Screens/HomeScreens/home_screen_page.dart';
import 'package:samahat_barter/Screens/SplashScreen/splashScreen.dart';
import 'package:samahat_barter/constants.dart';
import 'package:samahat_barter/PlayGround/swapwing_registration.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => {runApp(MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Samahat Barter',
      theme: theme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? api_key = "";
  Future? _user_api;

  @override
  void initState() {
    super.initState();
    _user_api = apiKey();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _user_api,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //return addItemIntro();
          return api_key == null ? SplashScreen() : HomePageScreen();
        });
  }

  Future apiKey() async {
    api_key = await getApiPref();
  }
}
