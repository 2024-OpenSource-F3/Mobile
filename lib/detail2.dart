import 'package:flutter/material.dart';

class DetailScreen2 extends StatelessWidget {
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
              buildTitle('앞다리살'),
              buildImage('assets/앞다리살.jpg'), // 삼겹살 이미지 경로
              buildDescription(
                  '지방이 적고 단단한 편이라 부드러운 식감을 얻기 위해서는 적절한 조리법이 필요합니다.지방이 적지만 풍미가 좋아 다양한 요리에 활용됩니다.'),
              buildSubtitle('앞다리살의 특징'),
              buildText(
                  '1. 지방이 적고 단단한 편이라 부드러운 식감을 얻기 위해서는 적절한 조리법이 필요합니다\n2. 지방이 적지만 풍미가 좋아 다양한 요리에 활용됩니다.'),
              buildSubtitle('앞다리살 조리 방법'),
              buildCookingMethod('assets/보쌈.jpg', '1. 수육',
                  '돼지 앞다리살을 큰 덩어리로 준비합니다. 물에 소금, 마늘, 생강, 대파를 넣고 끓입니다. 끓는 물에 돼지 앞다리살을 넣고 약 1~2시간 동안 중간 불에서 삶아줍니다. 익힌 고기를 꺼내어 식힌 후, 먹기 좋은 크기로 썰어줍니다. 쌈장이나 새우젓과 함께 상추, 배추 등에 싸서 먹습니다.'),
              buildCookingMethod('assets/돼지불고기.jpg', '2. 돼지불고기',
                  '돼지 앞다리살을 얇게 썰어줍니다. 간장, 설탕, 다진 마늘, 참기름, 후추 등을 섞어 양념장을 만듭니다. 양념장에 고기를 재워둡니다(약 30분). 팬에 기름을 두르고 양념된 고기를 볶아줍니다. 양파, 버섯, 당근 등의 채소를 추가로 넣고 함께 볶아줍니다.'),
              buildCookingMethod('assets/돼지갈비찜.jpg', '3. 돼지갈비찜',
                  '돼지 앞다리살을 적당한 크기로 썰어줍니다. 간장, 설탕, 다진 마늘, 다진 생강, 참기름, 후추, 물 등을 섞어 양념장을 만듭니다. 양념장에 고기를 재워둡니다(약 1시간). 냄비에 양념된 고기와 물을 넣고 끓입니다. 무, 당근, 감자 등을 넣고 고기가 부드러워질 때까지 중약불에서 끓입니다. 마지막으로 대파와 청양고추를 넣어 마무리합니다.'),
              buildCookingMethod('assets/김치찜.jpg', '4. 김치찜',
                  '돼지 앞다리살을 적당한 크기로 썰어줍니다. 김치를 적당한 크기로 썰어냅니다. 냄비에 김치와 돼지 앞다리살을 층층이 쌓습니다. 물을 붓고 김치가 익을 때까지 중약불에서 끓입니다(약 1시간). 필요시 간장이나 소금으로 간을 맞춥니다.'),
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
