import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

enum FilterStatus { Upcoming, Complete, Cancel }

List<Map> schedules = [
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. John Doe',
    'doctorTitle': 'Dental Checkup',
    'reservedDate': 'Monday, Aug 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. Mauldya Imran',
    'doctorTitle': 'Skin Checkup',
    'reservedDate': 'Monday, Sep 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. Rihanna Garland',
    'doctorTitle': 'General Checkup',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. John Doe',
    'doctorTitle': 'Dental Checkup',
    'reservedDate': 'Monday, Aug 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. Mauldya Imran',
    'doctorTitle': 'Skin Checkup',
    'reservedDate': 'Monday, Sep 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. Rihanna Garland',
    'doctorTitle': 'General Checkup',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. John Doe',
    'doctorTitle': 'Something Related to Skin',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Complete
  },
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. Sam Smithh',
    'doctorTitle': 'Unknown',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
  {
    'img': 'assets/images/patient.jpg',
    'doctorName': 'Mr. Sam Smithh',
    'doctorTitle': 'Skin Irritation',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
];

//include sliver app bar
class SecondPageMain extends StatefulWidget {
  SecondPageMain({Key? key}) : super(key: key);

  @override
  State<SecondPageMain> createState() => _SecondPageMainState();
}

class _SecondPageMainState extends State<SecondPageMain> {
  final FilterStatus status = FilterStatus.Upcoming;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white.withOpacity(0.98),
            ),
            onPressed: () => Navigator.pop(context),
            // onPressed: () => mainPageScaffoldKey.currentState!.openDrawer(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.98),
              ),
              onPressed: () {},
            ),
            // IconButton(
            //   icon: Icon(
            //     Icons.more_vert,
            //     color: Colors.black,
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Style.primary.shade50.withOpacity(0.87),
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(4),
              child: TabBar(
                unselectedLabelStyle: Theme.of(context).textTheme.bodyText2,
                labelColor: Colors.white.withOpacity(0.98),
                unselectedLabelColor: Colors.black87,
                labelStyle: Theme.of(context).textTheme.button!.copyWith(
                      color: Colors.white,
                    ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0,
                    color: Colors.transparent,
                  ),
                ),
                indicatorColor: Theme.of(context).primaryColor,
                onTap: (value) {
                  scrollController.animateTo(
                    double.parse(value.toString()),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                tabs: FilterStatus.values
                    .map(
                      (e) => Tab(
                        text: e.name,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  children: [
                    ...FilterStatus.values
                        .map(
                          (filterValue) => schedules.where(
                            (schedule) {
                              return schedule['status'] == filterValue;
                            },
                          ),
                        )
                        .toList()
                        .map(
                          (value) => ListView(
                            controller: scrollController,
                            children: value
                                .map(
                                  (e) => AppointmentWidget(
                                    isLastElement: false,
                                    schedule: e,
                                  ),
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Temp extends StatelessWidget {

//  SliverAppBar(
//           snap: true,
//           pinned: false,
//           floating: true,
//           leading: IconButton(
//             onPressed: () => mainPageScaffoldKey.currentState!.openDrawer(),
//             icon: Icon(
//               Icons.menu,
//               color: Colors.white.withOpacity(0.98),
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.search,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),

// SliverToBoxAdapter(
//   child: Container(
//     height: 5000,
//   ),
//   // child: Container(
//   //   height: MediaQuery.of(context).size.height,
//   //   padding: const EdgeInsets.all(14.0),
//   //   child: TabBarView(
//   //     children: [
//   //       ...FilterStatus.values
//   //           .map(
//   //             (filterValue) => schedules.where(
//   //               (schedule) {
//   //                 return schedule['status'] == filterValue;
//   //               },
//   //             ),
//   //           )
//   //           .map(
//   //             (filteredSchedules) => ListView.builder(
//   //               itemCount: filteredSchedules.length,
//   //               itemBuilder: (context, index) {
//   //                 var _schedule = filteredSchedules.elementAt(index);
//   //                 bool isLastElement =
//   //                     filteredSchedules.length + 1 == index;
//   //                 return AppointmentWidget(
//   //                   isLastElement: isLastElement,
//   //                   schedule: _schedule,
//   //                 );
//   //               },
//   //             ),
//   //           ),
//   //     ],
//   //   ),
//   // ),
// ),
//   const Temp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         16.height,
//         TitleView(
//           title: 'Today\'s Schedule',
//           subtitle: ' ',
//           onPressed: () {},
//         ),
//         //Include the searchbar
//         Container(
//           width: double.infinity,
//           height: 40,
//           padding: EdgeInsets.all(1),
//           decoration: BoxDecoration(
//             color: Style.primary.shade50.withOpacity(0.87),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           margin: EdgeInsets.symmetric(
//             horizontal: 8,
//             vertical: 8,
//           ),
//           child: TabBar(
//             unselectedLabelStyle: Theme.of(context).textTheme.bodyText2,
//             labelColor: Colors.white.withOpacity(0.98),
//             unselectedLabelColor: Colors.black87,
//             labelStyle: Theme.of(context).textTheme.button!.copyWith(
//                   color: Colors.white,
//                 ),
//             indicatorSize: TabBarIndicatorSize.tab,
//             indicator: BoxDecoration(
//               color: Theme.of(context).primaryColor,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 width: 0,
//                 color: Colors.transparent,
//               ),
//             ),
//             indicatorColor: Theme.of(context).primaryColor,
//             onTap: (value) {
//               // scrollController.animateTo(
//               //   double.parse(value.toString()),
//               //   duration: Duration(milliseconds: 300),
//               //   curve: Curves.easeInOut,
//               // );
//             },
//             tabs: FilterStatus.values
//                 .map(
//                   (e) => Tab(
//                     text: e.name,
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(14.0),
//             child: TabBarView(
//               children: [
//                 ...FilterStatus.values
//                     .map(
//                       (filterValue) => schedules.where(
//                         (schedule) {
//                           return schedule['status'] == filterValue;
//                         },
//                       ),
//                     )
//                     .map(
//                       (filteredSchedules) => ListView.builder(
//                         itemCount: filteredSchedules.length,
//                         itemBuilder: (context, index) {
//                           var _schedule = filteredSchedules.elementAt(index);
//                           bool isLastElement =
//                               filteredSchedules.length + 1 == index;
//                           return AppointmentWidget(
//                             isLastElement: isLastElement,
//                             schedule: _schedule,
//                           );
//                         },
//                       ),
//                     ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget({
    Key? key,
    required this.isLastElement,
    required Map schedule,
  })  : _schedule = schedule,
        super(key: key);

  final bool isLastElement;
  final Map _schedule;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: !isLastElement ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(_schedule['img']),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _schedule['doctorName'],
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Style.darkerText,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _schedule['doctorTitle'],
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Style.lightText,
                            fontSize: 12,
                            // fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            DateTimeCard(),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowHalfButton(
                  isPrimary: false,
                  text: 'Cancel',
                ),
                SizedBox(
                  width: 20,
                ),
                RowHalfButton(
                  isPrimary: true,
                  text: 'Reschedule',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RowHalfButton extends StatelessWidget {
  final bool isPrimary;
  final String text;
  const RowHalfButton({
    Key? key,
    this.isPrimary = true,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: Colors.black45,
                width: 0.87,
              ),
            ),
            backgroundColor: (isPrimary)
                ? Theme.of(context).primaryColor
                : Style.primary.shade50.withOpacity(0.72)),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button!.copyWith(
                fontWeight: FontWeight.w600,
                color: (isPrimary) ? Colors.white : Style.primary.shade700,
              ),
        ),
        onPressed: () {},
      ),
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

class RowIconWithText extends StatelessWidget {
  final IconData icon;
  final String value;
  final bool isWhiteText;
  final bool blackText;
  const RowIconWithText({
    Key? key,
    required this.icon,
    required this.value,
    this.isWhiteText = false,
    this.blackText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: (isWhiteText)
              ? Colors.white.withOpacity(0.87)
              : (blackText)
                  ? Style.darkText
                  : Theme.of(context).primaryColor,
          size: 15,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12,
                // letterSpacing: 0.4,
                color: (isWhiteText)
                    ? Colors.white
                    : (blackText)
                        ? Colors.black54
                        : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
