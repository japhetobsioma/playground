import 'package:flutter/material.dart';
import 'package:graphql_zero_app/feature/home/presentation/provider/provider.dart';
import 'package:graphql_zero_app/feature/post/presentation/page/page.dart';
import 'package:graphql_zero_app/feature/post/presentation/provider/post_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePostList extends ConsumerWidget {
  const HomePostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);

    return state.when(
      data: _DataWidget.new,
      error: _ErrorWidget.new,
      loading: _LoadingWidget.new,
    );
  }
}

class _DataWidget extends StatelessWidget {
  const _DataWidget(this.data);

  final HomeState data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.posts.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final post = data.posts[index];
        final user = post.user;

        return ListTile(
          leading: const Icon(Icons.article),
          title: Text(post.title),
          subtitle: Text('By ${user.name} (@${user.username})'),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) {
                  return ProviderScope(
                    overrides: [
                      postProvider.overrideWith(() => PostNotifier(post.id))
                    ],
                    child: const PostPage(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget(this.error, this.stackTrace);

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Error'));
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
