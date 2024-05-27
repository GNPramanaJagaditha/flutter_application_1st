import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SavingsPage extends StatefulWidget {
  final String token;

  SavingsPage({Key? key, required this.token}) : super(key: key);

  @override
  _SavingsPageState createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  final TextEditingController _anggotaIdController = TextEditingController();
  final TextEditingController _trxIdController = TextEditingController();
  final TextEditingController _trxNominalController = TextEditingController();
  // final TextEditingController _jenisTransaksiController = TextEditingController();
  final Dio _dio = Dio();
  static const String _apiUrl = "https://mobileapis.manpits.xyz/api";

  List<dynamic> _filteredData = [];
  Map<String, dynamic> _saldoData = {};
  List<dynamic> _allTabunganData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Savings Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Show transaction form
                _showTransactionForm(context);
              },
              child: Text('Insert Transaksi Tabungan'),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Show filter form for getting master by jenis transaksi
            //     _showMasterFilterForm(context);
            //   },
            //   child: Text('Get Master by Jenis Transaksi'),
            // ),
            // SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show filter form for getting saldo by id
                _showSaldoFilterForm(context);
              },
              child: Text('Get Saldo by ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show filter form for getting all tabungan by id
                _showAllTabunganFilterForm(context);
              },
              child: Text('Get All Tabungan by ID'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _buildFilteredData(),
            ),
            if (_saldoData.isNotEmpty)
              Expanded(
                child: _buildSaldoData(),
              ),
            if (_allTabunganData.isNotEmpty)
              Expanded(
                child: _buildAllTabunganData(),
              ),
          ],
        ),
      ),
    );
  }

 Widget _buildFilteredData() {
  return ListView.builder(
    itemCount: _filteredData.length,
    itemBuilder: (BuildContext context, int index) {
      Map<String, dynamic> item = _filteredData[index];
      return Card(
        child: Column(
          children: [
            ListTile(
              title: Text(item['title']), // Replace 'title' with actual key
              subtitle: Text(item['subtitle']), // Replace 'subtitle' with actual key
            ),
            ElevatedButton(
              onPressed: () {
                // Close button action
                _clearFilteredDataItem(index);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildSaldoData() {
  return Card(
    child: Column(
      children: [
        ListTile(
          title: Text('Saldo'),
          subtitle: Text('Anggota ID: ${_saldoData['anggota_id']}\nSaldo: ${_saldoData['saldo']}'),
        ),
        ElevatedButton(
          onPressed: () {
            // Close button action
            _clearSaldoData();
          },
          child: Text('Close'),
        ),
      ],
    ),
  );
}

Widget _buildAllTabunganData() {
  return ListView.builder(
    itemCount: _allTabunganData.length,
    itemBuilder: (BuildContext context, int index) {
      Map<String, dynamic> item = _allTabunganData[index];
      return Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Transaksi ID: ${item['id']}'),
              subtitle: Text('Tanggal: ${item['trx_tanggal']}\nNominal: ${item['trx_nominal']}'),
            ),
            ElevatedButton(
              onPressed: () {
                // Close button action
                _clearAllTabunganDataItem(index);
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}

void _clearFilteredDataItem(int index) {
  setState(() {
    _filteredData.removeAt(index);
  });
}

void _clearSaldoData() {
  setState(() {
    _saldoData = {};
  });
}

void _clearAllTabunganDataItem(int index) {
  setState(() {
    _allTabunganData.removeAt(index);
  });
}

  void _showTransactionForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Insert Transaksi Tabungan"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _anggotaIdController,
                  decoration: InputDecoration(labelText: 'Anggota ID'),
                ),
                TextField(
                  controller: _trxIdController,
                  decoration: InputDecoration(labelText: 'Transaction ID'),
                ),
                TextField(
                  controller: _trxNominalController,
                  decoration: InputDecoration(labelText: 'Transaction Nominal'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Call API to insert transaksi tabungan
                _insertTransaksiTabungan();
                Navigator.of(context).pop();
              },
              child: Text('Insert'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // void _showMasterFilterForm(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Filter Master by Jenis Transaksi"),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // You can add additional fields if needed
  //               TextField(
  //                 controller: _jenisTransaksiController, // Assuming you have _jenisTransaksiController
  //                 decoration: InputDecoration(labelText: 'Jenis Transaksi'),
  //               ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Call API to get master by jenis transaksi
                //     _getMasterByJenisTransaksi(_jenisTransaksiController.text);
                //     Navigator.of(context).pop();
                //   },
                //   child: Text('Apply Filter'),
                // ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showSaldoFilterForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filter Saldo by ID"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _anggotaIdController, // Assuming you have _anggotaIdController
                  decoration: InputDecoration(labelText: 'Anggota ID'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Call API to get saldo by id
                    _getSaldoById(_anggotaIdController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('Apply Filter'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAllTabunganFilterForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filter All Tabungan by ID"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _anggotaIdController, // Assuming you have _anggotaIdController
                  decoration: InputDecoration(labelText: 'Anggota ID'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Call API to get all tabungan by id
                    _getAllTabunganById(_anggotaIdController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('Apply Filter'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _insertTransaksiTabungan() async {
    try {
      final response = await _dio.post(
        "$_apiUrl/tabungan",
        data: {
          'anggota_id': _anggotaIdController.text,
          'trx_id': _trxIdController.text,
          'trx_nominal': _trxNominalController.text,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Proses penyisipan data berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transaksi tabungan berhasil ditambahkan')),
        );
      } else {
        // Penyisipan data gagal karena respons status code yang tidak sesuai
        print('Error adding transaksi tabungan. Response code: ${response.statusCode}');
        print('Response data: ${response.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan transaksi tabungan. Status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // Terjadi kesalahan selama proses penyisipan data
      print('Error adding transaksi tabungan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan transaksi tabungan')),
      );
    }
  }

  void _getSaldoById(String anggotaId) async {
    try {
      final response = await _dio.get(
        "$_apiUrl/saldo/$anggotaId",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      setState(() {
        _saldoData = response.data['data'];
      });
    } catch (e) {
      print('Error getting saldo by id: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mendapatkan saldo')),
      );
    }
  }

  void _getAllTabunganById(String anggotaId) async {
    try {
      final response = await _dio.get(
        "$_apiUrl/tabungan/$anggotaId",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      setState(() {
        _allTabunganData = response.data['data']['tabungan'];
      });
    } catch (e) {
      print('Error getting all tabungan by id: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mendapatkan semua tabungan')),
      );
    }
  }
}
//   void _getMasterByJenisTransaksi(String jenisTransaksi) async {
//     try {
//       final response = await _dio.get(
//         "$_apiUrl/jenistransaksi",
//         queryParameters: {'jenis_transaksi': jenisTransaksi},
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer ${widget.token}',
//           },
//         ),
//       );

//       setState(() {
//         _filteredData = response.data;
//       });
//     } catch (e) {
//       print('Error getting master by jenis transaksi: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Gagal mendapatkan master by jenis transaksi')),
//       );
//     }
//   }
// }