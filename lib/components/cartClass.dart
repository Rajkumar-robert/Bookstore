import '../bookService/bookClass.dart';

//class to manage cart function 
class Cart {
  List<Book> items = [];

  void addToCart(Book book) {
    items.add(book);
  }

  void removeFromCart(Book book) {
    items.remove(book);
  }

  List<Book> getCartItems() {
    return List.from(items);
  }

  int getItemCount() {
    return items.length;
  }

}
