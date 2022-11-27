import 'package:flutter/material.dart';

class PostScaffold extends StatelessWidget {
  const PostScaffold({super.key, required this.postDetails});

  final Widget postDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post'), centerTitle: false),
      body: postDetails,
    );
  }
}
