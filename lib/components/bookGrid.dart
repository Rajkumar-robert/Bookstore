import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../bookService/bookClass.dart';
import '../screens/bookDetail.dart';

class bookGrid extends StatefulWidget {
  const bookGrid({Key? key});

  @override
  State<bookGrid> createState() => _bookGridState();
}

class _bookGridState extends State<bookGrid> {

  
// function to fetch books using Google books API
  Future<List<Book>> suggestBooks() async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=book&orderBy=relevance&maxResults=8'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> suggBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();
      return suggBooks; // Return the list of suggested books here
    } else {
      print('Failed to load books');
      return []; // Return an empty list in case of an error
    }
  }


  //widget to display books in gridview

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: suggestBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load books'));
        } else {
          List<Book> sbooks = snapshot.data!;
          return  Container(
            height: 1000,
            child: MediaQuery.removePadding(
          
                context: context,
              removeTop: true, 
              child: Padding(
                padding: EdgeInsets.all(10.0), 
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2 / 2.8,
                  ),
                  itemCount: sbooks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Book book = sbooks[index];
                    return buildGrid(book, index);
                  },
                ),
              
            ),
            )
          );
        }
      },
    );
  }

  Widget buildGrid(Book book, int index) {
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
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           Container(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: book.imageURL != null
                    ? Image.network(
                        book.imageURL,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0), 
              child: Text(
                book.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
