import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_pelaporan/components/app-bar/app_bar_component.dart';
import 'package:sistem_pelaporan/components/text/text_component.dart';
import 'package:sistem_pelaporan/screens/autentikasi/login/login_screen.dart';
import 'package:sistem_pelaporan/services/firebase_services.dart';
import 'package:sistem_pelaporan/services/notification_services.dart';
import 'package:sistem_pelaporan/values/navigate_utils.dart';
import 'package:sistem_pelaporan/values/output_utils.dart';
import 'package:sistem_pelaporan/values/shared_preferences_utils.dart';

import 'dashboard/dashboard_screen.dart';

class PelaporScreen extends StatefulWidget {
  const PelaporScreen({super.key});

  @override
  State<PelaporScreen> createState() => _PelaporScreenState();
}

class _PelaporScreenState extends State<PelaporScreen> {
  final fs = FirebaseServices();

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = fs.getUser();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: fs.getDataQueryStream("laporan", "email", user?.email),
        builder: (context, snapshot) {
          final data = snapshot.data!.docs;

          if (data.length > 0) {
            bool showNotif = false;
            data.forEach((e) async {
              if (e["notifikasi"]) {
                showNotif = true;
                await fs.updateDataSpecifictDoc(
                    "laporan", e.id, {"notifikasi": false});
              }
            });

            if (showNotif) {
              NotificationServices.showNotification(
                  id: 1,
                  title: "Pemberitahuan",
                  body: "Polisi segera ke sana",
                  payload: "test");
            }
          }

          return Scaffold(
              // key: _scaffoldKey,
              appBar: AppBarComponent(
                  title: "",
                  // icLeft: Icons.notifications,
                  // typeLeftWidget: TypeLeftWidget.badgeWidget,
                  // textBadge: "$size",
                  // leftOnPressed: () {
                  //   print("test");
                  //   _scaffoldKey.currentState?.openDrawer();
                  // },
                  rightOnPressed: () {
                    SharedPreferencesUtils.reset(key: "nama");
                    navigatePush(LoginScreen(), isRemove: true);
                  }),
              // drawer: Drawer(
              //   child: ListView(
              //     padding: EdgeInsets.zero,
              //     children: [
              //       Container(
              //         height: 150,
              //         child: DrawerHeader(
              //           child: TextComponent(
              //             'Notifications',
              //             size: 18,
              //             color: Colors.white,
              //           ),
              //           decoration: BoxDecoration(
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              //       ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: 2,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Column(
              //             children: [
              //               ListTile(
              //                 title: Text("test"),
              //                 onTap: () {
              //                   // Tambahkan aksi yang ingin dilakukan saat notifikasi ditekan
              //                   print('Notification ${index + 1} tapped');
              //                 },
              //               ),
              //               Divider(), // Tambahkan Divider di sini
              //             ],
              //           );
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              body: DashboardScreen());
        });
  }
}
