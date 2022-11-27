import 'package:flutter/material.dart';
import 'package:graphql_zero_app/feature/post/presentation/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostDetails extends ConsumerWidget {
  const PostDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postProvider);

    return state.when(
      data: _DataWidget.new,
      error: _ErrorWidget.new,
      loading: _LoadingWidget.new,
    );
  }
}

class _DataWidget extends StatelessWidget {
  const _DataWidget(this.data);

  final PostState data;

  @override
  Widget build(BuildContext context) {
    final post = data.post;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.all(50),
          child: Padding(
            padding: const EdgeInsets.all(10),
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
            separatorBuilder: (_, __) => const Divider(height: 1),
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
