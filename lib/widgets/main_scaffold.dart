import 'package:flutter/material.dart';
import 'package:recetas/pages/pag_area.dart';
import 'package:recetas/pages/pag_categoria.dart';
import 'package:recetas/pages/pag_favoritos.dart';
import 'package:recetas/pages/pag_inicio.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    PagInicio(),
    Pag_categoria(),
    Pag_area(),
    Pag_favoritos(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
        physics: const BouncingScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 252, 165, 15),
        unselectedItemColor: const Color.fromARGB(255, 206, 106, 20),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Categorías"),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "Área"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritas"),
        ],
      ),
    );
  }
}