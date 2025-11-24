import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/surah_index_service.dart';

/// Index page that displays all surahs in a grid layout
/// Allows users to navigate directly to any surah's starting page
class SurahIndexPage extends StatefulWidget {
  final Function(int pageNumber) onSurahSelected;
  final double? availableHeight;
  final double? availableWidth;
  
  const SurahIndexPage({
    super.key,
    required this.onSurahSelected,
    this.availableHeight,
    this.availableWidth,
  });

  @override
  State<SurahIndexPage> createState() => _SurahIndexPageState();
}

class _SurahIndexPageState extends State<SurahIndexPage> {
  List<SurahPageInfo> _surahsInfo = [];
  List<SurahPageInfo> _filteredSurahs = [];
  bool _isLoading = true;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSurahsInfo();
    _searchController.addListener(_filterSurahs);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSurahs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSurahs = _surahsInfo;
      } else {
        _filteredSurahs = _surahsInfo.where((surahInfo) {
          return surahInfo.surah.name.contains(query) ||
                 surahInfo.surah.transliteration.toLowerCase().contains(query) ||
                 surahInfo.surah.id.toString().contains(query);
        }).toList();
      }
    });
  }

  Future<void> _loadSurahsInfo() async {
    try {
      // Load surah information with actual calculated page numbers
      final surahsInfo = await SurahIndexService.getAllSurahsWithPages(
        availableHeight: widget.availableHeight,
        availableWidth: widget.availableWidth,
      );
      
      setState(() {
        _surahsInfo = surahsInfo;
        _filteredSurahs = surahsInfo; // Initialize filtered list
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'فشل في تحميل فهرس السور: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFF8), // Off-white background
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2F4F4F)),
            ),
            SizedBox(height: 16),
            Text(
              'جاري تحميل فهرس السور...',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF2F4F4F),
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadSurahsInfo,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'ابحث عن سورة...',
              hintStyle: const TextStyle(color: Color(0xFF888888)),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF2F4F4F)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: const Color(0xFF8B4513).withValues(alpha: 0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: const Color(0xFF8B4513).withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF2F4F4F),
                  width: 2,
                ),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF2F4F4F),
            ),
          ),
        ),
        
        // Grid of surahs
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9, // Changed to make cards taller for better visibility
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _filteredSurahs.length,
              itemBuilder: (context, index) {
                final surahInfo = _filteredSurahs[index];
                return _buildSurahCard(surahInfo);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSurahCard(SurahPageInfo surahInfo) {
    final surah = surahInfo.surah;
    final pageNumber = surahInfo.startPage + 1; // Convert to 1-based for display
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Navigate to the surah's starting page
          widget.onSurahSelected(surahInfo.startPage);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                const Color(0xFF8B4513).withValues(alpha: 0.08),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF8B4513).withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                offset: const Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Surah number circle
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF2F4F4F),
                        const Color(0xFF8B4513),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        offset: const Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${surah.id}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Surah name
                Text(
                  surah.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2F4F4F),
                    fontFamily: GoogleFonts.amiri().fontFamily,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),
                
                // Page number badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF8B4513).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'صفحة $pageNumber',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                ),
                
                const SizedBox(height: 6),
                
                // Verses count and type
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: surah.isMeccan 
                            ? const Color(0xFF8B4513).withValues(alpha: 0.15)
                            : const Color(0xFF2F4F4F).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        surah.type,
                        style: TextStyle(
                          fontSize: 11,
                          color: surah.isMeccan 
                              ? const Color(0xFF8B4513)
                              : const Color(0xFF2F4F4F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${surah.totalVerses} آية',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}