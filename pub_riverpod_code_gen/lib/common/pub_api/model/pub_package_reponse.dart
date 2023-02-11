import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_riverpod_code_gen/common/pub_api/model/package.dart';

part 'pub_package_reponse.freezed.dart';
part 'pub_package_reponse.g.dart';

@freezed
class PubPackageReponse with _$PubPackageReponse {
  factory PubPackageReponse({
    required List<Package> packages,
  }) = _PubPackageReponse;

  factory PubPackageReponse.fromJson(Map<String, Object?> json) =>
      _$PubPackageReponseFromJson(json);
}
