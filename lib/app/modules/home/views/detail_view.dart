import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:marquee_list/marquee_list.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tiktok/app/constants/Assets.dart';
import 'package:video_player/video_player.dart';

import '../controllers/home_controller.dart';

class DetailView extends GetView<HomeController> {
  final VideoItem item;

  const DetailView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileList = controller.profileList;
    return Scaffold(
      body: body(profileList),
      bottomNavigationBar: navBar(),
    );
  }

  Widget body(profileList) {
    // late VideoPlayerController _controller = controller.videoDetailController;
    controller.videoDetailController =
    VideoPlayerController.asset(item.videoUrl)
      ..initialize().then((_) {
        controller.videoDetailController.play();
        controller.videoDetailController.setLooping(true);
        controller.videoDetailController.setVolume(50.0);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    return Stack(
      children: [
        Container(
          height: Get.height - 50,
          child: AspectRatio(
            aspectRatio: controller.videoDetailController.value.aspectRatio,
            child: VideoPlayer(controller.videoDetailController),
          ),
        ),
        VideoProgressIndicator(
            padding: EdgeInsets.zero,
            colors: VideoProgressColors(
                playedColor: Colors.white70,
                bufferedColor: Colors.grey.shade700,
                backgroundColor: Colors.grey),
            controller.videoDetailController,
            allowScrubbing: true)
            .positioned(bottom: 0, right: 0, left: 0),
        MarqueeList(
          scrollDuration: const Duration(seconds: 2),
          scrollDirection: Axis.vertical,
          children: List.generate(
            profileList.length,
                (i) =>
                Obx(() {
                  final time = controller.time.value;
                  return Align(
                    alignment: Alignment.bottomLeft,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: time > profileList[i].time ? 0 : 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            profileList[i].profile,
                            height: 40,
                            width: 40,
                          )
                              .clipOval()
                              .paddingAll(2)
                              .backgroundColor(Colors.grey)
                              .clipOval()
                              .padding(right: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    profileList[i].name,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ).padding(right: 5),
                                  SvgPicture.asset(
                                    Assets.verified,
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),
                              Text(
                                profileList[i].comment,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ).width(200),
                            ],
                          ),
                        ],
                      )
                          .padding(all: 5)
                          .backgroundColor(Colors.black.withOpacity(0.4))
                          .width(300)
                          .clipRRect(all: 20)
                          .padding(left: 16, bottom: 20, top: i == 0 ? 210 : 0),
                    ),
                  );
                }),
          ).toList(),
        ).height(210).positioned(bottom: 1, right: 0, left: 0),
        Row(
          children: [
            SvgPicture.asset(
              Assets.play,
              width: 20,
              height: 20,
              color: Colors.grey,
            ).padding(right: 5),
            Text(
              "Playlist: Speed Code",
              style: TextStyle(color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right_rounded, color: Colors.white,)
          ],
        )
            .padding(vertical: 5, horizontal: 10)
            .backgroundColor(Colors.black.withOpacity(0.2)).positioned(
            bottom: 5, right: 0, left: 0),
        Icon(
          Icons.keyboard_arrow_left_rounded,
          color: Colors.white,
          size: 40,
        )
            .gestures(
          onTap: () => controller.detailBack(),
        )
            .padding(top: 65),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.transparent,
          child: [
            Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ).padding(horizontal: 5),
            Text(
              "Flutter Developer",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            Spacer(),
            SizedBox(
              width: 2,
              height: 16,
            ).backgroundColor(Colors.grey).padding(right: 10),
            Text(
              "Searach",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ]
              .toRow(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min)
              .padding(vertical: 5, horizontal: 10),
        ).padding(left: 46, right: 14).positioned(top: 60, right: 0, left: 0),
        [
          Image.asset(Assets.erman, height: 50, width: 50)
              .clipOval()
              .paddingAll(2)
              .backgroundColor(Colors.white)
              .clipOval()
              .padding(bottom: 20),
          Obx(() {
            return SvgPicture.asset(Assets.like,
                color: controller.likeBtn.value ? Colors.red : Colors.white,
                width: 35);
          }).gestures(onTap: () => controller.btnLike()),
          Text(
            item.likeCount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ).padding(bottom: 20),
          SvgPicture.asset(Assets.comment, color: Colors.white, width: 35),
          Text(
            item.commentCount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ).padding(bottom: 30),
          Obx(() {
            return SvgPicture.asset(Assets.favorite,
                color: controller.saveBtn.value ? Colors.yellow : Colors.white,
                width: 30);
          }).gestures(onTap: () => controller.btnSave()),
          Text(
            item.shareCount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ).padding(bottom: 20),
          SvgPicture.asset(Assets.more, color: Colors.white, width: 35)
              .padding(bottom: 20),
          Image.asset(item.photoUrl, height: 40, width: 40)
              .clipOval()
              .padding(bottom: 20),
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.center)
            .padding(left: Get.width - 70)
            .width(10)
            .positioned(bottom: 30, right: 0, left: 0),
      ],
    );
  }

  Widget navBar() {
    return [
      SvgPicture.asset(
        Assets.play,
        width: 20,
        height: 20,
        color: Colors.grey,
      ).padding(right: 5),
      Text(
        "${item.viewCount} views",
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
      Spacer(),
      [
        SvgPicture.asset(
          Assets.analytic,
          width: 20,
          height: 20,
          color: Colors.white,
        ).padding(right: 5),
        Text(
          "More insights",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ]
          .toRow()
          .padding(horizontal: 10, vertical: 4)
          .backgroundColor(Colors.grey.shade700)
          .clipRRect(all: 40),
    ]
        .toRow()
        .padding(horizontal: 10, top: 10, bottom: 40)
        .backgroundColor(Colors.black);
  }
}
