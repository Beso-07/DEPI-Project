import 'dart:convert';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Asmaa extends StatefulWidget {
  const Asmaa({super.key});

  @override
  State<Asmaa> createState() => _AsmaaState();
}

class _AsmaaState extends State<Asmaa> {
  List<dynamic> _asmaaList = [];

  @override
  void initState() {
    super.initState();
    loadAsmaa();
  }

  Future<void> loadAsmaa() async {
    final String response =
        await rootBundle.loadString('assets/json/asmaul_husna.json');
    final data = json.decode(response);
    setState(() {
      _asmaaList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          const MainAppBar(title: 'أسماء الله الحسنى'),
          SizedBox(height: height * 0.03),
          _asmaaList.isEmpty
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _asmaaList.length,
                    itemBuilder: (context, index) {
                      var item = _asmaaList[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: AppColors.kPrimaryColor2.withOpacity(.6),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor:
                                Colors.transparent,
                          ),
                          child: ExpansionTile(
                            leading: const Icon(
                              Icons.menu_book,
                              color: Colors.white,
                            ),
                            title: Text(
                              item['name'],
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            iconColor: Colors.black,
                            collapsedIconColor: Colors.white,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  item['text'],
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
