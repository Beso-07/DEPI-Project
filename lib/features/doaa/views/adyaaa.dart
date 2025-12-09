import 'dart:convert';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/helpers/hive_helper.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

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
    final String response =
        await rootBundle.loadString('assets/json/doaa.json');
    final data = await json.decode(response);
    setState(() {
      _doaaList = data;
    });
  }

  bool isSaved(Map<String, dynamic> dua) {
    return HiveHelper.isSaved(
      items: HiveHelper.doaa,
      item: dua,
      key: HiveHelper.doaaKey,
    );
  }

  Future<void> _toggleSave(Map<String, dynamic> dua) async {
    await HiveHelper.toggleSaved(
      key: HiveHelper.doaaKey,
      items: HiveHelper.doaa,
      item: dua,
    );
    await HiveHelper.getMyNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          const MainAppBar(title: 'الأدعية'),
          SizedBox(height: height * .03),
          _doaaList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _doaaList.length,
                    itemBuilder: (context, index) {
                      var item = _doaaList[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: AppColors.kPrimaryColor2.withOpacity(.6),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            leading: const Icon(Icons.menu_book,
                                color: Colors.white),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item['category'],
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isSaved(item)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: isSaved(item)
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  onPressed: () async {
                                    await _toggleSave(item);
                                  },
                                ),
                              ],
                            ),
                            iconColor: Colors.black,
                            collapsedIconColor: Colors.white,
                            children: [
                              ...item['array'].map<Widget>((dua) {
                                return ListTile(
                                  title: Text(
                                    dua['text'],
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: () async {
                                      await Share.share(
                                        dua['text'],
                                        subject: 'دعاء من تطبيق تقوي 📿',
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
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
