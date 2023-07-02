import 'package:bookstore/components/carouselSlider.dart';
import 'package:flutter/material.dart';
import '../components/genreFetch.dart';
import '../components/bookGrid.dart';

//home page
class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Featured Books',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                )),
            Container(child: carouselCard()),
            Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                child: Text(
                  'Suggested Books',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                )),
            Container(child: bookGrid()),
            Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                child: Text(
                  'Explore Genres',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                )),
            Container(height: 600, child: genreFetch()),
          ],
        ),
      ),
    );
  }
}
