import 'package:flutter/material.dart';

import '../../constants.dart';

class PrivateGarage extends StatefulWidget {
  const PrivateGarage({Key? key}) : super(key: key);

  @override
  State<PrivateGarage> createState() => _PrivateGarageState();
}

class _PrivateGarageState extends State<PrivateGarage> {
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
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close, color: Colors.white, size: 23,)),
                    Text("", style: TextStyle(fontSize: 16),),
                    Row(
                      children: [


                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Private Garage", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("The user is keeping their garage from the pulic. ", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),)
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
