import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tiktok/app/constants/Assets.dart';
import 'package:video_player/video_player.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  static Color white = Colors.white;
  static Color grey200 = Colors.grey.shade200;
  static Color grey300 = Colors.grey.shade300;
  static Color grey = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _appBar(),
      body: body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: white,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.add,
            width: 10,
            height: 10,
          ).padding(horizontal: 5),
          Text(
            'Add name',
            style: TextStyle(fontSize: 16),
          ),
        ],
      )
          .padding(vertical: 3, horizontal: 7)
          .backgroundColor(grey200)
          .clipRRect(all: 5),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            Image.asset(
              Assets.jokowi,
              width: 30,
              height: 30,
            ).clipOval(),
            Text(
              "3K",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            )
                .backgroundColor(white)
                .clipRRect(all: 3)
                .positioned(bottom: 4, right: 0),
          ],
        ).width(40).height(40),
        Image.asset(
          Assets.menu,
          width: 30,
          height: 30,
        ).padding(horizontal: 16),
      ],
    );
  }

  Widget body() {
    return ListView(
      children: [
        profile().padding(top: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "@ermansibarani",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ).padding(right: 5, vertical: 10),
            SvgPicture.asset(Assets.verified, width: 15, height: 15)
          ],
        ),
        description(),
        tab(),
      ],
    );
  }

  Widget tab() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: white,
        appBar: TabBar(
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(icon: SvgPicture.asset(Assets.profileMore)),
            Tab(icon: SvgPicture.asset(Assets.privacy)),
            Tab(icon: SvgPicture.asset(Assets.heartHide)),
            Tab(icon: SvgPicture.asset(Assets.heartHide)),
          ],
        ),
        body: TabBarView(
          children: [
            listCard(controller.videoList),
            listCard(controller.videoList),
            listCard(controller.videoList),
            listCard(controller.videoList),
          ],
        ),
      ),
    ).height(500);
  }

  Widget listCard(List<VideoItem> list) {
    return GridView.count(
      physics: const ClampingScrollPhysics(),
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      childAspectRatio: 0.8,
      crossAxisCount: 3,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        for (var i = 0; i < list.length; i++) ...[videoItem(list[i])]
      ],
    );
  }

  Widget videoItem(VideoItem item) {
    late VideoPlayerController _controller;
    _controller = VideoPlayerController.asset(item.videoUrl)
      ..initialize().then((_) {});
    return Stack(
      children: [
        Container(
          width: 200,
          height: 200,
          child: AspectRatio(aspectRatio: 1, child: VideoPlayer(_controller)),
        ).gestures(onTap: () => controller.onTapDetail(item)),
        Positioned(
          bottom: 0, left: 0,
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.play,
                width: 20,
                height: 20,
                color: white,
              ),
              Text(
                item.viewCount,
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ).padding(left: 5)
            ],
          ),
        ),
      ],
    );
  }

  Widget description() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            countWidget("6", "Following"),
            countWidget("99M", "Follower"),
            countWidget("999M", "Likes"),
          ],
        ).padding(bottom: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            textButton("Edit profile"),
            textButton("Share profile"),
            SvgPicture.asset(Assets.profileAdd)
                .padding(horizontal: 15, vertical: 10)
                .backgroundColor(grey300)
                .clipRRect(all: 5),
          ],
        ).padding(bottom: 10),
        textDesc("FUllstack Engineer ✨"),
        textDesc("FE => Flutter, NextJs & 3Js"),
        textDesc("BE => Spring, NestJs & Fastify"),
      ],
    ).padding(horizontal: 20);
  }

  Widget textDesc(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    );
  }

  Widget textButton(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    )
        .padding(horizontal: 15, vertical: 10)
        .backgroundColor(grey300)
        .clipRRect(all: 5);
  }

  Widget countWidget(String count, String text) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Text(text, style: TextStyle(color: grey, fontSize: 16)),
      ],
    );
  }

  Widget profile() {
    return Center(
      child: Stack(
        children: [
          Image.asset(Assets.erman).clipOval(),
          SvgPicture.asset(Assets.add, width: 15, height: 15, color: white)
              .paddingAll(5)
              .backgroundColor(Colors.cyan.shade300)
              .clipOval()
              .paddingAll(2)
              .backgroundColor(white)
              .clipOval()
              .positioned(right: -2, bottom: 5)
        ],
      ),
    );
  }
}
