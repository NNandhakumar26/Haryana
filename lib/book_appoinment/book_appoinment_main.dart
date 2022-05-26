import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:doctor_booking_application/Widgets/boucing_button.dart';
import 'package:doctor_booking_application/Widgets/future_builder.dart';
import 'package:doctor_booking_application/Widgets/search_widget.dart';
import 'package:doctor_booking_application/book_appoinment/available_doctor.dart';
import 'package:doctor_booking_application/book_appoinment/book_slot.dart';
import 'package:doctor_booking_application/database/cloud_database.dart';
import 'package:doctor_booking_application/first_page/first_page.dart';
import 'package:doctor_booking_application/modals/model_export.dart';
import 'package:flutter/material.dart';
import '../style.dart';
import 'package:flutter_bounce/flutter_bounce.dart' as bbounce;

class BookAppoinmentPage extends StatefulWidget {
  @override
  State<BookAppoinmentPage> createState() => _BookAppoinmentPageState();
}

class _BookAppoinmentPageState extends State<BookAppoinmentPage> {
  final searchController = TextEditingController();

  List<String> listOfServices = <String>[];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomFutureBuilder<List<String>>(
        futureFunction: Network.getAllSpecializations(),
        loadingText: 'Downloading Data',
        onSuccessWidget: (networkList) {
          listOfServices = networkList;

          List<String> displayList = listOfServices
              .where(
                (element) => element.toLowerCase().contains(
                      searchController.text.toLowerCase(),
                    ),
              )
              .toList();
          return SearchDisplayWidget(
            title: 'Search Specialization',
            setState: () {
              setState(() {});
            },
            searchController: searchController,
            displayList: displayList
                .map(
                  (e) => ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    title: Text(
                      e,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Style.darkText.withOpacity(0.87),
                          ),
                    ),
                    onTap: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      Style.navigateBack(
                        context,
                        AvailableDoctorPage(
                          specialization: e,
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );

    // return Scaffold(
    //   appBar: PreferredSize(
    //     child: CompanyAppbar(title: 'Choose Specialization'),
    //     preferredSize: Size(double.infinity, 60),
    //   ),
    //   body: Column(
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.all(4),
    //         child: FullTextField(
    //           title: 'Search The Specialization',
    //           icon: Icons.search,
    //           onChanged: (value) {
    //             setState(
    //               () {
    //                 searchText = value;
    //               },
    //             );
    //           },
    //         ),
    //       ),
    //       Expanded(
    //         child: SingleChildScrollView(
    //           child: Column(
    //             children: listOfServices
    //                 .where((service) => service
    //                     .toLowerCase()
    //                     .contains(searchText.toLowerCase()))
    //                 .map(
    //                   (element) => Column(
    //                     children: [
    //                       ListTile(
    //                         title: Text(
    //                           element,
    //                           style: Theme.of(context)
    //                               .textTheme
    //                               .subtitle2!
    //                               .copyWith(
    //                                 fontWeight: FontWeight.w600,
    //                                 color: Style.darkText.withOpacity(0.87),
    //                               ),
    //                         ),
    //                         onTap: () {
    //                           searchText = '';
    //                           FocusManager.instance.primaryFocus!.unfocus();
    //                           Style.navigateBack(
    //                             context,
    //                             AvailableDoctorPage(),
    //                           );
    //                         },
    //                       ),
    //                       Divider(
    //                         thickness: 0.24,
    //                         indent: 16,
    //                         endIndent: 16,
    //                         color: Colors.grey.shade400,
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //                 .toList(),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

class DoctorPage extends StatelessWidget {
  final Doctor doctor;
  DoctorPage(this.doctor, {Key? key}) : super(key: key);

  String stringToDate(String value) {
    switch (value) {
      case 'Tomorrow':
        return DateTime.now().add(Duration(days: 1)).toString().split(' ')[0];
      case 'Day After':
        return DateTime.now().add(Duration(days: 2)).toString().split(' ')[0];
      default:
        return DateTime.now().toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: FadeInUp(
        delay: Duration(milliseconds: 200),
        duration: Duration(milliseconds: 600),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Style.primary.shade100,
              width: 0.24,
            ),
            borderRadius: BorderRadius.circular(48),
            color: Style.primary.shade800,
            boxShadow: [
              BoxShadow(
                color: Style.primary.shade400.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: -4,
                offset: Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Waiting Number : ',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Colors.white.withOpacity(0.72),
                          letterSpacing: 0.8,
                        ),
                    children: [
                      TextSpan(
                        text: '5',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white.withOpacity(0.98),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              bbounce.Bounce(
                duration: Duration(milliseconds: 350),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                ['Today', 'Tomorrow', 'Day after Tomorrow']
                                    .map(
                                      (e) => ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          // Style.loadingDialog(context);
                                          Style.navigateBack<void>(
                                            context,
                                            BookSlotPage(
                                              appointment: Appointment(
                                                doctorID: doctor.doctorID,
                                                actualDateTime: DateTime.parse(
                                                  stringToDate(e),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        title: Text(e),
                                        subtitle: Text(
                                          stringToDate(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),
                  child: Text(
                    'Book Slot',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Style.primary.shade600,
                        ),
                  ),
                  // child: OutlinedButton(
                  //   style: OutlinedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  //   ),
                  //   onPressed: () async {
                  //     // showDialog(
                  //     //   context: context,
                  //     //   builder: (context) {
                  //     //     return Dialog(
                  //     //       child: Padding(
                  //     //         padding: const EdgeInsets.all(8.0),
                  //     //         child: Column(
                  //     //           mainAxisSize: MainAxisSize.min,
                  //     //           children: [
                  //     //             'Today',
                  //     //             'Tomorrow',
                  //     //             'Day after Tomorrow'
                  //     //           ]
                  //     //               .map(
                  //     //                 (e) => ListTile(
                  //     //                   onTap: () {
                  //     //                     Navigator.pop(context);
                  //     //                     // Style.loadingDialog(context);
                  //     //                     Style.navigateBack<void>(
                  //     //                       context,
                  //     //                       BookSlotPage(
                  //     //                         appointment: Appointment(
                  //     //                           doctorID: doctor.doctorID,
                  //     //                           actualDateTime: DateTime.parse(
                  //     //                             stringToDate(e),
                  //     //                           ),
                  //     //                         ),
                  //     //                       ),
                  //     //                     );
                  //     //                   },
                  //     //                   title: Text(e),
                  //     //                   subtitle: Text(
                  //     //                     stringToDate(e),
                  //     //                   ),
                  //     //                 ),
                  //     //               )
                  //     //               .toList(),
                  //     //         ),
                  //     //       ),
                  //     //     );
                  //     //   },
                  //     // );
                  //   },
                  //   child: Text(
                  //     'Book Slot',
                  //     style: Theme.of(context).textTheme.button!.copyWith(
                  //           color: Style.primary.shade600,
                  //         ),
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: false,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                children: [
                  Image.asset(
                    'assets/images/background_doctor_image.jpg',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Style.primary.shade800,
                      gradient: LinearGradient(
                        colors: [
                          Style.primary.shade900,
                          Style.primary.shade900.withOpacity(0.60),
                          Style.primary.shade900.withOpacity(0.32),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  )
                ],
              ),
            ),
            expandedHeight: 230,
            backgroundColor: Style.primary.shade900,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              tooltip: 'Menu',
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.comment),
                tooltip: 'Comment Icon',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.settings),
                tooltip: 'Setting Icon',
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Style.primary.shade700,
                        // borderRadius: BorderRadius.circular(40),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(2),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/doctor.jpg'),
                      ),
                    ),
                    8.width,
                    CustomChip(
                      text: 'Highly Rated',
                    ),
                  ],
                ),
                InfoContainer(
                  title: doctor.person?.name ?? '',
                  rating: '4.5',
                  isMain: true,
                  subtitle1: doctor.person?.address?.streetName ?? '',
                  subtitle2:
                      ' ${doctor.person?.address?.city} , ${doctor.person?.address?.state}',
                ),
                8.height,
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TabBar(
                          labelStyle:
                              Theme.of(context).textTheme.subtitle2!.copyWith(),
                          indicatorColor: Style.primary.shade600,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 4),
                          indicatorWeight: 1.64,
                          labelPadding: EdgeInsets.all(0),
                          labelColor: Colors.black87,
                          unselectedLabelStyle:
                              Theme.of(context).textTheme.caption,
                          unselectedLabelColor: Colors.black45,
                          tabs: [
                            ...['Today', 'Tomorrow', 'Day After']
                                .map(
                                  (e) => Tab(
                                    icon: Text(e),
                                    text: stringToDate(e),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 80,
                        child: TabBarView(
                          children: [
                            StreamBuilder<List<Appointment>>(
                              stream: Network.doctorInstance
                                  .doc(doctor.doctorID)
                                  .collection('Appointments')
                                  .doc(dateToString(DateTime.now()))
                                  .snapshots()
                                  .map(
                                (event) {
                                  print('snapshot event is ${event.data()!}');
                                  return (event.data()!['appointments']
                                          as List<dynamic>)
                                      .map(
                                        (e) {
                                          print(
                                              'Entered into appointment with a value of $e');
                                          return Appointment.fromMap(e);
                                        },
                                      )
                                      .toList()
                                      .where(
                                        (element) =>
                                            element.status ==
                                            AppointmentStatus.Created,
                                      )
                                      .toList();
                                },
                              ),
                              builder: (context, snapshot) {
                                print(
                                    'The snapshot data is ${snapshot.data.runtimeType} and the connection state is ${snapshot.connectionState} with data ${snapshot.data}');
                                if ((snapshot.connectionState ==
                                        ConnectionState.waiting) ||
                                    (snapshot.connectionState ==
                                        ConnectionState.active)) {
                                  if (snapshot.hasData) {
                                    List displayList =
                                        snapshot.data!.reversed.toList();

                                    return SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Column(
                                        children: displayList
                                            .map(
                                              (e) => WaitingPatientContainer(
                                                i: (snapshot.data!.indexOf(e) +
                                                    1),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    );
                                  } else
                                    return Center(
                                      child: Text('Something Went Wrong'),
                                    );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            StreamBuilder<List<Appointment>>(
                              stream: Network.doctorInstance
                                  .doc(doctor.doctorID)
                                  .collection('Appointments')
                                  .doc(dateToString(
                                      DateTime.now().add(Duration(days: 1))))
                                  .snapshots()
                                  .map(
                                    (event) => (event.data()!['appointments']
                                            as List<dynamic>)
                                        .map((e) => Appointment.fromMap(e))
                                        .toList(),
                                  ),
                              builder: (context, snapshot) {
                                print(
                                    'The snapshot data is ${snapshot.data.runtimeType} and the connection state is ${snapshot.connectionState}');
                                if ((snapshot.connectionState ==
                                        ConnectionState.waiting) ||
                                    (snapshot.connectionState ==
                                        ConnectionState.active)) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return WaitingPatientContainer(
                                          i: index,
                                        );
                                      },
                                    );
                                  } else
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            StreamBuilder<List<Appointment>>(
                              stream: Network.doctorInstance
                                  .doc(doctor.doctorID)
                                  .collection('Appointments')
                                  .doc(dateToString(
                                      DateTime.now().add(Duration(days: 2))))
                                  .snapshots()
                                  .map(
                                    (event) => (event.data()!['appointments']
                                            as List<dynamic>)
                                        .map((e) => Appointment.fromMap(e))
                                        .toList(),
                                  ),
                              builder: (context, snapshot) {
                                print(
                                    'The snapshot data is ${snapshot.data.runtimeType} and the connection state is ${snapshot.connectionState}');
                                if ((snapshot.connectionState ==
                                        ConnectionState.waiting) ||
                                    (snapshot.connectionState ==
                                        ConnectionState.active)) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return WaitingPatientContainer(
                                          i: index,
                                        );
                                      },
                                    );
                                  } else
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget getWaitingList(DateTime date) {
  //   // stream builder to get the stream of current apponintments
  //   return StreamBuilder<List<Appointment>>(
  //     stream: Network.getDoctorAppointments(doctor.doctorID!, date)
  //         .asBroadcastStream(),
  //     builder: (context, snapshot) {
  //       print('The snapshot data is ${snapshot.data.runtimeType}');
  //       if (snapshot.connectionState == ConnectionState.active) {
  //         return ListView.builder(
  //           itemCount: snapshot.data!.length,
  //           itemBuilder: (context, index) {
  //             return WaitingPatientContainer(
  //               i: index,
  //             );
  //           },
  //         );
  //       } else {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );

  //   // return CustomFutureBuilder<List<Appointment>>(
  //   //   onSuccessWidget: (appointmentList) {
  //   //     return ListView.builder(
  //   //       itemBuilder: (itemBuilder, index) {
  //   //         return WaitingPatientContainer(i: index);
  //   //       },
  //   //       itemCount: appointmentList.length,
  //   //     );
  //   //   },
  //   //   futureFunction: Network.getDoctorAppointments(doctor.doctorID!, date),
  //   // );
  // }

}

class WaitingPatientContainer extends StatelessWidget {
  const WaitingPatientContainer({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: Style.primary.shade400,
          child: Text(
            i.toString(),
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white.withOpacity(0.98),
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        title: Text(
          'Random Name',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.black87,
                fontSize: 16,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            'Might Delay',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.black26,
                ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Est. Time',
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.black45,
                  ),
            ),
            Text(
              '4:00 PM',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Style.primary.shade600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWithChipWidget extends StatelessWidget {
  final String imageUrl;
  final String chipText;
  const ImageWithChipWidget({
    Key? key,
    this.imageUrl = 'assets/images/doctor.jpg',
    required this.chipText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 32,
        foregroundImage: AssetImage(imageUrl),
      ),
      minLeadingWidth: 0,
      title: Align(
        alignment: Alignment.centerLeft,
        child: CustomChip(
          text: chipText,
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String text;
  const CustomChip({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Style.primary.shade50.withOpacity(0.48),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.transparent,
          width: 0.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 12),
      label: Badge(
        elevation: 0,
        borderSide: BorderSide.none,
        badgeColor: Colors.green.shade400,
        alignment: Alignment.centerRight,
        position: BadgePosition.bottomStart(
          bottom: 5.8,
        ),
        shape: BadgeShape.circle,
        padding: EdgeInsets.all(3.2),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Style.darkerText.withOpacity(0.72),
                ),
          ),
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String title;
  final String? subtitle1;
  final String? subtitle2;
  final String? rating;
  final bool isMain;

  const InfoContainer({
    Key? key,
    required this.title,
    this.subtitle1,
    this.subtitle2,
    this.rating,
    this.isMain = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textScaleFactor: 1.24,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Style.primary.shade900,
                        letterSpacing: 0.8,
                        // fontSize: (isMain) ? 24 : 16,
                      ),
                ),
                if (subtitle1 != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.height,
                        Text(
                          subtitle1 ??
                              'No:52, Sannathy Street, Thirupadiripuliyur.',
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                        ),
                        4.height,
                        Text(
                          subtitle2 ?? 'Cuddalore, Tamilnadu - 607 002.',
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: IconWithText(rating: rating),
          )
        ],
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final String? rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow.shade700,
        ),
        4.width,
        Text(
          rating ?? '4.5',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        4.width,
      ],
    );
  }
}
