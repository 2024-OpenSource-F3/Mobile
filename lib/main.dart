import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'rating.dart';
import 'detail.dart';
import 'detail2.dart';
import 'detail4.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MeatPriceScreen(),
      routes: {
        '/rating': (context) => RatingScreen(),
        '/detail': (context) => DetailScreen(),
       '/detail2': (context) => DetailScreen2(),
        // '/detail3': (context) => DetailScreen3(),
        '/detail4': (context) => DetailScreen4(),
      /*  '/detail5': (context) => DetailScreen5(),
        '/detail6': (context) => DetailScreen6(),*/
      },
    );
  }
}

class MeatPriceScreen extends StatefulWidget {
  @override
  _MeatPriceScreenState createState() => _MeatPriceScreenState();
}

class _MeatPriceScreenState extends State<MeatPriceScreen> {
  Map<String, String> prices = {
    '삼겹살': 'Loading...',
    '목심': 'Loading...',
    '갈비': 'Loading...',
    '앞다리': 'Loading...',
  };

  String date = 'Loading...';

  @override
  void initState() {
    super.initState();
    print('MeatPriceScreen initState called');
    fetchPrices();
  }

  Future<void> fetchPrices() async {
    print('fetchPrices called');
    try {
      final response = await http.get(Uri.parse('http://192.168.30.146:8080/api/crawl/price'));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes)); // UTF-8 디코딩
        setState(() {
          date = data['날짜'] ?? 'Unknown date';
          prices = {
            '삼겹살': data['samgyeopsal'] ?? 'Unknown',
            '목심': data['moksim'] ?? 'Unknown',
            '갈비': data['galbi'] ?? 'Unknown',
            '앞다리': data['apdari'] ?? 'Unknown',
          };
        });
        print('444444444444444444444444444444444444444444444Data loaded successfully: $prices');
      } else {
        setState(() {
          date = 'Failed to load';
          prices = {
            '삼겹살': 'Failed to load',
            '목심': 'Failed to load',
            '갈비': 'Failed to load',
            '앞다리': 'Failed to load',
          };
        });
        print('444444444444444444444444444444444444Failed to load prices with status: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      setState(() {
        date = 'Error';
        prices = {
          '삼겹살': 'Error',
          '목심': 'Error',
          '갈비': 'Error',
          '앞다리': 'Error',
        };
      });
      print('Error: $e');
      print('Stacktrace: $stacktrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('MeatPriceScreen build called');
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '꼬기꼬기',
              style: TextStyle(color: Colors.black),
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/캐릭터.jpg', // 이미지 경로
                  height: 40, // 원하는 높이로 설정
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '100g당 부위 가격',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '기준 날짜: $date',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 3.0, // 가로 간격 설정
                mainAxisSpacing: 3.0, // 세로 간격 설정
                childAspectRatio: 2 / 1, // 가로:세로 비율 설정 (2:1 비율)
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PriceCard('삼겹살', prices['삼겹살']!),
                  PriceCard('목심', prices['목심']!),
                  PriceCard('갈비', prices['갈비']!),
                  PriceCard('앞다리', prices['앞다리']!),
                ],
              ),
              SizedBox(height: 50),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  InfoCard(
                    icon: Icons.location_on,
                    description: '근처 정육점 가격확인',
                    imagePath: 'assets/지도.jpg',
                    onTap: () {
                      _launchURL('https://map.naver.com/p/search/%EA%B7%BC%EC%B2%98%20%EC%A0%95%EC%9C%A1%EC%A0%90?searchType=place&c=14.00,0,0,0,dh');
                      print("22222222222222222222222222222222222222222222222222222222launch");
                    },
                  ),
                  InfoCard(
                    icon: Icons.camera_alt,
                    description: '고기 등급 확인',
                    imagePath: 'assets/고기등급확인.jpg',
                    onTap: () {
                      Navigator.pushNamed(context, '/rating');
                    },
                  ),
                ],
              ),
              SizedBox(height: 70),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFFFEBEB), // 하단 경계 색상
                      width: 4.0, // 경계 두께
                    ),
                  ),
                ),
                child: Text(
                  '부위별 특징, 조리 방식, 요리 정보',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MeatInfoCard(part: '삼겹살', imagePath: 'assets/삼겹살.jpg', onTap: () {
                    Navigator.pushNamed(context, '/detail');
                  }),
                  MeatInfoCard(part: '앞다리살', imagePath: 'assets/앞다리살.jpg', onTap: () {
                    Navigator.pushNamed(context, '/detail2');
                  }),
                  MeatInfoCard(part: '뒷다리살', imagePath: 'assets/뒷다리살.jpg', onTap: () {
                    Navigator.pushNamed(context, '/detail3');
                  }),
                  MeatInfoCard(part: '목살', imagePath: 'assets/목살.jpg', onTap: () {
                    Navigator.pushNamed(context, '/detail4');
                  }),
                  MeatInfoCard(part: '안심', imagePath: 'assets/안심.jpg', onTap: () {
                    Navigator.pushNamed(context, '/detail5');
                  }),
                  MeatInfoCard(part: '등심', imagePath: 'assets/등심.jpg', onTap: () {
                    Navigator.pushNamed(context, '/detail6');
                  }),
                ],
              ),
              SizedBox(height: 45),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(

                  border: Border(
                    top: BorderSide(
                      color: Colors.black, // 경계 색상
                      width: 1.5, // 경계 두께
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '충북대학교 전공프로젝트 F1 꼬기꼬기\n위의 데이터는 서울 기준입니다.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  InfoCard({
    required this.icon,
    required this.description,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath), // 배경 이미지 경로
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFFFEBEB), width: 3),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0), // 줄인 패딩
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 50, color: Colors.black), // 아이콘 색상 변경
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16, color: Colors.black), // 텍스트 색상 변경
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  final String title;
  final String price;

  PriceCard(this.title, this.price);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFEBEB),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('가격: $price', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class MeatInfoCard extends StatelessWidget {
  final String part;
  final String imagePath;
  final VoidCallback onTap;

  MeatInfoCard({required this.part, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(part, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}