import 'package:graphql_zero_app/feature/home/data/model/post_model.dart';

abstract class HomeRemoteSource {
  Future<List<PostModel>> getPosts();
}
