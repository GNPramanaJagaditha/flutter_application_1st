// import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1st/pages/register.dart';
import 'package:flutter_application_1st/pages/home.dart';


class LoginPage extends StatefulWidget {
   const LoginPage({super.key});

  @override
  State <LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api";
  final _storage = GetStorage();
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailanduserController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;



  @override
  void dispose() {
    _emailanduserController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void goLogin() async {
  final dio = Dio();
  try {
    final response = await dio.post("$_apiUrl/login", data: {
      "email": _emailanduserController.text,
      "password": _passwordController.text
    });

    if (response.statusCode == 200) {
      // Jika berhasil, lanjutkan ke halaman beranda
        print(response.data);
      _storage.write('token', response.data['data']['token']);
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Jika gagal, tampilkan pesan kesalahan
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid email/username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  } on DioException catch (e) {
    // Tangani error jika terjadi
    print("Error ${e.response?.statusCode} - ${e.response?.data}");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Email or password is invalid'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50 ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200, 
                  height: 200, 
                  child: Image.asset('lib/images/unicompLogo.png'),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('login to',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                )
                ,),
                Text(' UniComp',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 93, 193, 255)
                )
                ,)
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                width: 320,
                child: TextFormField(
                  controller: _emailanduserController,
                  decoration: InputDecoration(
                    labelText: 'Enter your username or email',
                    fillColor: const Color.fromARGB(255, 241, 241, 241),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:  const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2)
                    )
                  ),
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email or username';
                        }
                        return null;
                      },
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
                SizedBox(
                width: 320,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible, // <-- Use obscureText property
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    fillColor: const Color.fromARGB(255, 241, 241, 241),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2)
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (!value.contains(RegExp(r'[a-zA-Z]')) || !value.contains(RegExp(r'[0-9]'))) {
                      return 'Must contain a combination of alphabets and num';
                    }
                    return null;
                  },
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
                ElevatedButton(
                  onPressed: () {
                     if (_formKey.currentState!.validate()){
                      if (_formKey.currentState!.validate()) {    
                        goLogin();
                      }
                     }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 45),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: const Color.fromARGB(191, 18, 159, 253),
                  ),
                  child: const Text(
                    'Submit',
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Register Here.",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegistPage()),
                              );
                            },
                        )
                      ],
                    ),
                  )
                ],
              ),
          ],
          ),
        ),
      )
      );
  }
}

