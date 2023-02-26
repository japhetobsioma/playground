import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_error_handler/feature/home/provider/home_provider.dart';

class HomePostList extends ConsumerWidget {
  const HomePostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(homeNotifierProvider);

    return posts.maybeWhen(
      data: (_) => const _PostList(),
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _PostList extends ConsumerWidget {
  const _PostList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeNotifierProvider).requireValue;

    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        final post = state.posts[index];

        return Card(
          child: ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
          ),
        );
      },
    );
  }
}
