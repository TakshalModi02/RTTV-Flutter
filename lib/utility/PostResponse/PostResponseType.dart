import 'package:rttv/UI/screens/videoPlayer/model/videoPlayerResponse.dart';

enum PostResponseEnum {
  failed,
  success,
  alreadyAdded,
  error,
}

class PostResponseType {
  PostResponseType({
    required this.postResponseEnum,
    this.message = "default",
    this.data = "",
    this.video
  });

  final PostResponseEnum postResponseEnum;
  final String message;
  final String? data;
  final VideoPlayerResponseModel? video;
}
