import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../bookService/bookClass.dart';
import '../screens/bookDetail.dart';

//fetching books based on genre

class genreFetch extends StatefulWidget {
  const genreFetch({Key? key}) : super(key: key);

  @override
  State<genreFetch> createState() => _genreFetch();
}

class _genreFetch extends State<genreFetch> {
  List<String> genres = [
    'Fiction',
    'Non-Fiction',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Fantasy',
    'Horror',
    'Thriller',
    'Biography',
    'History',
    'Self-Help',
    'Cooking',
    'Science',
    'Poetry',
    'Travel',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: ListTile(
              title: Text(
                genres[index],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => genreList(
                      genre: genres[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class genreList extends StatefulWidget {
  final String genre;

  const genreList({required this.genre});

  @override
  State<genreList> createState() => _genreListState();
}

class _genreListState extends State<genreList> {
  List<Book> books = [];
  bool isLoading = true;

// function to fetch books based on genre search term using Google books API
  Future<void> fetchGenre(String genre) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$genre+subject&maxResults=40'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> items = data['items'];
      List<Book> fetchedBooks =
          items.map<Book>((item) => Book.fromJSON(item['volumeInfo'])).toList();

      if (mounted) {
        setState(() {
          books = fetchedBooks;
          isLoading = false;
        });
      }
    } else {
      print('Failed to load books');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGenre(widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
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
    );
  }
}
