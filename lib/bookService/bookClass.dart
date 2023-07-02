
// Book class for returning data from json file
class Book {
  final String title;
  final String imageURL;
  final String description;
  final List<String> authors; 
  Book({
    required this.title,
    required this.imageURL,
    required this.description,
    required this.authors,
  });

factory Book.fromJSON(Map<String, dynamic> json) {
  String title = json['title'] ?? 'No Title';

  String imageURL;
  if (json['imageLinks'] != null && json['imageLinks']['thumbnail'] != null) {
    imageURL = json['imageLinks']['thumbnail'];
  } else {
    // Replace this URL with your default placeholder image URL
    imageURL = 'https://i.pinimg.com/originals/55/5c/a2/555ca28baea4ce9064d87e6a3cf301d0.png';
  }

  String description = json['description'] ?? 'No Description';

  List<String> authors;
  if (json['authors'] != null) {
    authors = List<String>.from(json['authors']);
  } else {
    authors = ['Unknown Author'];
  }

  return Book(
    title: title,
    imageURL: imageURL,
    description: description,
    authors: authors,
  );
}


}