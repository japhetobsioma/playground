import 'package:flutter/material.dart';
import 'package:graphql_zero_app/feature/post/presentation/widget/widget.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostScaffold(postDetails: PostDetails());
  }
}
