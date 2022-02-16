import 'package:doctor_booking_application/Components/RowTextField.dart';
import 'package:doctor_booking_application/Template/screens/home.dart';
import 'package:doctor_booking_application/Template/tabs/HomeTab.dart';
import 'package:doctor_booking_application/first_page/first_page.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'Template/tabs/ScheduleTab.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 1,
      ),
      body: switchWidget(currentPage, scaffoldKey),
      bottomNavigationBar: FancyBottomNavigation(
        // inactiveIconColor: Theme.of(context).primaryColor.withOpacity(0.32),
        inactiveIconColor: Colors.black12,
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.calendar_today, title: "Appointments"),
          // TabData(iconData: Icons.message_outlined, title: "Message"),
          TabData(iconData: Icons.history, title: 'History'),
        ],
        onTabChangedListener: (position) {
          setState(
            () {
              currentPage = position;
            },
          );
        },
      ),
    );
  }

  Widget switchWidget(int position, key) {
    switch (position) {
      case 0:
        return FirstPageWidget();
      case 1:
        return ScheduleTab();
      case 2:
        return FirstPage();
      // case 3:
      //   return FinalPage();
      default:
        return Text('data');
    }
  }
}

class FirstPageWidget extends StatelessWidget {
  // GlobalKey<ScaffoldState>? scaffoldKey;
  // FirstPageWidget(scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(
            top: 16,
          ),
          child: ListTile(
            minLeadingWidth: 32,
            contentPadding: EdgeInsets.symmetric(horizontal: 4),
            minVerticalPadding: 0,
            leading: Container(
              color: Colors.transparent,
              child: IconButton(
                iconSize: 28,
                onPressed: () {
                  print('Working');
                  // scaffoldKey!.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu_rounded,
                  color: Style.primary.shade100,
                  // size: 18,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(
                top: 14,
                left: 0,
                bottom: 8,
              ),
              child: Text(
                'Hey, Mahi',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white.withOpacity(0.87),
                      fontSize: 18,
                    ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              child: Text(
                'Good Morning,',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      // fontWeight: FontWeight.bold,
                      color: Style.primary.shade100,
                      fontSize: 22,
                    ),
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notification_add_outlined,
                color: Style.primary.shade100,
                size: 20,
              ),
            ),
          ),
        ),
        Positioned(
          top: 120,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            padding: EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.height,
                  Text(
                    'Whom are you looking for today?',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                  ),
                  8.height,
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      'List of Your Favorite Doctors',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.black38,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    height: MediaQuery.of(context).size.height / 2.64,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.6,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 24,
                      ),
                      itemBuilder: (context, index) => FittedBox(
                        fit: BoxFit.contain,
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/doctor.jpg'),
                                radius: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    Text(
                                      'Dr. Murari',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: Style.darkerText,
                                            // color: Theme.of(context).primaryColor,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Heart Specialist',
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontSize: 11,
                                            // color: Colors.black54,
                                            color: Style.lightText
                                                .withOpacity(0.60),
                                            // color: Theme.of(context).primaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      itemCount: 10,
                    ),
                  ),
                  Settingstext(
                    title: 'Appointment Today',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppointmentCard(
                    onTap: () {
                      print('Working');
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 300,
                  ),
                ],
                // children: [
                //   Container(
                //     padding: const EdgeInsets.symmetric(
                //       vertical: 8,
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         LargeIconButton(
                //           icon: Icons.send_rounded,
                //           title: 'Send Package',
                //           onPressed: () {
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //     builder: (context) => ProfilePage(),
                //             //   ),
                //             // );
                //           },
                //         ),
                //         LargeIconButton(
                //           icon: Icons.track_changes_rounded,
                //           title: 'Track Order',
                //           onPressed: () {
                //             // Get.to(() => ProductManagementPage());
                //           },
                //         ),
                //         LargeIconButton(
                //           icon: Icons.check_rounded,
                //           title: 'Check Price',
                //           onPressed: () {
                //             // Get.to(() => ProductManagementPage());
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                //   Settingstext(
                //     title: 'Promo Today',
                //   ),
                //   Container(
                //     height: MediaQuery.of(context).size.height / 4.82,
                //     margin: EdgeInsets.symmetric(
                //       horizontal: 8,
                //       vertical: 16,
                //     ),
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('assets/images/banner.png'),
                //         fit: BoxFit.cover,
                //       ),
                //       borderRadius: BorderRadius.circular(16),
                //     ),
                //     alignment: Alignment.center,
                //     // child: Image(
                //     //   image: AssetImage('assets/images/banner.png'),
                //     // ),
                //   ),
                //   Settingstext(
                //     title: 'Today\'s Deliveries',
                //   ),
                // ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class LargeIconButton extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onPressed;
  LargeIconButton({
    this.icon,
    this.title = '',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextButton(
        style: OutlinedButton.styleFrom(
          shape: CircleBorder(),
        ),
        onPressed: () => onPressed!(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Style.primary.shade50.withOpacity(0.60),
              ),
              child: Icon(
                icon,
                color: Style.primary.shade400,
                size: 18,
              ),
            ),
            Container(
              width: 80,
              margin: EdgeInsets.only(top: 4),
              child: Text(
                title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      // color: Style.primary.withOpacity(0.87),
                      fontSize: 12,
                      color: Style.primary.shade900,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Settingstext extends StatelessWidget {
  final String? title;
  final Color? customColor;

  Settingstext({
    this.title,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 16,
                    color: customColor ?? Colors.black54,
                  ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 2,
              endIndent: 8,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
