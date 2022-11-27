import 'package:graphql_zero_app/common/model/model.dart';

abstract class PostRepository {
  Future<Post> getPostById(String id);
}
