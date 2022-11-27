import 'package:flutter/material.dart';
import 'package:graphql_zero_app/feature/home/presentation/widget/widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScaffold(postList: HomePostList());
  }
}
