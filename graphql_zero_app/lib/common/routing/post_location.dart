import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:graphql_zero_app/common/routing/routing.dart';
import 'package:graphql_zero_app/feature/post/presentation/page/post_page.dart';
import 'package:graphql_zero_app/feature/post/presentation/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostLocation extends BeamLocation<BeamState> {
  static const route = '${HomeLocation.route}/post';

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final id = state.queryParameters['id'] ?? '';

    return [
      ...HomeLocation().buildPages(context, state),
      BeamPage(
        key: const ValueKey('post_location'),
        title: 'Post',
        name: 'Post',
        child: ProviderScope(
          overrides: [postProvider.overrideWith(() => PostNotifier(id))],
          child: const PostPage(),
        ),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [route];
}
