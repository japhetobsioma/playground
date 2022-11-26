import 'package:graphql_zero_app/feature/home/data/repository/home_repository_impl.dart';
import 'package:graphql_zero_app/feature/home/dependency_injection/dependency_injection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeRepositoryDI = Provider((ref) {
  final remoteSource = ref.read(homeRemoteSourceDI);
  return HomeRepositoryImpl(remoteSource);
});
