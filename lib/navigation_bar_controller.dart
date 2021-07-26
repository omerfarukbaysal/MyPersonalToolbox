import 'package:flutter/material.dart';
import 'calculator.dart';
import 'hescode.dart';
import 'todolist.dart';

class BottomNavigationBarController extends StatefulWidget {
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final List<Widget> pages = [
    Calculator(
      key: PageStorageKey('Page1'),
    ),
    ToDoList(
      key: PageStorageKey('Page2'),
    ),
    HesCode(
      key: PageStorageKey('Page3'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'First Page'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Second Page'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Hes Code'),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
