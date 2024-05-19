// detail_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> cardData;

  const DetailScreen({Key? key, required this.cardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cardData['name']),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(cardData['image']),
            SizedBox(height: 16),
            Text(
              cardData['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              cardData['description'],
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
           Row(
  children: List.generate(5, (index) {
    return Icon(
      index < cardData['rating'].round()
          ? Icons.star
          : Icons.star_border,
      color: Colors.yellow, // Set color to yellow
    );
  }),
),
            SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () async {
            //     final url = cardData['videoLink'];
            //     if (await canLaunch(url)) {
            //       await launch(url);
            //     } else {
            //       throw 'Could not launch $url';
            //     }
            //   },
            //   child: Text('Play Video'),
            // ),
          ],
        ),
      ),
    );
  }
}
