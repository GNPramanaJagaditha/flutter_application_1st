import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1st/pages/profile.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_application_1st/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final _dio = Dio();
  final _storage = GetStorage();
  final _apiUrl = 'https://mobileapis.manpits.xyz/api';
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    try {
      // Perform logout API call
      final response = await _dio.get(
        '$_apiUrl/logout',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );

      // If logout is successful, navigate to LoginPage
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      print('Logout error: $e');
      // Handle logout error, if any
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'lib/images/logo2.png',
          height: 35,
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage('lib/images/profile1.jpg'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
    body: const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('Task',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 55, 55, 55)
                  )),
                SizedBox(
                  height: 10,),
                SizedBox(
                width: 320,
                height: 70,
                child: Card(
                  child: 
                  Center(child: Text('Mobile Programming Task 1')),
                ),
              ),
                SizedBox(
                width: 320,
                height: 70,
                child: Card(
                child: 
                Center(child: Text('System Enterprise Task 3')),
              ),
          ),
          SizedBox(
                  height: 20,),
          Text('Course',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 55, 55, 55)
                  )),
                SizedBox(
                  height: 10,),
                SizedBox(
                width: 320,
                height: 70,
                child: Card(
                  child: 
                  Center(child: Text('Mobile Programming : Widget')),
                ),
              ),
                SizedBox(
                width: 320,
                height: 70,
                child: Card(
                child: 
                Center(child: Text('Statistic : Correlation & Regression')),
              ),
          ),
          SizedBox(
                width: 320,
                height: 70,
                child: Card(
                  child: 
                  Center(child: Text('Statistic : Standard Deviation')),
                ),
              ),
                SizedBox(
                width: 320,
                height: 70,
                child: Card(
                child: 
                Center(child: Text('Information Security : Cryptography')),
              ),
          ),
          SizedBox(
                width: 320,
                height: 70,
                child: Card(
                  child: 
                  Center(child: Text('Information Security : Data Security')),
                ),
              ),
                SizedBox(
                width: 320,
                height: 70,
                child: Card(
                child: 
                Center(child: Text('IMS : DL/SQL, Web Service and API')),   
              ),
          )
              ], 
            ),
            
          ],
        ),
      ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
          icon: Icon(Icons.home,),
          label: 'Home',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.task,),
          label: 'Tasks',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.book,),
          label: 'Courses'
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble,),
          label: 'Chat'
          ),
          ],
        currentIndex: _selectedIndex,        
        onTap: _onItemTapped, // Handle item taps    
        selectedLabelStyle: const TextStyle(fontSize: 10),
        selectedItemColor: const Color.fromARGB(255, 0, 110, 141),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedItemColor: const Color.fromARGB(255, 212, 212, 212),
      ),
    );
  }
}