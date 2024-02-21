import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:rttv/UI/screens/videoPlayer/model/videoPlayerResponse.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:http/http.dart' as http;

class VideoPlayerScreenController extends GetxController {
  VideoPlayerResponseModel? model;
  RxBool isLoading = true.obs;
  Future<PostResponseType> intializeController(String id) async {
    try {
      final baseURL = dotenv.env['BASE_URL'];
      final url = Uri.parse(baseURL! + "getmovie/" + id);

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      print(url);
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final VideoPlayerResponseModel responseModel =
            VideoPlayerResponseModel(body);
        model = responseModel;
        // Return success response
        return PostResponseType(
          postResponseEnum: PostResponseEnum.success,
          message: 'Video loaded successfully',
          video: responseModel,
        );
      } else {
        // Return error response
        return PostResponseType(
          postResponseEnum: PostResponseEnum.error,
          message: 'Failed to load video',
        );
      }
    } catch (e) {
      return PostResponseType(
        postResponseEnum: PostResponseEnum.failed,
        message: 'Error: $e',
      );
    }
  }
}
