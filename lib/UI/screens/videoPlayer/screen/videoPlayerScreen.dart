import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    double screenWidth = Get.width;
    print(screenHeight);
    print(screenWidth);
    return Obx(() {
      return Scaffold(
        body: controller.isLoading.value
            ? Center(
                child: Lottie.asset(
                  'assets/Animation - 1708575008332.json',
                  width: screenWidth * 0.2604, // Adjust width as needed
                  height: screenHeight * 0.1188, // Adjust height as needed
                ),
              )
            : Column(
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03125,
                                    vertical: screenHeight * 0.0095),
                                child: Text(controller.model!.movieName,
                                    style: GoogleFonts.ptSerif(
                                        fontSize: screenWidth * 0.06510,
                                        color: Colors.white)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03125,
                                    vertical: screenHeight * 0.0095),
                                child: Row(
                                  children: [
                                    Text('${controller.model!.star}',
                                        style: GoogleFonts.ptSerif(
                                            fontSize: screenWidth * 0.06510,
                                            color: Colors.white)),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: screenWidth * 0.06510,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.02971,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    screenWidth * 0.03125, 0, 0, 0),
                                child: Text(
                                    '${controller.model!.languages.map((language) => language['language']).join(", ")} | ',
                                    style: GoogleFonts.sourceSans3(
                                        fontSize: screenWidth * 0.04427,
                                        color: Colors.white)),
                              ),
                              Text(
                                '${controller.model!.genres.map((genre) => genre['genre']).join(", ")} | ',
                                style: GoogleFonts.sourceSans3(
                                    fontSize: screenWidth * 0.04427,
                                    color: Colors.white),
                              ),
                              Text('${controller.model!.duration} minutes | ',
                                  style: GoogleFonts.sourceSans3(
                                      fontSize: screenWidth * 0.04427,
                                      color: Colors.white)),
                              Text('${controller.model!.releaseYear}',
                                  style: GoogleFonts.sourceSans3(
                                      fontSize: screenWidth * 0.04427,
                                      color: Colors.white)),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.03125),
                            child: Text(
                                '${controller.model!.cast.map((actor) => actor['name']).join(", ")}',
                                style: GoogleFonts.sourceSans3(
                                    fontSize: screenWidth * 0.04427,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.03125),
                            child: Text('${controller.model!.description}',
                                style: GoogleFonts.sourceSans3(
                                    fontSize: screenWidth * 0.04427,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    chewieController.dispose();
  }
}
