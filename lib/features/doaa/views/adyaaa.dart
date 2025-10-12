import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoaaPage extends StatefulWidget {
  const DoaaPage({super.key});

  @override
  State<DoaaPage> createState() => _DoaaPageState();
}

class _DoaaPageState extends State<DoaaPage> {
  List<dynamic> _doaaList = [];

  @override
  void initState() {
    super.initState();
    loadDoaa();
  }

  Future<void> loadDoaa() async {
    final String response = await rootBundle.loadString('assets/doaa.json');
    final data = await json.decode(response);
    setState(() {
      _doaaList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f8f3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'الأدعية والتحصين',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _doaaList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _doaaList.length,
              itemBuilder: (context, index) {
                var item = _doaaList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ExpansionTile(
                    leading: const Icon(Icons.menu_book, color: Colors.green),
                    title: Text(
                      item['category'],
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    children: [
                      ...item['array'].map<Widget>(
                        (dua) => ListTile(
                          title: Text(
                            dua['text'],
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
