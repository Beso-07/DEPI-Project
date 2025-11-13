import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/quran_search_service.dart';

/// Search page for finding verses and surahs in the Quran
class QuranSearchPage extends StatefulWidget {
  final Function(int pageNumber) onResultSelected;
  
  const QuranSearchPage({
    super.key,
    required this.onResultSelected,
  });

  @override
  State<QuranSearchPage> createState() => _QuranSearchPageState();
}

class _QuranSearchPageState extends State<QuranSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;
  String _lastQuery = '';
  int _selectedSearchType = 0; // 0 = verses, 1 = surah names
  
  @override
  void initState() {
    super.initState();
    // Initialize search service in background
    QuranSearchService.initialize();
    
    // Auto-focus search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
  
  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }
    
    if (query == _lastQuery) return; // Avoid duplicate searches
    
    setState(() {
      _isSearching = true;
      _lastQuery = query;
    });
    
    try {
      List<SearchResult> results;
      
      if (_selectedSearchType == 0) {
        // Search in verses
        results = await QuranSearchService.searchVerses(query);
      } else {
        // Search in surah names
        results = await QuranSearchService.searchBySurahName(query);
      }
      
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ في البحث: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'البحث في القرآن الكريم',
          style: GoogleFonts.amiri(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2F4F4F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2F4F4F),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                // Search input
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.amiri(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: _selectedSearchType == 0 
                          ? 'ابحث في آيات القرآن الكريم...'
                          : 'ابحث في أسماء السور...',
                      hintTextDirection: TextDirection.rtl,
                      prefixIcon: _isSearching
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2F4F4F)),
                                ),
                              ),
                            )
                          : const Icon(Icons.search, color: Color(0xFF2F4F4F)),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Color(0xFF666666)),
                              onPressed: () {
                                _searchController.clear();
                                _performSearch('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onChanged: (value) {
                      // Debounce search
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (_searchController.text == value) {
                          _performSearch(value);
                        }
                      });
                    },
                    onSubmitted: _performSearch,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Search type toggle
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSearchType = 0;
                            });
                            if (_searchController.text.isNotEmpty) {
                              _performSearch(_searchController.text);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedSearchType == 0 
                                  ? Colors.white 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'البحث في الآيات',
                              style: GoogleFonts.amiri(
                                color: _selectedSearchType == 0 
                                    ? const Color(0xFF2F4F4F) 
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSearchType = 1;
                            });
                            if (_searchController.text.isNotEmpty) {
                              _performSearch(_searchController.text);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedSearchType == 1 
                                  ? Colors.white 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'البحث في أسماء السور',
                              style: GoogleFonts.amiri(
                                color: _selectedSearchType == 1 
                                    ? const Color(0xFF2F4F4F) 
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Search results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSearchResults() {
    if (_searchController.text.trim().isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'اكتب للبحث في القرآن الكريم',
              style: GoogleFonts.amiri(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'يمكنك البحث في الآيات أو أسماء السور',
              style: GoogleFonts.amiri(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }
    
    if (_isSearching) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2F4F4F)),
            ),
            SizedBox(height: 16),
            Text(
              'جاري البحث...',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF2F4F4F),
              ),
            ),
          ],
        ),
      );
    }
    
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'لم يتم العثور على نتائج',
              style: GoogleFonts.amiri(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'جرب البحث بكلمات أخرى',
              style: GoogleFonts.amiri(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return _buildSearchResultCard(result);
      },
    );
  }
  
  Widget _buildSearchResultCard(SearchResult result) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          widget.onResultSelected(result.pageNumber);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Surah and verse info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F4F4F).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'صفحة ${result.pageNumber + 1}',
                      style: GoogleFonts.amiri(
                        fontSize: 12,
                        color: const Color(0xFF2F4F4F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${result.surah.name} - آية ${result.verse.verse}',
                    style: GoogleFonts.amiri(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2F4F4F),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Verse text
              Text(
                result.verse.text,
                style: GoogleFonts.amiri(
                  fontSize: 18,
                  height: 1.8,
                  color: Colors.black87,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
              
              const SizedBox(height: 8),
              
              // Navigate button
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    widget.onResultSelected(result.pageNumber);
                  },
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('انتقل للصفحة'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF2F4F4F),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}