import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_error_handler/common/graphql_zero_api/model/post.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required List<Post> posts,
  }) = _HomeState;
}
