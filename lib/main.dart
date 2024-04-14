import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1st/pages/login.dart';
import 'package:flutter_application_1st/pages/register.dart';



void main() {
  runApp(const MobileApp());
}

class MobileApp extends StatelessWidget {
  const MobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MobileHomePage(),
    );
  }
}

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'UniComp', // Change 'UniComp' text to Montserrat font
                style:  TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 93, 193, 255),
                  ),
              ),
              Text(
                ', your companion ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 325,
                child: const Text(
                  ' for university life.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 45),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Color.fromARGB(191, 18, 159, 253),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "Don't have an account yet?, ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: "Register Here.",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistPage()),
                          );
                        },
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
