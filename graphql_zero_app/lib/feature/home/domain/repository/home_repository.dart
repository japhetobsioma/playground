import 'package:graphql_zero_app/feature/home/domain/entity/entity.dart';

abstract class HomeRepository {
  Future<List<Post>> getPosts();
}
