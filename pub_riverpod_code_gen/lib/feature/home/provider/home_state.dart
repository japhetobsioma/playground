import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_riverpod_code_gen/common/pub_api/model/package.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required String search,
    required List<Package> packages,
  }) = _HomeState;
}
