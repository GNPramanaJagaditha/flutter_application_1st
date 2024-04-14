import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });

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
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage('lib/images/profile1.jpg'),
          ),
          onPressed: () {
            // Add functionality for profile photo tap
          },
        ),
        // Setting icon
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Add functionality for settings icon tap
          },
        ),
      ],
    ),
    body: SingleChildScrollView(
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
        items: [
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
        selectedLabelStyle: TextStyle(fontSize: 10),
        selectedItemColor: Color.fromARGB(255, 0, 110, 141),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        unselectedItemColor: Color.fromARGB(255, 212, 212, 212),
      ),
    );
  }
}