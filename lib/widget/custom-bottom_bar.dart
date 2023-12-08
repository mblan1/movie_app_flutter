import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<StatefulWidget> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(255, 255, 255, 0.2),
          ),
        ),
        color: Color.fromRGBO(117, 209, 221, 1),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(107, 102, 166, .65),
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ".",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken),
            label: "Tìm kiếm",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: "Thêm",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: "Cá nhân",
          ),
        ],
      ),
    );
  }
}
