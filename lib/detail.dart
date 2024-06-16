import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('꼬기꼬기', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle('삼겹살'),
              buildImage('assets/삼겹살.jpg'), // 삼겹살 이미지 경로
              buildDescription(
                  '삼겹살은 돼지고기 부위에서 얻어지는 고기로, 한국에서 가장 인기 있는 고기 중 하나입니다. 삼겹살은 적당한 기름기와 부드러운 식감으로 구워 먹기에 최적입니다.'),
              buildSubtitle('삼겹살의 특징'),
              buildText(
                  '1. 삼겹살은 적당한 기름기와 부드러운 식감을 가지고 있어 구워 먹기에 좋습니다.\n2. 고소한 맛과 풍부한 육즙이 특징입니다.\n3. 다양한 요리에 활용될 수 있습니다.'),
              buildSubtitle('삼겹살 조리 방법'),
              buildCookingMethod('assets/숯불구이.jpg', '1. 숯불에 굽기',
                  '적당한 크기로 자른 삼겹살을 숯불에 구워 먹는 방법입니다. 소금과 후추로 간을 하고, 숯불에 골고루 구워줍니다.'),
              buildCookingMethod('assets/삼겹살 구이.jpg', '2. 프라이팬에 굽기',
                  '삼겹살을 프라이팬에 구워 먹는 방법입니다. 소금과 후추로 간을 하고, 프라이팬에 노릇노릇하게 구워줍니다.'),
              buildCookingMethod('assets/보쌈.jpg', '3. 보쌈으로 먹기',
                  '삼겹살을 물에 삶아 보쌈으로 먹는 방법입니다. 대파, 마늘, 생강 등을 넣어 삶아줍니다.'),
              buildCookingMethod('assets/제육.jpg', '4. 매운 양념에 재워 먹기',
                  '삼겹살을 매운 양념에 재워서 구워 먹는 방법입니다. 고추장, 간장, 설탕 등을 섞어 양념장을 만들고, 삼겹살에 재워줍니다.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFFFEBEB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildImage(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Image.asset(imagePath),
    );
  }

  Widget buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        description,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        subtitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildCookingMethod(String imagePath, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        buildImage(imagePath),
        buildDescription(description),
      ],
    );
  }
}
