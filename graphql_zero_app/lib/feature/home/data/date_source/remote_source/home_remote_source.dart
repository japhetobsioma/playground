import 'package:graphql_zero_app/common/model/model.dart';

abstract class HomeRemoteSource {
  Future<List<PostModel>> getPosts();
}
