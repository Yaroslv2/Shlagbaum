import 'package:flutter/material.dart';
import 'package:shlagbaum/presentation/pages.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  static final List<Widget> _pages = [
    HomePage(),
    AccountPage(),
  ];

  void _onTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const [],
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
