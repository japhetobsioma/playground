import 'package:flutter/material.dart';
import 'package:pub_riverpod_code_gen/feature/home/view/widget/home_app_bar.dart';
import 'package:pub_riverpod_code_gen/feature/home/view/widget/home_package_list.dart';
import 'package:pub_riverpod_code_gen/feature/home/view/widget/home_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Column(
        children: const [
          HomeSearchBar(),
          HomePackageList(),
        ],
      ),
    );
  }
}
