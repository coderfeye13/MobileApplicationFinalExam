import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class DetailedFoodPage extends StatefulWidget {
  final dynamic detail;
  const DetailedFoodPage({Key? key, required this.detail}) : super(key: key);

  @override
  State<DetailedFoodPage> createState() => _DetailedFoodPageState();
}

class _DetailedFoodPageState extends State<DetailedFoodPage> {
  List<dynamic> detailList = [];
  List<dynamic> filteredDetailList = [];

  Future<void> fetchDetailData() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.detail['idMeal']}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        detailList = data['meals'];
        filteredDetailList = detailList;
      });
    }
  }

  @override
  void initState() {
    fetchDetailData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Column(
              children: filteredDetailList.map((detail) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      Center(
                        child: Text(
                          detail['strMeal'],
                          style: const TextStyle(
                            fontSize: 30.0,
                            fontFamily: "HellixBold",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.network(
                            detail['strMealThumb'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text.rich(
                        TextSpan(
                          text: 'Category: ',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: detail['strCategory'],
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text.rich(
                        TextSpan(
                          text: 'Area: ',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: detail['strArea'],
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        detail['strInstructions'],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 23.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final yt = detail['strYoutube'];
                            final url = yt;
                            Uri uri = Uri.parse(url);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                          ),
                          child: const Text('Youtube Link'),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        )
    );
  }
}
