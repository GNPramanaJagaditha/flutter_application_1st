import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MemberListPage extends StatefulWidget {
  final String token;

  MemberListPage({Key? key, required this.token}) : super(key: key ?? ValueKey('course_lending_page_key'));

  @override
  _MemberListPageState createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  List<dynamic> members = [];
  late Dio _dio;
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api";

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _fetchMemberList();
  }

  Future<void> _fetchMemberList() async {
    try {
      final response = await _dio.get(
        '$_apiUrl/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${widget.token}'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        setState(() {
          members = data;
        });
      } else {
        // Handle error
        print('Failed to load members: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daftar Anggota',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Tambahkan tabel untuk menampilkan daftar anggota
            Expanded(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Nama')),
                  DataColumn(label: Text('Nomor Induk')),
                ],
                rows: members.map((member) {
                  return DataRow(cells: [
                    DataCell(Text(member['nama'])),
                    DataCell(Text(member['nomor_induk'])),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
