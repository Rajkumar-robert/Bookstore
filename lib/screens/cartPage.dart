import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bookService/bookClass.dart'; 
import '../components/cartProvider.dart';
import 'bookDetail.dart'; 

//widget to display books insed the cart
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Book> cartItems = Provider.of<CartProvider>(context).getCartItems();

    return Scaffold(
      body:cartItems.length==0?Container(
        margin: EdgeInsets.all(30),
        child: Text("No Books in Cart",
        style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700),),
      ) :ListView.builder(
        padding: EdgeInsets.only(top: 20.0,bottom: 5.0),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          Book book = cartItems[index];
          return ListTile(
            leading: book.imageURL != null? Container(
                            width: 50,
                            height: 80,
                            child: Image.network(
                              book.imageURL,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(),
            title: Text(book.title),
            trailing: ElevatedButton(
              onPressed: () {
                // Remove the book from the cart when the button is clicked.
                Provider.of<CartProvider>(context, listen: false)
                    .removeFromCart(book);
              },
              child: Text('Remove'),
            ),
            onTap: () {
              // Navigate to the BookDetailPage when the ListTile is tapped.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
