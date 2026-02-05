import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/guide%20line/aboutus_controller.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/rental_trip_title.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HowToUseAppPage extends StatefulWidget {
  const HowToUseAppPage({Key? key}) : super(key: key);

  @override
  State<HowToUseAppPage> createState() => _HowToUseAppPageState();
}

class _HowToUseAppPageState extends State<HowToUseAppPage> {
  final AboutUsController _aboutUsController = Get.put(AboutUsController());

  @override
  void initState() {
    // TODO: implement initState
    AboutUsController().getAboutUS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              CustomAppBar(appbarTitle: ''),
              Padding(
                padding: paddingH20,
                child: Row(
                  children: [
                    RentalTripTitle(
                      title: 'How To Use Our App',
                      subTitle: "Here describe how to use our App",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: 546,
        child: Obx(
          () => _aboutUsController.isLoading.value
              ? loader()
              : ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: YouTubeVideoPlayer(
                        videoUrl: index == 0
                            ? _aboutUsController.videoOne.value
                            : _aboutUsController.videoTwo.value,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class YouTubeVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const YouTubeVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  State<YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoId =
        YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
        forceHD: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
      progressColors: const ProgressBarColors(
        playedColor: Colors.red,
        handleColor: Colors.redAccent,
      ),
    );
  }
}
