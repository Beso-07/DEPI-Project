import 'package:flutter/material.dart';
import '../services/app_preferences_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showIndexOnStartup = true;
  double _fontSize = 22.0;
  bool _isLoading = true;
  int _lastPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    try {
      final showIndex = await AppPreferencesService.getShowIndexOnStartup();
      final fontSize = await AppPreferencesService.getFontSize();
      final lastPage = await AppPreferencesService.getLastPageIndex();
      
      if (mounted) {
        setState(() {
          _showIndexOnStartup = showIndex;
          _fontSize = fontSize;
          _lastPageIndex = lastPage;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updateShowIndexOnStartup(bool value) async {
    try {
      await AppPreferencesService.setShowIndexOnStartup(value);
      setState(() {
        _showIndexOnStartup = value;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value ? 'سيتم عرض فهرس السور عند بدء التطبيق' : 'سيتم فتح آخر صفحة مقروءة عند بدء التطبيق'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ في حفظ الإعدادات: $e')),
        );
      }
    }
  }

  Future<void> _updateFontSize(double value) async {
    try {
      await AppPreferencesService.saveFontSize(value);
      setState(() {
        _fontSize = value;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ في حفظ حجم الخط: $e')),
        );
      }
    }
  }

  Future<void> _resetToDefaults() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إعادة تعيين الإعدادات'),
        content: const Text('هل تريد إعادة تعيين جميع الإعدادات إلى القيم الافتراضية؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('إعادة تعيين'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await AppPreferencesService.clearAllPreferences();
        _loadSettings(); // Reload default settings
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إعادة تعيين الإعدادات بنجاح')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('حدث خطأ في إعادة التعيين: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        backgroundColor: const Color(0xFF2F4F4F),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Startup behavior section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'سلوك بدء التطبيق',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('عرض فهرس السور عند البدء'),
                          subtitle: Text(
                            _showIndexOnStartup
                                ? 'سيتم عرض فهرس السور أولاً'
                                : 'سيتم فتح آخر صفحة مقروءة مباشرة',
                          ),
                          value: _showIndexOnStartup,
                          onChanged: _updateShowIndexOnStartup,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Font size section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'حجم الخط',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'الحجم الحالي: ${_fontSize.toInt()}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          value: _fontSize,
                          min: 16.0,
                          max: 32.0,
                          divisions: 16,
                          label: _fontSize.toInt().toString(),
                          onChanged: _updateFontSize,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'مثال على النص بالحجم المحدد',
                          style: TextStyle(fontSize: _fontSize),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // App info section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'معلومات التطبيق',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text('الصفحة الحالية'),
                          subtitle: Text('صفحة ${_lastPageIndex + 1} من 602'),
                          leading: const Icon(Icons.book),
                        ),
                        ListTile(
                          title: const Text('عدد الآيات المحفوظة'),
                          subtitle: const Text('يمكنك عرضها من الآيات المحفوظة'),
                          leading: const Icon(Icons.bookmark),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Reset button
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إعادة تعيين',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _resetToDefaults,
                            icon: const Icon(Icons.restore),
                            label: const Text('إعادة تعيين جميع الإعدادات'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}