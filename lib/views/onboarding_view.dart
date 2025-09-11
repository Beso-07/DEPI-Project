import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

 
  final List<Map<String, String>> onBoardingData = [
    {
      "title": "📖 اقرأ وارتقِ",
      "text": "استمتع بقراءة القرآن الكريم والاستماع إليه بأصوات قراء مميزين.",
    },
    {
      "title": "🌙 ذكر ودعاء",
      "text": "تابع أذكارك اليومية والأدعية المأثورة بسهولة عبر تطبيق رتّل.",
    },
    {
      "title": "🕌 لا يفوتك وقت الصلاة",
      "text": "مواقيت الصلاة الدقيقة مع تنبيهات مريحة لتعينك على المواظبة.",
    },
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/bg_pattern.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: buildOnBoardingItem(
                  title: onBoardingData[currentPage]["title"]!,
                  text: onBoardingData[currentPage]["text"]!,
                ),
              ),
              SizedBox(height: 20),
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  setState(() {
                    if (currentPage < onBoardingData.length - 1) {
                      currentPage++;
                    } else {
                      print("ابدأ التطبيق ");
                    }
                  });
                },
                child: Text(
                  currentPage == onBoardingData.length - 1 ? "ابدأ" : "التالي",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }

  
  Widget buildOnBoardingItem({
    required String title,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), 
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: currentPage == index ? 25 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
