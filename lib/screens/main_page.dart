import 'package:bookstore/screens/homePage.dart';
import 'package:bookstore/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'booklistPage.dart';
import 'cartPage.dart';


//main page: displayed when user is logged in.
//contains all screens
class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  bool isSearchOpen = false;
  List page = [
    homePage(),
    BookListPage(),//searchpage
    CartPage(),
    ProfilePage(),
    
  ];

  List<String> title = [
    'BookStore',
    'BookStore',
    'Library',
    'Profile',
    
  ];
   void _toggleSearch() {
    setState(() {
      isSearchOpen = !isSearchOpen;
    });
  }

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[currentIndex]),
        backgroundColor: Colors.black,
        
      ),
      body:page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        items: const<BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "search",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "cart",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: "profile",
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
