import 'package:flutter/material.dart';
import 'package:miniproject_meal/pages/food_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:miniproject_meal/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> categoryList = [];
  List<dynamic> filteredCategoryList = [];

  Future<void> fetchCategoryData() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        categoryList = data['categories'];
        filteredCategoryList = categoryList;
      });
    }
  }

  @override
  void initState() {
    fetchCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultIconLightColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text.rich(
                TextSpan(
                  text: "What would you want to",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "HellixBold",
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: " COOK ",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: "for today?",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: "Hellix"
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: filteredCategoryList.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategoryList[index];
                    return buildCardView(category);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange, // set the color of the selected icon
        unselectedItemColor: Colors.grey,// set the color of the unselected icons
        backgroundColor: Colors.white,
        onTap: (value) {
          if (value == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          }
        },

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME PAGE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'PROFILE PAGE',
          ),
        ],
      ),
    );
  }

  Widget buildCardView(Map<String, dynamic> category) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle category item tap
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodPage(meal: category),
            ),
          );
        },
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 150, // Set the minimum width of the card
            minHeight: 200, // Set the minimum height of the card
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150, // Set the height of the image container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  child: Image.network(
                    category['strCategoryThumb'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                category['strCategory'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Hellix",
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
