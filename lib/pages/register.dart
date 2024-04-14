import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1st/pages/login.dart';

void main() {
  runApp(const RegistPage());
}

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset('lib/images/unicompLogo.png'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'create an',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' UniComp account',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 93, 193, 255)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 2)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add more complex email validation if needed
                      if (!value.contains('@gmail.com')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your username',
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 2)),
                    ),
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      } 
                    return null;
                      }
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
               SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 2)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 2)),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
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
                      backgroundColor: Color.fromARGB(191, 18, 159, 253),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Already Have an Account?, ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Login Here.",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
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
      ),
    );
  }
}
