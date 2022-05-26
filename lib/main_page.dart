import 'package:doctor_booking_application/Components/company_appbar.dart';
import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/Registration/patient_registration.dart';

import 'package:doctor_booking_application/Widgets/titleView.dart';
import 'package:doctor_booking_application/book_appoinment/book_appoinment_main.dart';
import 'package:doctor_booking_application/book_appoinment/book_slot.dart';
import 'package:doctor_booking_application/constants.dart';
import 'package:doctor_booking_application/database/database_export.dart';
import 'package:doctor_booking_application/doctor/doctor_appointment_page.dart';
import 'package:doctor_booking_application/first_page/first_page.dart';
import 'package:doctor_booking_application/modals/doctors.dart';
import 'package:doctor_booking_application/modals/model_export.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'Template/tabs/ScheduleTab.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPage extends StatefulWidget {
  final bool doctorLogin;
  const MainPage({Key? key, this.doctorLogin = true}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  bool get doctorLogin => widget.doctorLogin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainPageScaffoldKey,
      appBar: AppBar(
        toolbarHeight: 1,
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width - 80,
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Style.primary.shade600,
            ),
            TitleView(
              title: 'Doctor',
            ),
            ...[
              ['My Schedule', Icons.calendar_today, DoctorAppointmentPage()],
              [
                'Profile',
                Icons.person,
                Scaffold(
                  appBar: PreferredSize(
                    child: CompanyAppbar(title: 'Doctor Registration Page'),
                    preferredSize: Size(
                      double.infinity,
                      60,
                    ),
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DoctorRegistrationPage(
                        doctor: Doctor(),
                      ),
                    ),
                  ),
                )
              ],
              ['Notification', Icons.message_rounded, MainPage()],
              ['Settings', Icons.settings, MainPage()],
              ['Logout', Icons.exit_to_app, MainPage()],
            ]
                .map(
                  (e) => CustomDrawerWidget(
                    title: e[0].toString(),
                    icon: e[1] as IconData,
                    widget: e[2] as Widget,
                  ),
                )
                .toList(),
            TitleView(
              title: 'Patient',
            ),
            ...[
              [
                'Profile',
                Icons.person,
                PatientRegistrationPage(
                  patient: Patient(),
                  isNewPatient: true,
                ),
              ],
              ['Notifications', Icons.person, MainPage()],
              ['Settings', Icons.settings, MainPage()],
              ['Logout', Icons.exit_to_app, MainPage()],
            ]
                .map(
                  (e) => CustomDrawerWidget(
                    title: e[0].toString(),
                    icon: e[1] as IconData,
                    widget: e[2] as Widget,
                  ),
                )
                .toList(),
          ],
        ),
      ),
      // body: (doctorLogin) ? DoctorAppointmentPage() : FirstPageWidget(),
      body: (doctorLogin)
          ? FirstPageWidget(
              isPatient: false,
            )
          : FirstPageWidget(
              isPatient: true,
            ),
      // : switchWidget(currentPage, mainPageScaffoldKey),
      // bottomNavigationBar: (doctorLogin)
      //     ? null
      //     : FancyBottomNavigation(
      //         inactiveIconColor: Colors.black12,
      //         tabs: [
      //           TabData(iconData: Icons.home, title: "Home"),
      //           TabData(iconData: Icons.calendar_today, title: "Appointments"),
      //           TabData(iconData: Icons.history, title: 'History'),
      //         ],
      //         onTabChangedListener: (position) {
      //           setState(
      //             () {
      //               currentPage = position;
      //             },
      //           );
      //         },
      //       ),
    );
  }

  Widget switchWidget(int position, key) {
    switch (position) {
      case 0:
        return FirstPageWidget();
      case 1:
        return DoctorAppointmentPage();
      case 2:
        return FirstPage();
      // case 3:
      //   return FinalPage();
      default:
        return Text('');
    }
  }
}

class CustomDrawerWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? widget;
  final VoidCallback? function;
  const CustomDrawerWidget(
      {Key? key,
      required this.title,
      required this.icon,
      this.widget,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            if (widget != null) {
              if (title == 'My Schedule')
                Style.navigate(
                  context,
                  MainPage(
                    doctorLogin: true,
                  ),
                );
              else
                Style.navigate(
                  context,
                  MainPage(
                    doctorLogin: false,
                  ),
                );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => widget!,
              //   ),
              // );
            } else if (function != null) {
              function!();
            }
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            leading: Icon(
              icon,
              color: Style.primary.shade300,
              size: 18,
            ),
            minLeadingWidth: 8,
            title: Text(
              title,
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: Style.primary.shade900.withOpacity(0.87),
                  ),
            ),
          ),
        ),
        Divider(
          color: Style.primary.shade100,
          thickness: 0.32,
          indent: 32,
          endIndent: 8,
        ),
      ],
    );
  }
}

class FirstPageWidget extends StatelessWidget {
  final bool isPatient;
  FirstPageWidget({Key? key, this.isPatient = true}) : super(key: key);

  String get greetings {
    if (TimeOfDay.now().hour < 12)
      return 'Good Morning';
    else if (TimeOfDay.now().hour < 18)
      return 'Good Afternoon';
    else
      return 'Good Evening';
  }

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
            style: ListTileStyle.drawer,
            leading: Container(
              color: Colors.transparent,
              child: IconButton(
                iconSize: 28,
                onPressed: () => mainPageScaffoldKey.currentState!.openDrawer(),
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.white.withOpacity(0.87),
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
                horizontal: 0,
              ),
              child: Text(
                greetings,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      // fontWeight: FontWeight.bold,
                      color: Style.primary.shade50,
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
              child: (isPatient)
                  ? PatientFirstPageWidget()
                  : DoctorFirstPageWidget(),
            ),
          ),
        )
      ],
    );
  }
}

class DoctorFirstPageWidget extends StatelessWidget {
  const DoctorFirstPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleView(
          title: 'Your Appointments',
        ),
        ...['Today', 'Tomorrow', 'Day After'].map(
          (e) => ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            title: Text(
              e,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Style.primary.shade100,
              size: 18,
            ),
            onTap: () {
              Style.navigateBack(
                context,
                DoctorAppointmentPage(),
              );
            },
          ),
        ),
        8.height,
        TitleView(
          title: 'Quick Actions',
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LargeIconButton(
                  icon: Icons.send_rounded,
                  title: 'Send Package',
                  onPressed: () {
                    Style.navigateBack(
                      context,
                      DoctorAppointmentPage(),
                    );
                  },
                ),
                LargeIconButton(
                  icon: Icons.track_changes_rounded,
                  title: 'Track Order',
                  onPressed: () {
                    // Get.to(() => ProductManagementPage());
                  },
                ),
                LargeIconButton(
                  icon: Icons.check_rounded,
                  title: 'Check Price',
                  onPressed: () {
                    // Get.to(() => ProductManagementPage());
                  },
                ),
              ],
            ),
          ),
        ),

        TitleView(
          title: 'Appointment Today',
        ),
        SizedBox(
          height: 20,
        ),
        // AppointmentCard(
        //   onTap: () {
        //     print('Working');
        //   },
        // ),
      ],
    );
  }
}

class PatientFirstPageWidget extends StatelessWidget {
  const PatientFirstPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('The local appointment id is  ${Local.getAppointmentId}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: TextField(
            readOnly: true,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => BookAppoinmentPage(),
              ),
            ),
            decoration: Style.searchFieldStyle,
          ),
        ),
        // if (Local.getAppointmentId != null)
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 16.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         DarkTitleView(
        //           'Your Appointments',
        //         ),
        //         ListTile(
        //           onTap: () {
        //             Style.navigateBack(context, BookSlotPage());
        //           },
        //           contentPadding: EdgeInsets.symmetric(
        //             vertical: 8,
        //             horizontal: 6,
        //           ),
        //           title: Text(
        //             'Appointment Status',
        //             style: Theme.of(context).textTheme.headline6!.copyWith(
        //                   color: Colors.black.withOpacity(0.70),
        //                   // color: C,
        //                   fontSize: 16,
        //                 ),
        //           ),
        //           subtitle: Padding(
        //             padding: const EdgeInsets.all(2),
        //             child: Text(
        //               'Click to check you appointment status',
        //               style: Theme.of(context).textTheme.caption!.copyWith(
        //                     color: Colors.black45,
        //                   ),
        //             ),
        //           ),
        //           trailing: Icon(
        //             Icons.arrow_forward_ios,
        //             size: 18,
        //             color: Colors.grey.shade400,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),

        //TODO: check its' working or not
        ValueListenableBuilder<Box>(
          valueListenable: Hive.box('mainBox').listenable(),
          builder: (context, box, widget) {
            if (box.get('appointmentId') != null)
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DarkTitleView(
                      'Your Appointments',
                    ),
                    ListTile(
                      onTap: () {
                        Style.navigateBack(context, BookSlotPage());
                      },
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 6,
                      ),
                      title: Text(
                        'Appointment Status',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black.withOpacity(0.70),
                              // color: C,
                              fontSize: 16,
                            ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          'Click to check you appointment status',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.black45,
                              ),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              );
            return SizedBox.shrink();
          },
        ),

        // TitleView(
        //   title: 'Promo Today',
        // ),
        // Container(
        //   height: MediaQuery.of(context).size.height / 4.82,
        //   margin: EdgeInsets.symmetric(
        //     horizontal: 8,
        //     vertical: 16,
        //   ),
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/banner.png'),
        //       fit: BoxFit.cover,
        //     ),
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        //   alignment: Alignment.center,
        // ),

        DarkTitleView('Whom are you looking for today?'),

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
                onTap: () {
                  Style.navigateBack(
                    context,
                    DoctorPage(
                      Doctor(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/doctor.jpg'),
                      radius: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Text(
                            'Dr. Murari',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 11,
                                      // color: Colors.black54,
                                      color: Style.lightText.withOpacity(0.60),
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
        TitleView(
          title: 'Nearby Hospitals',
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return HospitalCard();
            },
            itemCount: 10,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        TitleView(
          title: 'Nearby Doctors',
        ),

        // for (var i = 0; i < 2; i++) DoctorIntroWidget(),
        320.height,
      ],
    );
  }
}

class DarkTitleView extends StatelessWidget {
  final String value;
  const DarkTitleView(
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context).textTheme.subtitle2!.copyWith(
            fontSize: 16,
            color: Colors.black87,
          ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/doctor.jpg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr.Muhammed Syahid',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Dental Specialist',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: Colors.white70,
                                  ),
                            ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DateTimeCard(
                      haveWhiteBackground: true,
                    ),
                    // ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.48),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.16),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class DateTimeCard extends StatelessWidget {
  final bool haveWhiteBackground;
  const DateTimeCard({
    Key? key,
    this.haveWhiteBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (haveWhiteBackground)
            ? Style.primary.shade400
            : Theme.of(context).primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RowIconWithText(
            icon: Icons.calendar_today,
            value: 'Mon, July 29',
            isWhiteText: haveWhiteBackground,
          ),
          RowIconWithText(
            icon: Icons.access_alarm,
            value: '11:00 ~ 12:10',
            isWhiteText: haveWhiteBackground,
          ),
        ],
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  const HospitalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 88,
      margin: EdgeInsets.all(8),
      child: Card(
        color: Style.nearlyWhite.withOpacity(0.97),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shadowColor: Style.primary.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 12,
                      width: double.infinity,
                      child: Material(
                        color: Colors.white,
                        // color: Style.primary.shade50,
                      ),
                    ),
                    Container(
                      height: 182,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/hospital.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          // bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 164,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // Colors.black,
                        // Colors.black54,
                        // Colors.black26,
                        Style.primary.shade100.withOpacity(0.6),
                        Colors.transparent, Colors.transparent,
                        // Style.primary.shade100.withOpacity(0.1),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  child: Material(
                    color: Style.primary.shade400.withOpacity(0.98),
                    child: ListTile(
                      leading: CircleAvatar(
                        foregroundImage:
                            AssetImage('assets/images/hospitalLogo.jpg'),
                      ),
                      title: Text(
                        'Panimalar Healthcare',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white.withOpacity(0.98),
                              fontSize: 14,
                            ),
                      ),
                      subtitle: Text(
                        'Secondary Text',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 24,
                right: 16,
              ),
              child: Column(
                children: [
                  Text(
                    'Fully Furnished Multi speciality hospital for the people who need it most',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      endIndent: 16,
                      indent: 16,
                    ),
                  ),
                  RowIconWithText(
                    icon: Icons.location_pin,
                    value: '2Kms Away',
                  )
                ],
              ),
            ),

            // ButtonBar(
            //   alignment: MainAxisAlignment.end,
            //   children: [
            //     TextButton(
            //       onPressed: () {
            //         // Perform some action
            //       },
            //       child: const Text('ACTION 1'),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         // Perform some action
            //       },
            //       child: const Text('ACTION 2'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
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
