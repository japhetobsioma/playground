import 'package:graphql_zero_app/common/model/post_entity.dart';
import 'package:graphql_zero_app/feature/post/data/data_source/remote_source/remote_source.dart';
import 'package:graphql_zero_app/feature/post/domain/repository/repository.dart';

class PostRepositoryImpl implements PostRepository {
  const PostRepositoryImpl(
    PostRemoteSource remoteSource,
  ) : _remoteSource = remoteSource;

  final PostRemoteSource _remoteSource;

  @override
  Future<Post> getPostById(String id) async => _remoteSource.getPostById(id);
}
