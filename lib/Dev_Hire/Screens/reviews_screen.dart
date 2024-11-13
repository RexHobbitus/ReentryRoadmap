import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  List<Map<String, dynamic>> newReviews = [
    {
      'name': 'Allen Walker',
      'date': 'Sept 13 2024',
      'rating': 4.5,
      'reviewText': 'It is a long established fact that a reader will be distracted by the readable content of a page...',
      'images': [
        'https://cfcdn.apowersoft.info/astro/picwish/_astro/banner-img-after.a6d47906.png',
        'https://cfcdn.apowersoft.info/astro/picwish/_astro/banner-img-after.a6d47906.png'
      ]
    },
    {
      'name': 'Luke Skywalker',
      'date': 'Sept 2 2024',
      'rating': 4.5,
      'reviewText': 'It is a long established fact that a reader will be distracted by the readable content of a page...',
      'images': [
        'https://cfcdn.apowersoft.info/astro/picwish/_astro/banner-img-after.a6d47906.png',
        'https://cfcdn.apowersoft.info/astro/picwish/_astro/banner-img-after.a6d47906.png'
      ]
    }
  ];

  List<Map<String, dynamic>> oldReviews = [
    {
      'name': 'Allen Walker',
      'date': 'May 12 2024',
      'rating': 4.5,
      'reviewText': 'It is a long established fact that a reader will be distracted by the readable content of a page...',
    },
    {
      'name': 'Jane Doe',
      'date': 'April 15 2024',
      'rating': 4.0,
      'reviewText': 'Great experience! The process was smooth and the support team was very helpful.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("New Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ...newReviews.map((review) => ReviewCard(review: review)).toList(),
          SizedBox(height: 20),
          Text("Old Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ...oldReviews.map((review) => ReviewCard(review: review)).toList(),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://cfcdn.apowersoft.info/astro/picwish/_astro/banner-img-after.a6d47906.png'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['name'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text("Verified User", style: TextStyle(color: Colors.blue, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  Gap(160),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle Reply to Review
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[200]),
                          child: Text("Reply to Review"),
                        ),
                        Gap(12),
                        ElevatedButton(
                          onPressed: () {
                            // Handle Dispute Review
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[200]),
                          child: Text("Dispute Review"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review['date'], style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xff11404C), size: 20),
                    Icon(Icons.star, color: Color(0xff11404C), size: 20),
                    Icon(Icons.star, color: Color(0xff11404C), size: 20),
                    Icon(Icons.star, color: Color(0xff11404C), size: 20),
                    Icon(Icons.star, color: Color(0xff11404C), size: 20),
                    Text(
                      "${review['rating']} (4.5)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  review['reviewText'],
                  style: TextStyle(color: Colors.black87),
                ),
                if (review['images'] != null) ...[
                  SizedBox(height: 10),
                  Row(
                    children: review['images']
                        .map<Widget>((image) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        image,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 180, // Fixed height, no rounded radius
                        fit: BoxFit.cover,
                      ),
                    ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
