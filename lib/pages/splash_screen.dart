import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  Future<void> _initializeApp(BuildContext context) async {
    // Perform any initializations or setup tasks here (if needed)
    // For example, you can load assets, perform checks, etc.

    // Simulate a delay to show the splash screen (replace this with actual initialization tasks)
    await Future.delayed(const Duration(seconds: 4));

    // Navigate to the login page after the splash screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    _initializeApp(context); // Call the initialization method here

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Recipoos', // Replace 'Your App Name' with your actual app name
              style: TextStyle(
                fontSize: 30,
                fontFamily: "HellixBold",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/img/splash.png', // Replace 'assets/logo.png' with your logo image path
              width: 150, // Adjust the width of the logo as needed
              height: 150, // Adjust the height of the logo as needed
            ),
            const SizedBox(height: 20),
            const Text(
              'Best way to find best recipes.', // Replace 'Your App Name' with your actual app name
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Hellix",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Display a loading indicator or your splash screen UI
          ],
        ),
      ),
    );
  }
}
