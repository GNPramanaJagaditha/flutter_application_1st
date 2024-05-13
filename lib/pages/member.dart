import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class Member {
  final int? id;
  final int nomorInduk;
  final String name;
  final String address;
  final String dateOfBirth;
  final String phoneNumber;
  final String? imageUrl;
  final int? isActive;

  Member({
    this.id,
    required this.nomorInduk,
    required this.name,
    required this.address,
    required this.dateOfBirth,
    required this.phoneNumber,
    this.imageUrl,
    this.isActive,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json["id"],
      nomorInduk: json["nomor_induk"],
      name: json["nama"],
      address: json["alamat"],
      dateOfBirth: json["tgl_lahir"],
      phoneNumber: json["telepon"],
      imageUrl: json["imageUrl"],
      isActive: json["id"]);
  }
}

class MemberPage extends StatefulWidget {
  final String token;

  MemberPage({Key? key, required this.token}) : super(key: key ?? ValueKey('course_lending_page_key'));

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final TextEditingController _nomorIndukController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final Dio _dio = Dio();
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api";
  bool _showMemberList = false;
  List<Member> _members = [];

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    try {
      final response = await _dio.get(
        "$_apiUrl/anggota",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final dynamic data = responseData['data']['anggotas'];
        if (responseData.containsKey('data')) {
          if (data is List) {
            setState(() {
              _members = data.map((member) => Member.fromJson(member)).toList();
            });
          } else {
            print('Error fetching members: Response data is not a list.');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal memuat daftar anggota: Data respons tidak dalam bentuk list.')),
            );
          }
        } else {
          print('Error fetching members: Data key not found in response.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memuat daftar anggota: Key data tidak ditemukan dalam respons.')),
          );
        }
      } else {
        print('Error fetching members. Response code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat daftar anggota. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error fetching members: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat daftar anggota')),
      );
    }
  }

  void _addAnggota() async {
    try {
      final response = await _dio.post(
        "$_apiUrl/anggota",
        data: FormData.fromMap({
          'nomor_induk': _nomorIndukController.text,
          'nama': _namaController.text,
          'alamat': _alamatController.text,
          'tgl_lahir': _tglLahirController.text,
          'telepon': _teleponController.text,
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Anggota berhasil ditambahkan')),
        );
        _clearTextFields();
        await _fetchMembers();
        setState(() {
          _showMemberList = true;
        });
      } else {
        print('Error adding anggota. Response code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan anggota. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error adding anggota: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan anggota')),
      );
    }
  }

  void _editAnggota(Member member) async {
    try {
      final response = await _dio.put(
        "$_apiUrl/anggota/${member.id}",
        data: FormData.fromMap({
          'nomor_induk': _nomorIndukController.text,
          'nama': _namaController.text,
          'alamat': _alamatController.text,
          'tgl_lahir': _tglLahirController.text,
          'telepon': _teleponController.text,
          'status_aktif': 1,
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Anggota berhasil diperbarui')),
        );
        _clearTextFields();
        await _fetchMembers();
        setState(() {
          _showMemberList = true;
        });
      } else {
        print('Error updating anggota. Response code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui anggota. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error updating anggota: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui anggota')),
      );
    }
  }

  void _deleteAnggota(int memberId) async {
    try {
      final response = await _dio.delete(
        "$_apiUrl/anggota/$memberId",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Anggota berhasil dihapus')),
        );
        await _fetchMembers();
      } else {
        print('Error deleting anggota. Response code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus anggota. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Error deleting anggota: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus anggota')),
      );
    }
  }

  void _clearTextFields() {
    _nomorIndukController.clear();
    _namaController.clear();
    _alamatController.clear();
    _tglLahirController.clear();
    _teleponController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Lending'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _showMemberList ? _buildMemberList() : _buildAddMemberForm(),
        ),
      ),
    );
  }

  Widget _buildAddMemberForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _nomorIndukController,
          decoration: InputDecoration(
            labelText: 'Nomor Induk',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _namaController,
          decoration: InputDecoration(
            labelText: 'Nama',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _alamatController,
          decoration: InputDecoration(
            labelText: 'Alamat',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _tglLahirController,
          decoration: InputDecoration(
            labelText: 'Tanggal Lahir (YYYY-MM-DD)',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _teleponController,
          decoration: InputDecoration(
            labelText: 'Telepon',
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addAnggota,
          child: Text('Tambah Anggota'),
        ),
                SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Mengambil anggota yang sedang dipilih untuk diedit
            final selectedMember = _members.firstWhere((member) => member.nomorInduk == int.parse(_nomorIndukController.text));
            _editAnggota(selectedMember);
          },
          child: Text('Simpan Perubahan'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showMemberList = true;
            });
          },
          child: Text('View Members'),
          
        ),
      ],
    );
  }

  Widget _buildMemberList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showMemberList = false;
            });
          },
          child: Text('Back to Add Member'),
        ),
        SizedBox(height: 16),
        Text(
          'Daftar Anggota',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _members.length,
            itemBuilder: (context, index) {
              final member = _members[index];
              return ListTile(
                title: Text(member.name),
                subtitle: Text(member.nomorInduk.toString()),
                onTap: () {
                  // Ketika anggota dipilih, isi form dengan data anggota tersebut
                  _nomorIndukController.text = member.nomorInduk.toString();
                  _namaController.text = member.name;
                  _alamatController.text = member.address;
                  _tglLahirController.text = member.dateOfBirth;
                  _teleponController.text = member.phoneNumber;
                  // Ubah fungsi tombol tambah anggota menjadi fungsi edit
                  setState(() {
                    _showMemberList = false;
                  });
                },
                trailing: ElevatedButton(
                  onPressed: () {
                    _deleteAnggota(member.id!);
                  },
                  child: Text('Delete'),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Mengambil anggota yang sedang dipilih untuk diedit
            final selectedMember = _members.firstWhere((member) => member.nomorInduk == int.parse(_nomorIndukController.text));
            _editAnggota(selectedMember);
          },
          child: Text('Simpan Perubahan'),
        ),
      ],
    );
  }
}
