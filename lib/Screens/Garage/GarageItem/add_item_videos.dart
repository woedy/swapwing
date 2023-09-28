import 'dart:convert';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samahat_barter/Components/video_camera/camera_page.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/add_item_name.dart';
import 'package:samahat_barter/Screens/Garage/GarageItem/item_delivery.dart';
import 'package:samahat_barter/constants.dart';




class AddItemVideos extends StatefulWidget {
  final data;
  AddItemVideos({Key? key, required this.data}) : super(key: key);

  @override
  _AddItemVideosState createState() => _AddItemVideosState();
}

class _AddItemVideosState extends State<AddItemVideos> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;
  List<File> _images = [];
  int _selectedImageIndex = -1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item Videos"),
        backgroundColor: barterPrimary,
      ),
      body: Container(
        color: barterPrimary,
        child: AnimationLimiter(
          child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add item Videos",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Please make sure to take a least three 15s images that looks good and presentable, this will give your item a great change of reaching others",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Remember you gain more credits with samahat barter stickers in background of items",
                        style: TextStyle(color: barterPrimary, fontSize: 11),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildSelectedImage(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [

                          Expanded(
                              //flex: 1,
                              child: Container(
                                height: 100,

                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          _openGallery();

                                        },
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(5)
                                          ),
                                          child: Center(
                                            child: Icon(Icons.photo, color: barterPrimary2,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CameraPage()),
                                          );

                                        },
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(5)
                                          ),
                                          child: Center(
                                            child: Icon(Icons.video_camera_back_outlined, color: barterPrimary2,),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {

                          var _data = {
                            "item_images": widget.data['item_images'],
                            "item_videos": ['item_videos'],
                          };

                         // widget.data['item_videos'] = ["item Videos"];

                          print(_data);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddItemName(data: _data),
                            ),
                          );

                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: barterPrimary2),
                          child: Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(color: barterPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImage() {
    if (_selectedImageIndex != -1) {
      // Code for displaying the selected image with delete button
      return GestureDetector(
        onTap: () {
          _removeSelectedImage();
        },
        child: Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: FileImage(_images[_selectedImageIndex], )
              )
          ),
          child: Stack(
            children: [

              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Code for displaying the empty container with the onTap event
      return Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text("Select videos will be displayed here."),
        ),
      );
    }
  }


  List<String> _convertImagesToBase64() {
    List<String> base64Images = [];
    for (File image in _images) {
      List<int> imageBytes = image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      base64Images.add(base64Image);
    }
    return base64Images;
  }

  void _onContinueButtonPressed() {
    List<String> base64Images = _convertImagesToBase64();
    // Create your payload here, for example:
    Map<String, dynamic> payload = {
      "item_images": base64Images,
    };
    // Do whatever you want with the payload (e.g., send it to an API, etc.).
    print(payload);
  }


  Future<void> _openGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      img = await compressImage(img);
      setState(() {
        _images.add(img!);
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<void> _openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      img = await compressImage(img);
      setState(() {
        _images.add(img!);
        //Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }


  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }



  void _removeSelectedImage() {
    setState(() {
      if (_selectedImageIndex != -1) {
        _images.removeAt(_selectedImageIndex);
        _selectedImageIndex = -1;
      }
    });
  }
}
