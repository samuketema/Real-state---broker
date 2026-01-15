import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: screenHeight * 0.18,
            
              fit: BoxFit.contain,
            ),
            Text(
              textAlign: TextAlign.center,
              "Welcome again to Betlink",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 40),
            TextFormField(),
            const SizedBox(height: 15),
            TextFormField(),
            const SizedBox(height: 25),
            ElevatedButton(onPressed: () {}, child: Text("Sign Up")),
          ],
        ),
      ),
    );
  }
}
