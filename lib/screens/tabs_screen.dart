import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favourites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  final Function toggleFavourites;
  final Function isFav;

  TabScreen({
    this.favouriteMeals,
    this.toggleFavourites,
    this.isFav,
  });
  @override
  State<StatefulWidget> createState() {
    return TabScreenState();
  }
}

class TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages = [];

  @override
  void initState() {
    _pages = [
      {'page': CategoryScreen(), 'title': 'Categories'},
      {
        'page': FavouritesScreen(
          favouriteMeals: widget.favouriteMeals,
          isFav: widget.isFav,
          toggleFavourites: widget.toggleFavourites,
        ),
        'title': 'Your Favourites'
      }
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favourites'),
          )
        ],
      ),
    );
  }
}
