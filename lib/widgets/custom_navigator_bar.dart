import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/ui_providers.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedMenu = Provider.of<UiProvider>(context);
    return BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (int value) => selectedMenu.selectedMenuOpt = value,
        currentIndex: selectedMenu.selectedMenuOpt,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration), label: 'Direcciones')
        ]);
  }
}
