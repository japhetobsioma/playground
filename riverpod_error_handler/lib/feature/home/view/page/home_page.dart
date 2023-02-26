import 'package:flutter/material.dart';
import 'package:riverpod_error_handler/common/helper/error_handler.dart';
import 'package:riverpod_error_handler/feature/home/provider/home_provider.dart';
import 'package:riverpod_error_handler/feature/home/view/widget/home_post_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorHandler(
      provider: homeNotifierProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const HomePostList(),
      ),
    );
  }
}
