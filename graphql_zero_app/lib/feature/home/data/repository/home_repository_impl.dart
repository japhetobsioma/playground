import 'package:graphql_zero_app/feature/home/data/date_source/remote_source/remote_source.dart';
import 'package:graphql_zero_app/feature/home/domain/entity/post_entity.dart';
import 'package:graphql_zero_app/feature/home/domain/repository/repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(
    HomeRemoteSource remoteSource,
  ) : _remoteSource = remoteSource;

  final HomeRemoteSource _remoteSource;

  @override
  Future<List<Post>> getPosts() async => _remoteSource.getPosts();
}
