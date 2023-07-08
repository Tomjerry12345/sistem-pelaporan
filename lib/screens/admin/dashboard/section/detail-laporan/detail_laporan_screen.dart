import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/components/button/button_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/values/font_custom.dart';
import 'package:sistem_pelaporan/values/screen_utils.dart';
import 'package:sistem_pelaporan/values/widget_utils.dart';

class DetailLaporanScreen extends StatefulWidget {
  const DetailLaporanScreen({super.key});

  @override
  State<DetailLaporanScreen> createState() => _DetailLaporanScreenState();
}

class _DetailLaporanScreenState extends State<DetailLaporanScreen> {
  final appBar = const AppBarComponent(
    fg: Colors.white,
    icLeft: Icons.arrow_back,
    title: "Detail Laporan",
    sizeTitle: 18,
  );

  ScrollController _scrollController = ScrollController();

  bool isFullScroll = false;

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
                    TextComponent("Kekerasan di jalan meresahkan"),
                    V(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: Image.asset("assets/images/bg_login"),
                            ),
                            H(16),
                            TextComponent("Luffy D Monkey", size: 16)
                          ],
                        ),
                        TextComponent("April 23, 2023", size: 16)
                      ],
                    ),
                    V(24),
                    SingleChildScrollView(
                      child: Container(
                        height: isFullScroll ? 0.4.h : 0.12.h,
                        child: TextComponent(
                          "Perilaku ini termasuk ",
                          size: 16,
                          weight: FW.light,
                        ),
                      ),
                    ),
                    isFullScroll ? V(24) : V(0.07.h),
                    Container(
                      width: double.infinity,
                      height: isFullScroll ? 150 : 200,
                      child: Image.asset("assets/images/bg_login"),
                    ),
                    isFullScroll ? V(24) : V(0.05.h),
                    Expanded(
                      child: Align(
                        alignment: isFullScroll ? Alignment.bottomCenter : Alignment.topCenter,
                        child: Container(
                            width: double.infinity,
                            child: ButtonElevatedComponent("Verifikasi laporan", onPressed: () {
                              double scrollXPosition = _scrollController.position.pixels;
                              print(scrollXPosition);
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
