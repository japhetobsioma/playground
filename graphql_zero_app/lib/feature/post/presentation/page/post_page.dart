import 'package:flutter/material.dart';
import 'package:graphql_zero_app/feature/post/presentation/provider/post_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: const PostDetails(),
    );
  }
}

class PostDetails extends ConsumerWidget {
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postProvider);

    return state.when(
      data: (data) {
        final post = data.post;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Card(
                child: ListTile(
                  isThreeLine: true,
                  leading: const Icon(Icons.article),
                  title: Text(post.title),
                  subtitle: Text(post.body),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: data.post.comments.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final comment = data.post.comments[index];

                  return ListTile(
                    isThreeLine: true,
                    leading: const Icon(Icons.comment),
                    title: Text(comment.body),
                    subtitle: Text(comment.name),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => const Center(child: Text('Error')),
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
