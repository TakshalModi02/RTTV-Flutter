import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rttv/UI/screens/videoPlayer/controller/videoPlayerController.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  // final VideoPlayerResponseModel videoModel;
  final String id;
  const VideoPlayerScreen({required this.id});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoController;
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
    videoController = VideoPlayerController.networkUrl(
        Uri.parse("https://rttv-movies.s3.amazonaws.com/${widget.id}.mp4"));
    _initializeVideoPlayerFuture = videoController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            return AspectRatio(
                              aspectRatio: videoController.value.aspectRatio,
                              child: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: VideoPlayer(videoController),
                              ),
                            );
                          }
                        },
                      ),
                      Positioned(
                        // right: double.infinity/2,
                        top: 80,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow),
                              onPressed: _togglePlayPause,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 16.0,
                        right: 16.0,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(_isFullScreen
                                  ? Icons.fullscreen_exit
                                  : Icons.fullscreen),
                              onPressed: _toggleFullScreen,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.model!.movieName,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '${controller.model!.star}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        '${controller.model!.languages.map((language) => language['language']).join(", ")} | ',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Text(
                      '${controller.model!.genres.map((genre) => genre['genre']).join(", ")} | ',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '${controller.model!.duration} minutes | ',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      '${controller.model!.releaseYear}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    '${controller.model!.cast.map((actor) => actor['name']).join(", ")}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '${controller.model!.description}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        videoController.pause();
      } else {
        videoController.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleFullScreen() {
    setState(() {
      if (_isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      }
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }
}
