import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../bookService/bookClass.dart';
import '../components/genreFetch.dart';
import 'bookGrid.dart';
import '../screens/bookDetail.dart';



class carouselCard extends StatefulWidget {
  @override
  _carouselCardState createState() => _carouselCardState();
}

class _carouselCardState extends State<carouselCard> {
  
// function to fetch newly pusblished books using Google books API
  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=book&orderBy=newest&maxResults=10'));
    if (response.statusCode == 200) {
      // Parse the JSON response and extract book information
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> fetchedBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();
      return fetchedBooks;
    } else {
      print('Failed to load books');
      return [];
    }
  }

//displaying fetched books in carouselslider view
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load books'));
        } else {
          List<Book> fbooks = snapshot.data!;
          return Material(
            elevation: 5,
            child: CarouselSlider.builder(
              itemCount: fbooks.length,
              itemBuilder: (context, index, realIndex) {
                final Book book = fbooks[index];
                return buildSlider(book, index);
              },
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildSlider(Book book, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(book: book),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        decoration: BoxDecoration(
          color: Color.fromRGBO(134, 93, 255, 1),
        ),
        child: Row(
          children: [
            Container(
              height: 400,
              child: book.imageURL != null
                  ? Image.network(
                      book.imageURL,
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'by ${book.authors.join(",")}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
