import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rttv/UI/screens/videoPlayer/controller/videoPlayerController.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/numbers.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  // final VideoPlayerResponseModel videoModel;
  final String id;
  const VideoPlayerScreen({required this.id});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late ChewieController chewieController;
  VideoPlayerScreenController controller =
      Get.put(VideoPlayerScreenController());
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    controller.intializeController(widget.id).then((response) => {
          if (response.postResponseEnum == PostResponseEnum.success)
            {}
          else if (response.postResponseEnum == PostResponseEnum.error)
            {print(response.message)}
          else
            {print(response.message)}
        });
    _initializeVideoPlayerFuture = _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    final videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse("https://rttv-movies.s3.amazonaws.com/${widget.id}.mp4"),
    );
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      // Customize controls
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.black,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      // Fullscreen callback
      fullScreenByDefault: false,
      allowMuting: true,
      showControlsOnInitialize: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Chewie(
              controller: chewieController,
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 57, 56, 53),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8.0),
                        child: Text(controller.model!.movieName,
                            style: GoogleFonts.ptSerif(
                                fontSize: twentyfive, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8.0),
                        child: Row(
                          children: [
                            Text('${controller.model!.star}',
                                style: GoogleFonts.ptSerif(
                                    fontSize: twentyfive, color: Colors.white)),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: twentyfive,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        child: Text(
                            '${controller.model!.languages.map((language) => language['language']).join(", ")} | ',
                            style: GoogleFonts.sourceSans3(
                                fontSize: 17, color: Colors.white)),
                      ),
                      Text(
                        '${controller.model!.genres.map((genre) => genre['genre']).join(", ")} | ',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text('${controller.model!.duration} minutes | ',
                          style: GoogleFonts.sourceSans3(
                              fontSize: 17, color: Colors.white)),
                      Text('${controller.model!.releaseYear}',
                          style: GoogleFonts.sourceSans3(
                              fontSize: 17, color: Colors.white)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                        '${controller.model!.cast.map((actor) => actor['name']).join(", ")}',
                        style: GoogleFonts.sourceSans3(
                            fontSize: 17, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('${controller.model!.description}',
                        style: GoogleFonts.sourceSans3(
                            fontSize: 17, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    chewieController.dispose();
  }
}
