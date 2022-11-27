import 'package:graphql_zero_app/common/model/post_model.dart';

abstract class PostRemoteSource {
  Future<PostModel> getPostById(String id);
}
