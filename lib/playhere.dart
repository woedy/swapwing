import 'package:flutter/material.dart';

class Category {
  final String name;
  bool isSelected;

  Category(this.name, this.isSelected);
}

class CategoryModal extends StatefulWidget {
  @override
  _CategoryModalState createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  List<Category> categories = [
    Category('Category 1', false),
    Category('Category 2', false),
    // Add more categories here
  ];

  List<Category> filteredCategories = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredCategories = categories;
    super.initState();
  }

  void filterCategories(String searchTerm) {
    List<Category> searchResults = [];
    if (searchTerm.isNotEmpty) {
      searchResults = categories.where((category) {
        final String categoryTitle = category.name.toLowerCase();
        final String searchLower = searchTerm.toLowerCase();
        return categoryTitle.contains(searchLower);
      }).toList();
    } else {
      searchResults = categories;
    }

    setState(() {
      filteredCategories = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              controller: searchController,
              onChanged: filterCategories,
              decoration: InputDecoration(
                labelText: 'Search Categories',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredCategories[index].name),
                  trailing: Checkbox(
                    value: filteredCategories[index].isSelected,
                    onChanged: (value) {
                      setState(() {
                        filteredCategories[index].isSelected = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => CategoryModal(),
            );
          },
          child: Text('Open Modal'),
        ),
      ),
    );
  }
}
