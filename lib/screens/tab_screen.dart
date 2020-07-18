import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

import './notes_screen.dart';
import './to_do_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'pages': ToDoScreen(),
      'title': 'ToDo List',
    },
    {
      'pages': NotesScreen(),
      'title': 'Notes',
    }
  ];

  var _selectedPage = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPage]['title']),
      ),
      body: _pages[_selectedPage]['pages'],
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.work, title: "Todo"),
          TabData(iconData: Icons.note, title: "Notes"),
        ],
        onTabChangedListener: (position) {
          _selectPage(position);
        },
      ),
    );
  }
}
