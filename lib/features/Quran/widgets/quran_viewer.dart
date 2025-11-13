import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/quran_pagination_service.dart';
import '../services/saved_verses_service.dart';
import '../services/app_preferences_service.dart';
import '../models/verse.dart';
import 'surah_index_page.dart';
import 'quran_search_page.dart';
import 'saved_verses_page.dart';

/// Main widget that displays the Quran in a page-by-page format
/// Mimics the appearance of a traditional printed mushaf
/// 
/// Features:
/// - Index page with all surahs in grid layout
/// - Exactly 602 pages (traditional mushaf count)
/// - Arabic reading direction: starts from left, left arrow goes to next page
/// - Right-to-left page navigation
/// - Special layout: Al-Fatiha on page 1, first 5 verses of Al-Baqarah on page 2
/// - Continuous text flow: verses continue on the same line, not new lines
class QuranViewer extends StatefulWidget {
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsets padding;

  const QuranViewer({
    super.key,
    this.fontSize = 24.0,
    this.backgroundColor = const Color(0xFFFFFFF8), // Off-white background
    this.textColor = const Color(0xFF2F4F4F), // Dark slate gray
    this.padding = const EdgeInsets.all(20.0),
  });

  @override
  State<QuranViewer> createState() => _QuranViewerState();
}

class _QuranViewerState extends State<QuranViewer> {
  final PageController _pageController = PageController();
  List<QuranPage> _pages = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _currentPageIndex = 0;
  bool _showIndex = true; // Start with index page
  
  @override
  void initState() {
    super.initState();
    _loadQuranPages();
    _loadLastPagePosition();
  }
  
  /// Load the last saved page position
  void _loadLastPagePosition() async {
    try {
      final lastPageIndex = await AppPreferencesService.getLastPageIndex();
      final showIndexOnStartup = await AppPreferencesService.getShowIndexOnStartup();
      final isFirstRun = await AppPreferencesService.isFirstRun();
      
      // If it's the first run or user prefers to show index, start with index
      if (isFirstRun || showIndexOnStartup) {
        if (mounted) {
          setState(() {
            _showIndex = true;
            _currentPageIndex = lastPageIndex;
          });
        }
      } else {
        // Otherwise, go directly to the last page
        if (mounted) {
          setState(() {
            _showIndex = false;
            _currentPageIndex = lastPageIndex;
          });
        }
      }
    } catch (e) {
      // If there's an error, start with the index page
      if (mounted) {
        setState(() {
          _showIndex = true;
          _currentPageIndex = 0;
        });
      }
    }
  }

  /// Save the current page position to preferences
  void _saveCurrentPagePosition(int pageIndex) {
    try {
      AppPreferencesService.saveLastPageIndex(pageIndex);
    } catch (e) {
      // Silently fail if unable to save - not critical for app functionality
      debugPrint('Failed to save page position: $e');
    }
  }

  /// Loads and paginates the Quran content
  Future<void> _loadQuranPages() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // We'll calculate pages after the first frame is rendered
      // to get accurate screen dimensions
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _calculatePages();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load Quran: $e';
      });
    }
  }

  /// Calculates pages based on screen dimensions
  Future<void> _calculatePages() async {
    try {
      final screenSize = MediaQuery.of(context).size;
      final appBarHeight = AppBar().preferredSize.height;
      final statusBarHeight = MediaQuery.of(context).padding.top;
      
      // Calculate available space for content
      final availableHeight = screenSize.height - 
          appBarHeight - 
          statusBarHeight - 
          widget.padding.vertical -
          120; // Extra space for page indicator and controls
      
      final availableWidth = screenSize.width - widget.padding.horizontal;

      // Create pages using pagination service
      final pages = await QuranPaginationService.createPages(
        availableHeight: availableHeight,
        availableWidth: availableWidth,
        fontSize: widget.fontSize,
        fontFamily: 'Amiri', // We'll set this up with Google Fonts
        padding: widget.padding,
      );

      setState(() {
        _pages = pages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to create pages: $e';
      });
    }
  }

  /// Navigates to the next page
  void _nextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Page position will be saved automatically in onPageChanged
    }
  }

  /// Navigates to the previous page
  void _previousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Page position will be saved automatically in onPageChanged
    }
  }

  /// Goes to a specific page
  void _goToPage(int pageIndex) {
    if (pageIndex >= 0 && pageIndex < _pages.length) {
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Page position will be saved automatically in onPageChanged
    }
  }

  /// Navigates to a specific page from the index
  void _navigateToPage(int pageNumber) {
    setState(() {
      _showIndex = false;
      _currentPageIndex = pageNumber;
    });
    
    // Save the new page position
    _saveCurrentPagePosition(pageNumber);
    
    if (_pages.isNotEmpty && pageNumber >= 0 && pageNumber < _pages.length) {
      // Use WidgetsBinding to ensure the page controller is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            pageNumber,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  /// Shows the index page
  void _showIndexPage() {
    setState(() {
      _showIndex = true;
    });
  }

  /// Shows the search page
  void _showSearchPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuranSearchPage(
          onResultSelected: (pageNumber) {
            Navigator.of(context).pop(); // Close search page
            _navigateToPage(pageNumber);
          },
        ),
      ),
    );
  }

  /// Shows the saved verses page
  void _showSavedVersesPage() async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (context) => const SavedVersesPage(),
      ),
    );
    
    // If a page number was returned, navigate to it
    if (result != null) {
      _navigateToPage(result - 1); // Convert from 1-based to 0-based index
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        title: Text(
          _showIndex ? 'فهرس السور' : 'القرآن الكريم', // "Index of Surahs" or "The Holy Quran"
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2F4F4F),
        elevation: 2,
        centerTitle: true,
        leading: _showIndex ? null : IconButton(
          icon: const Icon(Icons.list, color: Colors.white),
          onPressed: _showIndexPage,
          tooltip: 'فهرس السور',
        ),
        actions: [
          if (!_showIndex && !_isLoading && _pages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: _showSearchPage,
              tooltip: 'البحث',
            ),
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.white),
            onPressed: _showSavedVersesPage,
            tooltip: 'الآيات المحفوظة',
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _showIndex ? null : _buildBottomNavigationBar(),
    );
  }

  /// Builds the main body content
  Widget _buildBody() {
    // Show index page
    if (_showIndex) {
      // Calculate the same dimensions used for pagination
      final screenSize = MediaQuery.of(context).size;
      final appBarHeight = AppBar().preferredSize.height;
      final statusBarHeight = MediaQuery.of(context).padding.top;
      
      final availableHeight = screenSize.height - 
          appBarHeight - 
          statusBarHeight - 
          widget.padding.vertical -
          120; // Extra space for page indicator and controls
      
      final availableWidth = screenSize.width - widget.padding.horizontal;
      
      return SurahIndexPage(
        onSurahSelected: _navigateToPage,
        availableHeight: availableHeight,
        availableWidth: availableWidth,
      );
    }
    
    // Show Quran pages
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
              'جاري تحميل القرآن الكريم (602 صفحة)...', // "Loading the Holy Quran (602 pages)..."
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
              onPressed: _loadQuranPages,
              child: const Text('إعادة المحاولة'), // "Try Again"
            ),
          ],
        ),
      );
    }

    if (_pages.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد صفحات للعرض', // "No pages to display"
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Column(
      children: [
        // Page content
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            reverse: true, // Start from right and move left (Arabic reading direction)
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
              _saveCurrentPagePosition(index);
            },
            itemBuilder: (context, index) {
              return _buildPageContent(_pages[index]);
            },
          ),
        ),
      ],
    );
  }

  /// Builds the content for a single page
  Widget _buildPageContent(QuranPage page) {
    return Container(
      margin: widget.padding,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: _buildInteractivePageContent(page),
      ),
    );
  }

  /// Builds interactive page content with save and share options
  Widget _buildInteractivePageContent(QuranPage page) {
    final List<Widget> children = [];
    
    // Build all verses with interactive features and integrated surah headers
    // Basmalah is now handled within _buildInteractiveVerses after surah names
    children.add(_buildInteractiveVerses(page.verses));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  /// Builds verses with interaction capabilities (save, share)
  Widget _buildInteractiveVerses(List<Verse> verses) {
    if (verses.isEmpty) return const SizedBox.shrink();
    
    List<Widget> children = [];
    int? currentSurahNumber;
    
    // Create a continuous flow of verses using RichText for each surah section
    List<Verse> currentSurahVerses = [];
    
    for (int i = 0; i < verses.length; i++) {
      final verse = verses[i];
      
      // Check if this is the start of a new surah
      if (verse.surahNumber != currentSurahNumber) {
        // If we have accumulated verses from previous surah, add them as continuous text
        if (currentSurahVerses.isNotEmpty) {
          children.add(_buildContinuousVersesText(currentSurahVerses));
        }
        
        // Add spacing before new surah (except for the very first)
        if (currentSurahNumber != null) {
          children.add(const SizedBox(height: 24));
        }
        
        // Add surah header only if this is truly the first verse of a new surah
        // Check if this verse is actually verse number 1 of the surah
        if (verse.verseNumber == 1 && verse.surahName != null) {
          children.add(_buildSurahNameBox(verse.surahName!));
          children.add(const SizedBox(height: 16));
          
          // Add basmalah after surah name (except for Surah At-Tawbah - number 9)
          if (verse.surahNumber != 9) {
            children.add(_buildBasmalah());
            children.add(const SizedBox(height: 16));
          }
        }
        
        currentSurahNumber = verse.surahNumber;
        currentSurahVerses = [verse];
      } else {
        // Add verse to current surah group
        currentSurahVerses.add(verse);
      }
    }
    
    // Add any remaining verses as continuous text
    if (currentSurahVerses.isNotEmpty) {
      children.add(_buildContinuousVersesText(currentSurahVerses));
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  /// Builds continuous text for verses using RichText to make them flow naturally
  Widget _buildContinuousVersesText(List<Verse> verses) {
    List<InlineSpan> textSpans = [];
    
    for (int i = 0; i < verses.length; i++) {
      final verse = verses[i];
      final isVerseSaved = SavedVersesService.isVerseSaved(verse.surahNumber, verse.verseNumber);
      
      // Add verse text
      textSpans.add(
        TextSpan(
          text: verse.text,
          style: TextStyle(
            fontSize: widget.fontSize,
            fontFamily: GoogleFonts.amiri().fontFamily ?? 'Amiri',
            color: widget.textColor,
            height: 1.8,
            backgroundColor: isVerseSaved ? Colors.amber.withValues(alpha: 0.15) : null,
          ),
          recognizer: LongPressGestureRecognizer()
            ..onLongPress = () => _showVerseMenu(verse),
        ),
      );
      
      // Add verse number
      textSpans.add(
        TextSpan(
          text: ' ﴿${verse.verseNumber}﴾ ',
          style: TextStyle(
            fontSize: widget.fontSize * 0.75,
            fontFamily: GoogleFonts.amiri().fontFamily ?? 'Amiri',
            color: const Color(0xFF8B4513),
            fontWeight: FontWeight.w600,
            height: 1.8,
          ),
        ),
      );
    }
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        text: TextSpan(children: textSpans),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  /// Builds a decorative box with surah name
  Widget _buildSurahNameBox(String surahName) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2F4F4F).withValues(alpha: 0.1),
            const Color(0xFF2F4F4F).withValues(alpha: 0.05),
            const Color(0xFF2F4F4F).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2F4F4F).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        'سورة $surahName',
        style: TextStyle(
          fontSize: widget.fontSize * 1.2,
          fontFamily: GoogleFonts.amiri().fontFamily ?? 'Amiri',
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2F4F4F),
          letterSpacing: 1.0,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
    );
  }

  /// Builds the basmalah (بسم الله الرحمن الرحيم)
  Widget _buildBasmalah() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFDAA520).withValues(alpha: 0.1),
            const Color(0xFFDAA520).withValues(alpha: 0.05),
            const Color(0xFFDAA520).withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFDAA520).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
        style: TextStyle(
          fontSize: widget.fontSize * 1.1,
          fontFamily: GoogleFonts.amiri().fontFamily ?? 'Amiri',
          fontWeight: FontWeight.w600,
          color: const Color(0xFF8B4513),
          letterSpacing: 2.0,
          height: 1.8,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
    );
  }



  /// Shows verse menu with save and share options
  void _showVerseMenu(Verse verse) {
    final isVerseSaved = SavedVersesService.isVerseSaved(verse.surahNumber, verse.verseNumber);
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Verse preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    verse.text,
                    style: TextStyle(
                      fontSize: widget.fontSize * 0.9,
                      fontFamily: GoogleFonts.amiri().fontFamily ?? 'Amiri',
                      color: widget.textColor,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 8),
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
            ),
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Save/Unsave button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (isVerseSaved) {
                        await SavedVersesService.removeSavedVerse(
                          verse.surahNumber,
                          verse.verseNumber,
                        );
                        if (mounted) {
                          setState(() {});
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم حذف الآية من المحفوظات')),
                            );
                          }
                        }
                      } else {
                        await SavedVersesService.saveVerseFromModel(verse, _currentPageIndex + 1);
                        if (mounted) {
                          setState(() {});
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم حفظ الآية')),
                            );
                          }
                        }
                      }
                    },
                    icon: Icon(isVerseSaved ? Icons.bookmark_remove : Icons.bookmark_add),
                    label: Text(isVerseSaved ? 'إلغاء الحفظ' : 'حفظ'),
                  ),
                ),
                const SizedBox(width: 8),
                
                // Share button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await SavedVersesService.shareVerseFromModel(verse);
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('مشاركة'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the bottom navigation bar with page controls
  Widget _buildBottomNavigationBar() {
    if (_showIndex || _isLoading || _pages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2F4F4F),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Next page button (left arrow for Arabic reading direction)
            IconButton(
              onPressed: _currentPageIndex < _pages.length - 1 ? _nextPage : null,
              icon: const Icon(Icons.chevron_left, color: Colors.white),
              iconSize: 32,
            ),
            
            // Page indicator
            Expanded(
              child: GestureDetector(
                onTap: () => _showPageSelector(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'صفحة ${_currentPageIndex + 1} من 602', // Fixed to show 602 pages
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: (_currentPageIndex + 1) / 602, // Fixed to 602 pages
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Previous page button (right arrow for Arabic reading direction)
            IconButton(
              onPressed: _currentPageIndex > 0 ? _previousPage : null,
              icon: const Icon(Icons.chevron_right, color: Colors.white),
              iconSize: 32,
            ),
          ],
        ),
      ),
    );
  }

  /// Shows a page selector dialog
  void _showPageSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('انتقال إلى صفحة'), // "Go to page"
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 602, // Fixed to 602 pages
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                _goToPage(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: index == _currentPageIndex 
                      ? const Color(0xFF2F4F4F) 
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: index == _currentPageIndex 
                          ? Colors.white 
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'), // "Cancel"
          ),
        ],
      ),
    );
  }



  @override
  void dispose() {
    // Save current page position before disposing
    _saveCurrentPagePosition(_currentPageIndex);
    _pageController.dispose();
    super.dispose();
  }
}