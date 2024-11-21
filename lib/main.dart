import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/Components/theme.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_intro.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_videos.dart';
import 'package:samahat_barter/Screens/HomeScreens/home_screen_page.dart';
import 'package:samahat_barter/Screens/SplashScreen/splashScreen.dart';
import 'package:samahat_barter/constants.dart';
import 'package:samahat_barter/drop_pick_screen.dart';

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
    return GestureDetector(
      onTap: () {
        // Hide the keyboard when tapping outside the text field
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SwapWing2',
        theme: theme(),
        home: MyHomePage(),
      ),
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


         // return SplashScreen();
          return api_key == null ? SplashScreen() : HomePageScreen();
        });
  }

  Future apiKey() async {
    api_key = await getApiPref();
  }
}
