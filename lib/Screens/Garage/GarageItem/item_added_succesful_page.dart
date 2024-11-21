
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:samahat_barter/constants.dart';


class ItemAddedSuccessfulPage extends StatefulWidget {
  static String routeName = "/item_added_Successful";


  const ItemAddedSuccessfulPage({Key? key}) : super(key: key);

  @override
  _ItemAddedSuccessfulPageState createState() => _ItemAddedSuccessfulPageState();
}

class _ItemAddedSuccessfulPageState extends State<ItemAddedSuccessfulPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Successful"),
        backgroundColor: barterPrimary,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: barterPrimary,
        height: double.infinity,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Column(

                children: [

                  SizedBox(
                    height: 200,
                  ),

                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text("Successful", style: TextStyle(fontSize: 25, color: Colors.green),),

                          SizedBox(
                            height: 10,
                          ),
                          Icon(Icons.check_circle_outline, size: 100, color: Colors.green,),

                          SizedBox(
                            height: 10,
                          ),
                          Text("New Item added successfully.", style: TextStyle(fontSize: 19, color: Colors.white),),
                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 100,
                  ),
                  /*DefaultButton(
                    text: "Continue",
                    press: (){
                      _submitForm(context);
                    },
                  )*/

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(context) {
  /* // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()),).then((_) => setState(() {
      //_socketInit();
    }));*/
  }




}