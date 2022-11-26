import 'package:graphql_zero_app/feature/home/dependency_injection/dependency_injection.dart';
import 'package:graphql_zero_app/feature/home/domain/use_case/use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getPostsUseCaseDI = Provider((ref) {
  final repository = ref.read(homeRepositoryDI);
  return GetPostsUseCase(repository);
});
