import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _dio = Dio();
  final _storage = GetStorage();
  final _apiUrl = 'https://mobileapis.manpits.xyz/api';

  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    // Call goUser when the widget initializes
    goUser();
  }

  Future<void> goUser() async {
    try {
      final _response = await _dio.get(
        '$_apiUrl/user',
        options: Options(
          headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
        ),
      );
      setState(() {
        _userData = _response.data['data']['user']; // Update the user data
      });
      print(_response.data);
    } on DioError catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: _userData == null
            ? CircularProgressIndicator() // Show loading indicator if data is being fetched
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('lib/images/profile1.jpg'), // Add a dummy profile picture
                  ),
                  SizedBox(height: 20),
                  Text(
                    'User Profile Data:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Username: ${_userData!['name']}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${_userData!['email']}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
