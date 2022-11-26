import 'package:graphql_zero_app/feature/home/domain/entity/entity.dart';
import 'package:graphql_zero_app/feature/home/domain/repository/home_repository.dart';

class GetPostsUseCase {
  const GetPostsUseCase(HomeRepository repository) : _repository = repository;

  final HomeRepository _repository;

  Future<List<Post>> call() async => _repository.getPosts();
}
