import 'package:graphql_zero_app/feature/post/dependency_injection/dependency_injection.dart';
import 'package:graphql_zero_app/feature/post/domain/use_case/use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getPostByIdUseCaseDI = Provider.autoDispose(
  (ref) {
    final repository = ref.watch(postRepositoryDI);
    return GetPostByIdUseCase(repository);
  },
  dependencies: [postRepositoryDI],
);
