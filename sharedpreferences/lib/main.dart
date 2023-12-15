import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SharedPreferencesApp());
}

class SharedPreferencesApp extends StatelessWidget {
  const SharedPreferencesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Demo SharedPreferences',
      home: DemoSharedPreferences(),
    );
  }
}

class DemoSharedPreferences extends StatefulWidget {
  const DemoSharedPreferences({Key? key}) : super(key: key);

  @override
  _DemoSharedPreferencesState createState() => _DemoSharedPreferencesState();
}

class _DemoSharedPreferencesState extends State<DemoSharedPreferences> {
  late Future<SharedPreferences> _prefs;
  late Future<String> _namaPengguna;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _namaPengguna = _prefs.then((SharedPreferences prefs) =>
        prefs.getString('namaPengguna') ?? 'Imam Gozali');
  }

  Future<void> _aturNamaPengguna(String namaBaru) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _namaPengguna =
          prefs.setString('namaPengguna', namaBaru).then((bool berhasil) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Anda adalah seorang $namaBaru'),
            duration: const Duration(seconds: 2),
          ),
        );
        return namaBaru;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo SharedPreferences'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _namaPengguna,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const CircularProgressIndicator()
                : snapshot.hasError
                    ? Text('Error: ${snapshot.error}')
                    : Text(
                        'Halo, ${snapshot.data}!\n\nKetahui identitas anda dengan mengklik tombol.',
                      );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _aturNamaPengguna('Spiderman'),
        tooltip: 'Atur Nama Pengguna',
        child: const Icon(Icons.person),
      ),
    );
  }
}
