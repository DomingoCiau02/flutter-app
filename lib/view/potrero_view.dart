// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:app/icons/my_flutter_app_icons.dart';
import 'package:app/view/view.dart';

class PotreroView extends StatefulWidget {
  const PotreroView({super.key});

  @override
  State<PotreroView> createState() => _PotreroViewState();
}

class _PotreroViewState extends State<PotreroView> {
  late Widget pantallaWidget = const ListPesajesView();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pantallaWidget,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.weight_kilogram, size: 50),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.barley, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.notes_medical, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.cow, size: 40),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          switch (index) {
            case 0:
              pantallaWidget = const ListPesajesView();
              break;
            case 1:
              pantallaWidget = const ListAlimentacionView();
              break;
            case 2:
              pantallaWidget = const ListExpdteMedView();
              break;
            case 3:
              pantallaWidget = const ListAnimalesView();
              break;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
