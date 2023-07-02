import 'package:flutter/foundation.dart';
import '../bookService/bookClass.dart';
import 'cartClass.dart';

//implemnting cart functionality using foundation
class CartProvider with ChangeNotifier {
  Cart _cart = Cart();

  void addToCart(Book book) {
    _cart.addToCart(book);
    notifyListeners();
  }

  void removeFromCart(Book book) {
    _cart.removeFromCart(book);
    notifyListeners();
  }

  List<Book> getCartItems() {
    return _cart.getCartItems();
  }

  int getItemCount() {
    return _cart.getItemCount();
  }


}
