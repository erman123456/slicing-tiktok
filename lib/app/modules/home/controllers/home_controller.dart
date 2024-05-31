import 'dart:async';

import 'package:get/get.dart';
import 'package:tiktok/app/constants/Assets.dart';
import 'package:tiktok/app/modules/home/views/detail_view.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  final likeBtn = false.obs;
  final saveBtn = false.obs;
  late Timer _timer;
  final time = 0.obs;
  final List<ProfileItem> profileList = [
    ProfileItem(
        name: "Jokowi",
        profile: Assets.jokowi,
        comment: "Keren lu mann,,, 🔥🔥",
        time: 5),
    ProfileItem(
        name: "Prabowo",
        profile: Assets.prabowo,
        comment: "Mantap kedan kuuu,,, 🔥🔥",
        time: 6),
    ProfileItem(
        name: "Zikri Akmal",
        profile: Assets.zikri,
        comment: "Keren bang 🔥,, Flutter yaa?",
        time: 8),
    ProfileItem(
        name: "felix_seran", profile: Assets.felix, comment: "🔥🔥🔥", time: 9),
    ProfileItem(
        name: "igho",
        profile: Assets.rian,
        comment: "Keren kali lihat abang ini,, 🔥🔥",
        time: 12),
    ProfileItem(
        name: "Erik Tohir ",
        profile: Assets.erik,
        comment: "Semangat anak muda 🔥🔥🔥",
        time: 13),
    ProfileItem(
        name: "gibran_rakabuming", profile: Assets.gibran, comment: "Ini baru anak mudaaa 🔥", time: 14),
    ProfileItem(
        name: "angelinawj", profile: Assets.kim, comment: "🔥🔥", time: 15),
  ];

//TODO: Implement HomeController
  final List<VideoItem> videoList = [
    VideoItem(
        photoUrl: Assets.coverV1,
        videoUrl: Assets.ovo,
        likeCount: "10.4M",
        viewCount: "50.2M",
        commentCount: "100.3K",
        favoriteCount: "320.5K",
        shareCount: "230.5K",
        profileImage: Assets.erman),
    VideoItem(
        photoUrl: Assets.coverV2,
        videoUrl: Assets.instagram,
        likeCount: "2.4M",
        viewCount: "10.2M",
        commentCount: "80.3K",
        favoriteCount: "120.5K",
        shareCount: "30.5K",
        profileImage: Assets.erman),
    VideoItem(
        photoUrl: Assets.coverV3,
        videoUrl: Assets.telkomsel,
        likeCount: "50.2M",
        viewCount: "90.4M",
        commentCount: "1.4M",
        favoriteCount: "10.5M",
        shareCount: "840.9K",
        profileImage: Assets.erman),
    VideoItem(
        photoUrl: Assets.coverV4,
        videoUrl: Assets.bca,
        likeCount: "5.2M",
        viewCount: "70.4M",
        commentCount: "900.4K",
        favoriteCount: "600.KM",
        shareCount: "340.9K",
        profileImage: Assets.erman),
  ];
  late VideoPlayerController controller;
  late VideoPlayerController videoDetailController;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // videoDetailController = VideoPlayerController.asset("")
    //   ..initialize().then((_) {
    //   });
    controller = VideoPlayerController.asset(videoList[0].videoUrl)
      ..initialize().then((_) {
        // controller.play();
        // controller.setLooping(true);
        controller.setVolume(0.0);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        print(time.value);
        if (time.value == 50) {
          timer.cancel();
        } else {
          time.value++;
        }
      },
    );
  }

  void stop() {
    time.value = 0;
    _timer.cancel();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }
  void btnLike() {
    likeBtn.value = likeBtn.value ? false : true;
  }

  void btnSave() {
    saveBtn.value = saveBtn.value ? false : true;
  }

  void detailBack()  {
    videoDetailController.pause();
    stop();
    likeBtn.value = false;
    saveBtn.value = false;
    Get.back();
  }

  Future<void> onTapDetail(itemX) async {
    Get.to(DetailView(item: itemX));
    startTimer();
  }
}

class ProfileItem {
  const ProfileItem({
    required this.name,
    required this.profile,
    required this.comment,
    required this.time,
  });

  final String name;
  final String profile;
  final String comment;
  final int time;
}

class VideoItem {
  const VideoItem({
    required this.photoUrl,
    required this.videoUrl,
    required this.likeCount,
    required this.viewCount,
    required this.commentCount,
    required this.favoriteCount,
    required this.shareCount,
    required this.profileImage,
  });

  final String photoUrl;
  final String videoUrl;
  final String likeCount;
  final String viewCount;
  final String commentCount;
  final String favoriteCount;
  final String shareCount;
  final String profileImage;
}
