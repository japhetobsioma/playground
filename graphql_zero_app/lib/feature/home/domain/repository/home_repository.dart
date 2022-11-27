import 'package:graphql_zero_app/common/model/model.dart';

abstract class HomeRepository {
  Future<List<Post>> getPosts();
}
