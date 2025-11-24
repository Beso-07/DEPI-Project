import 'package:flutter/material.dart';
import 'package:depiproject/features/Quran/models/saved_verse.dart';
import 'package:depiproject/features/Quran/services/saved_verses_service.dart';

class SavedVersesScreen extends StatefulWidget {
  final List<SavedVerse> verses;

  const SavedVersesScreen({super.key, required this.verses});

  @override
  State<SavedVersesScreen> createState() => _SavedVersesScreenState();
}

class _SavedVersesScreenState extends State<SavedVersesScreen> {
  late List<SavedVerse> _verses;

  @override
  void initState() {
    super.initState();
    _verses = widget.verses;
  }

  Future<void> _removeVerse(SavedVerse verse) async {
    await SavedVersesService.removeSavedVerse(
      verse.surahNumber,
      verse.verseNumber,
    );
    setState(() {
      _verses.remove(verse);
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حذف الآية من المحفوظات'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _shareVerse(SavedVerse verse) async {
    await SavedVersesService.shareVerse(
      verseText: verse.verseText,
      surahName: verse.surahName,
      verseNumber: verse.verseNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "الآيات المحفوظة",
          style: TextStyle(
            fontFamily: 'Lateef',
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: _verses.isEmpty
          ? const Center(
              child: Text(
                "لا توجد آيات محفوظة بعد",
                style: TextStyle(fontSize: 22, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _verses.length,
              itemBuilder: (context, index) {
                final verse = _verses[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header with surah info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'سورة ${verse.surahName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'آية ${verse.verseNumber}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Verse text
                        Text(
                          verse.verseText,
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: 'Lateef',
                            height: 1.8,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Footer with date and actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'حُفظت في: ${_formatDate(verse.savedAt)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Row(
                              children: [
                                // Share button
                                IconButton(
                                  icon: const Icon(Icons.share),
                                  color: Colors.blue,
                                  onPressed: () => _shareVerse(verse),
                                  tooltip: 'مشاركة',
                                ),
                                // Delete button
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('تأكيد الحذف'),
                                        content: const Text(
                                          'هل تريد حذف هذه الآية من المحفوظات؟',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('إلغاء'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text(
                                              'حذف',
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      await _removeVerse(verse);
                                    }
                                  },
                                  tooltip: 'حذف',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'اليوم';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else if (difference.inDays < 30) {
      return 'منذ ${(difference.inDays / 7).floor()} أسابيع';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
