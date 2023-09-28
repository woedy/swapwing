import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:samahat_barter/constants.dart';
import 'item_delivery.dart';

import 'package:flutter/material.dart';
import 'package:samahat_barter/constants.dart';
import 'item_delivery.dart';

class AddItemCategory extends StatefulWidget {
  final data;
  AddItemCategory({Key? key, required this.data}) : super(key: key);

  @override
  _AddItemCategoryState createState() => _AddItemCategoryState();
}

class _AddItemCategoryState extends State<AddItemCategory> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;
  List<String> itemCategories = [
    "Electronics",
    "Appliances",
    "Clothing",
    "Home and Furniture",
    "Beauty and Personal Care",
    "Sports and Outdoors",
    "Toys and Games",
    "Books and Stationery",
    "Health and Wellness",
    "Automotive",
    "Pet Supplies",
    "Baby and Kids",
    "Food and Beverages",
    "Office Supplies",
    "Home Improvement",
  ];

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item Category"),
        backgroundColor: barterPrimary,
      ),
      body: Container(
        color: barterPrimary,
        child: AnimationLimiter(
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: itemCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = itemCategories[index];
                      return Material(
                        color: barterPrimary,
                        child: AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          duration: const Duration(milliseconds: 375),
                          child: ScaleAnimation(
                            child: _OpenContainerWrapper(
                              transitionType: _transitionType,
                              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                return Material(
                                  color: barterPrimary,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (selectedCategories.contains(category)) {
                                          selectedCategories.remove(category);
                                        } else {
                                          selectedCategories.add(category);


                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedCategories.contains(category)
                                            ? barterPrimary2 // Selected color
                                            : barterPrimary3,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: selectedCategories.contains(category)
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
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
                if(selectedCategories.isNotEmpty)...[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){

                        print("##############");
                        print('Selected categories: $selectedCategories');

                        widget.data['categories'] = selectedCategories;

                        print(widget.data);

                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddItemDelivery(data: widget.data,),

                        ),
                      );


                      },
                      child: Align(
                        child: Container(
                          width: 354,
                          //height: 55,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: barterPrimary2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Continue",
                                    style: TextStyle(
                                        fontSize: 15, color: barterPrimary),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
