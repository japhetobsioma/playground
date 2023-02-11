import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_riverpod_code_gen/common/pub_api/model/package_details.dart';

part 'package.freezed.dart';
part 'package.g.dart';

@freezed
class Package with _$Package {
  factory Package({
    required String name,
    required PackageDetails latest,
  }) = _Package;

  factory Package.fromJson(Map<String, Object?> json) =>
      _$PackageFromJson(json);
}
