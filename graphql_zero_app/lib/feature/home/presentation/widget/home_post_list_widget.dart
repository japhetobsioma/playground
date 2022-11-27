import 'package:flutter/material.dart';
import 'package:graphql_zero_app/feature/home/presentation/provider/provider.dart';
import 'package:graphql_zero_app/feature/post/presentation/page/page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePostList extends ConsumerWidget {
  const HomePostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);

    return state.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.posts.length,
          itemBuilder: (context, index) {
            final post = data.posts[index];

            return ListTile(
              title: Text('${post.user.name} ${post.user.username}'),
              subtitle: Text(post.title),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (context) => const PostPage(),
                  ),
                );
              },
            );
          },
        );
      },
      error: (_, __) => const Center(child: Text('Error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
