import 'package:graphql_zero_app/common/model/model.dart';
import 'package:graphql_zero_app/feature/post/domain/repository/post_repository.dart';

class GetPostByIdUseCase {
  const GetPostByIdUseCase(
    PostRepository repository,
  ) : _repository = repository;

  final PostRepository _repository;

  Future<Post> call(String id) async => _repository.getPostById(id);
}
