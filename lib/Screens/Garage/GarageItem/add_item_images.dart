import 'dart:convert';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samahat_barter/constants.dart';



import 'add_item_videos.dart';

class AddItemImages extends StatefulWidget {
  AddItemImages({Key? key}) : super(key: key);

  @override
  _AddItemImagesState createState() => _AddItemImagesState();
}

class _AddItemImagesState extends State<AddItemImages> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;
  List<File> _images = [];
  int _selectedImageIndex = -1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item Images"),
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
                        "Add item images",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Please make sure to take a least 5 images that looks good and presentable, this will give your item a great change of reaching others",
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
                          if(_images.isNotEmpty)...[
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _images.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedImageIndex = index;
                                        });
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: FileImage(_images[index],),
                                                fit: BoxFit.contain
                                            )
                                        ),

                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]else...[
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(5),

                                      ),

                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    InkWell(
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        _openCamera();
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(5)
                                        ),
                                        child: Center(
                                          child: Icon(Icons.camera_alt, color: barterPrimary2,),
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

                      if(_images.isNotEmpty)...[
                        InkWell(
                          onTap: () {

                          /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddItemVideos(),
                              ),
                            );*/

                            if(_images.length > 10){

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Images should not be more than 10. Please delete some'),
                                ),
                              );

                            }else{
                              _onContinueButtonPressed();
                            }




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
                      ]

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
          child: Text("Select images will be displayed here."),
        ),
      );
    }
  }


/*
  List<String> _convertImagesToBase64() {
    List<String> base64Images = [];
    for (File image in _images) {
      List<int> imageBytes = image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      base64Images.add(base64Image);
    }
    return base64Images;
  }
*/

  void _onContinueButtonPressed() {
    //List<String> base64Images = _convertImagesToBase64();


    var _data = {
      //"item_images": base64Images,
      "item_images": _images,
    };

    print(_data);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemVideos(data: _data,),
      ),
    );
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
       // Navigator.of(context).pop();
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
