import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/screens/polisi/laporan/laporan_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/position_utils.dart';
import 'package:video_player/video_player.dart';

class DetailLaporanScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String id;
  const DetailLaporanScreen({super.key, required this.data, required this.id});

  @override
  State<DetailLaporanScreen> createState() => _DetailLaporanScreenState();
}

class _DetailLaporanScreenState extends State<DetailLaporanScreen> {
  final fs = FirebaseServices();
  final appBar = const AppBarComponent(
    fg: Colors.white,
    icLeft: Icons.arrow_back,
    title: "Detail Laporan",
    sizeTitle: 18,
  );

  ScrollController _scrollController = ScrollController();
  late VideoPlayerController _controller;

  bool isFullScroll = false;

  @override
  void initState() {
    super.initState();
    if (widget.data["type_file"] == "video") {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.data["file"]))
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {});
            });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      double scrollXPosition = _scrollController.position.pixels;
      if (scrollXPosition >= 167.36) {
        setState(() {
          isFullScroll = true;
        });
        return;
      } else if (scrollXPosition == 0.0) {
        setState(() {
          isFullScroll = false;
        });
        return;
      }
    });

    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: 1.0.w,
          height: 0.2.h,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: appBar.leftIcon()),
              Expanded(child: appBar.titleC()),
              Expanded(child: appBar.rightIcon()),
            ],
          ),
        ),
        SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.only(top: 0.18.h),
            child: Card(
              margin: EdgeInsets.zero,
              child: Container(
                height: 1.0.h,
                width: double.infinity,
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isFullScroll ? V(60) : V(24),
                    TextComponent(widget.data["jenis_laporan"]),
                    V(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: CircleAvatar(child: Text("A")),
                            ),
                            H(16),
                            TextComponent(widget.data["nama"], size: 16)
                          ],
                        ),
                        TextComponent(widget.data["tanggal"], size: 16)
                      ],
                    ),
                    V(24),
                    TextComponent("telepon: ${widget.data["no_telepon"]}",
                        size: 14),
                    V(24),
                    SingleChildScrollView(
                      child: Container(
                        height: isFullScroll
                            ? widget.data["type_file"] == "video"
                                ? 0.35.h
                                : 0.4.h
                            : widget.data["type_file"] == "video"
                                ? 0.12.h
                                : 0.18.h,
                        child: TextComponent(
                          widget.data["deskripsi"],
                          size: 16,
                          weight: FW.light,
                        ),
                      ),
                    ),
                    isFullScroll ? V(16) : V(0.07.h),
                    Center(
                      child: Container(
                        width: 300,
                        height: isFullScroll ? 150 : 150,
                        child: widget.data["type_file"] == "image"
                            ? Image.network(widget.data["file"])
                            : AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                      ),
                    ),
                    widget.data["type_file"] == "video"
                        ? isFullScroll
                            ? V(16)
                            : V(0.02.h)
                        : V(0),
                    widget.data["type_file"] == "video"
                        ? Center(
                            child: ButtonElevatedComponent(
                                _controller.value.isPlaying
                                    ? "Pause video"
                                    : "Play video", onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            }),
                          )
                        : Container(),
                    isFullScroll ? V(16) : V(0.04.h),
                    Expanded(
                      child: Align(
                        alignment: isFullScroll
                            ? Alignment.bottomCenter
                            : Alignment.topCenter,
                        child: Container(
                            width: double.infinity,
                            child: ButtonElevatedComponent("Verifikasi laporan",
                                onPressed: () async {
                              try {
                                showLoaderDialog();
                                await fs.updateDataSpecifictDoc(
                                    "laporan", widget.id, {"type": "keluar"});
                                navigatePush(const LaporanScreen(),
                                    isRemove: true);
                              } catch (e) {
                                showToast(e);
                                closeDialog();
                              }
                            })),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
