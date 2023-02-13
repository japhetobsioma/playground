import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/feature/home/view/widget/home_side_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                HomeSideMenu(),
                Expanded(
                  child: ColoredBox(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 84,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
