import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1st/pages/register.dart';
import 'package:flutter_application_1st/pages/home.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final _formKey = GlobalKey<FormState>();
  TextEditingController _emailanduserController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;


  @override
  void dispose() {
    _emailanduserController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            SizedBox(
              height: 50 ,
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
            SizedBox(
              height: 30,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(
                width: 320,
                child: TextFormField(
                  controller: _emailanduserController,
                  decoration: InputDecoration(
                    labelText: 'Enter your username or email',
                    fillColor: Color.fromARGB(255, 241, 241, 241),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:  BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 2)
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
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                width: 320,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible, // <-- Use obscureText property
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    fillColor: Color.fromARGB(255, 241, 241, 241),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 2)
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
            SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                     if (_formKey.currentState!.validate()){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
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
              ),
          ],
          ),
        ),
      )
      );
  }
}
