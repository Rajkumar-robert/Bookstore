import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../bookService/bookClass.dart';
import 'bookDetail.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> books = [];
  TextEditingController _searchController = TextEditingController();


// function to fetch books from search term using Google books API
  Future<void> fetchBooks(String searchTerm) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$searchTerm&maxResults=40'));
        print(searchTerm+"in");
    if (response.statusCode == 200) {
      // Parse the JSON response and extract book information
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> fetchedBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();
      if (mounted) {
        setState(() {
          books = fetchedBooks;
        });
      }
    } else {
      print('Failed to load books');
    }
    print(books);
  }

  @override
  void initState() {
    super.initState();
  }

//widget to display search result in list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 90, 
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                autofocus: true,
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search for books',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      String searchTerm = _searchController.text;
                      
                      if (searchTerm.isNotEmpty) {
                        fetchBooks(searchTerm);
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  Book book = books[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailPage(book: book),
                        ),
                      );
                    },
                    leading: book.imageURL != null
                        ? Container(
                            width: 50,
                            height: 80,
                            child: Image.network(
                              book.imageURL,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(),
                    title: Text(book.title),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
