import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniproject_meal/pages/detailed_food_page.dart';
import 'dart:convert';

class FoodPage extends StatefulWidget {
  final dynamic meal;
  const FoodPage({Key? key, required this.meal}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<dynamic> mealList = [];
  List<dynamic> filteredMealList = [];

  Future<void> fetchMealData() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.meal['strCategory']}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        mealList = data['meals'];
        filteredMealList = mealList;
      });
    }
  }

  @override
  void initState() {
    fetchMealData();
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
              Text(
                "${widget.meal['strCategory']} Meal",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  fontFamily: "HellixBold",
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: filteredMealList.length,
                  itemBuilder: (context, index) {
                    final meal = filteredMealList[index];
                    return buildCardView(meal);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardView(Map<String, dynamic> meal) {
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
              builder: (context) => DetailedFoodPage(detail: meal),
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
                    meal['strMealThumb'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                meal['strMeal'],
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
