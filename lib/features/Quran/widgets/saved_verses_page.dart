import 'package:flutter/material.dart';
import '../models/saved_verse.dart';
import '../services/saved_verses_service.dart';

class SavedVersesPage extends StatefulWidget {
  const SavedVersesPage({super.key});

  @override
  State<SavedVersesPage> createState() => _SavedVersesPageState();
}

class _SavedVersesPageState extends State<SavedVersesPage> {
  List<SavedVerse> savedVerses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedVerses();
  }

  void _loadSavedVerses() {
    try {
      setState(() {
        savedVerses = SavedVersesService.getAllSavedVerses();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ في تحميل الآيات المحفوظة: $e')),
      );
    }
  }

  Future<void> _removeVerse(SavedVerse verse) async {
    try {
      await SavedVersesService.removeSavedVerse(
        verse.surahNumber,
        verse.verseNumber,
      );
      _loadSavedVerses();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حذف الآية من المحفوظات')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ في حذف الآية: $e')),
        );
      }
    }
  }

  Future<void> _shareVerse(SavedVerse verse) async {
    try {
      await SavedVersesService.shareVerse(
        verseText: verse.verseText,
        surahName: verse.surahName,
        verseNumber: verse.verseNumber,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ في مشاركة الآية: $e')),
        );
      }
    }
  }

  Future<void> _clearAllSavedVerses() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل تريد حذف جميع الآيات المحفوظة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await SavedVersesService.clearAllSavedVerses();
        _loadSavedVerses();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم حذف جميع الآيات المحفوظة')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('حدث خطأ في حذف الآيات: $e')),
          );
        }
      }
    }
  }

  void _navigateToPage(int pageNumber) {
    Navigator.of(context).pop(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الآيات المحفوظة'),
        actions: [
          if (savedVerses.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: _clearAllSavedVerses,
              tooltip: 'حذف جميع الآيات',
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : savedVerses.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_border,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'لا توجد آيات محفوظة',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: savedVerses.length,
                  itemBuilder: (context, index) {
                    final verse = savedVerses[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Verse text
                            Text(
                              verse.verseText,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.8,
                              ),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 12),

                            // Surah info
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'صفحة ${verse.pageNumber}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'سورة ${verse.surahName} - آية ${verse.verseNumber}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Save date
                            Text(
                              'تم الحفظ: ${_formatDate(verse.savedAt)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 12),

                            // Action buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton.icon(
                                  onPressed: () =>
                                      _navigateToPage(verse.pageNumber),
                                  icon: const Icon(Icons.book, size: 12),
                                  label: const Text(
                                    'انتقال للصفحة',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () => _shareVerse(verse),
                                  icon: const Icon(Icons.share, size: 18),
                                  label: const Text('مشاركة'),
                                ),
                                TextButton.icon(
                                  onPressed: () => _removeVerse(verse),
                                  icon: const Icon(Icons.delete, size: 18),
                                  label: const Text('حذف'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
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
    return '${date.day}/${date.month}/${date.year}';
  }
}
