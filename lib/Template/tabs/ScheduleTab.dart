// // import 'package:doctor_booking_application/Components/loading.dart';
// // import 'package:doctor_booking_application/Widgets/titleView.dart';
// // import 'package:doctor_booking_application/database/database_export.dart';
// // import 'package:doctor_booking_application/modals/model_export.dart';
// // import 'package:doctor_booking_application/style.dart';
// // import 'package:flutter/material.dart';

// // enum FilterStatus { Upcoming, Complete, Cancel }

// // List<Map> schedules = [
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. John Doe',
// //     'doctorTitle': 'Dental Checkup',
// //     'reservedDate': 'Monday, Aug 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Upcoming
// //   },
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. Mauldya Imran',
// //     'doctorTitle': 'Skin Checkup',
// //     'reservedDate': 'Monday, Sep 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Upcoming
// //   },
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. Rihanna Garland',
// //     'doctorTitle': 'General Checkup',
// //     'reservedDate': 'Monday, Jul 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Upcoming
// //   },
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. John Doe',
// //     'doctorTitle': 'Dental Checkup',
// //     'reservedDate': 'Monday, Aug 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Upcoming
// //   },
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. Mauldya Imran',
// //     'doctorTitle': 'Skin Checkup',
// //     'reservedDate': 'Monday, Sep 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Upcoming
// //   },
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. Rihanna Garland',
// //     'doctorTitle': 'General Checkup',
// //     'reservedDate': 'Monday, Jul 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Upcoming
// //   },
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. John Doe',
// //     'doctorTitle': 'Something Related to Skin',
// //     'reservedDate': 'Monday, Jul 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Complete
// //   },
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. Sam Smithh',
// //     'doctorTitle': 'Unknown',
// //     'reservedDate': 'Monday, Jul 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Cancel
// //   },
// //   {
// //     'img': 'assets/images/patient.jpg',
// //     'doctorName': 'Mr. Sam Smithh',
// //     'doctorTitle': 'Skin Irritation',
// //     'reservedDate': 'Monday, Jul 29',
// //     'reservedTime': '11:00 - 12:00',
// //     'status': FilterStatus.Cancel
// //   },
// // ];

// // class DoctorAppointmentPage extends StatelessWidget {
// //   DoctorAppointmentPage({Key? key}) : super(key: key);
// //   final FilterStatus status = FilterStatus.Upcoming;

// //   final scrollController = ScrollController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       length: 3,
// //       initialIndex: 0,
// //       child: Container(
// //         height: MediaQuery.of(context).size.height,
// //         width: MediaQuery.of(context).size.width,
// //         child: Column(
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.symmetric(vertical: 16.0),
// //               child: TitleView(
// //                 title: 'Today\'s Schedule',
// //               ),
// //             ),
// //             Container(
// //               width: double.infinity,
// //               height: 40,
// //               padding: EdgeInsets.all(1),
// //               decoration: BoxDecoration(
// //                 color: Style.primary.shade50.withOpacity(0.60),
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               margin: EdgeInsets.symmetric(
// //                 horizontal: 8,
// //                 vertical: 8,
// //               ),
// //               child: TabBar(
// //                 unselectedLabelStyle:
// //                     Theme.of(context).textTheme.bodyText2!.copyWith(
// //                           letterSpacing: 0.60,
// //                         ),
// //                 unselectedLabelColor: Colors.black87,
// //                 labelStyle: Theme.of(context).textTheme.button!.copyWith(
// //                       color: Colors.white,
// //                     ),
// //                 indicatorSize: TabBarIndicatorSize.tab,
// //                 indicator: BoxDecoration(
// //                   color: Theme.of(context).primaryColor,
// //                   borderRadius: BorderRadius.circular(20),
// //                   border: Border.all(
// //                     width: 0,
// //                     color: Colors.transparent,
// //                   ),
// //                 ),
// //                 indicatorColor: Theme.of(context).primaryColor,
// //                 onTap: (value) {},
// //                 tabs: ['Upcoming', 'Ongoing', 'Finished']
// //                     .map(
// //                       (e) => Center(
// //                         child: Text(
// //                           e,
// //                         ),
// //                       ),
// //                     )
// //                     .toList(),
// //               ),
// //             ),
// //             Expanded(
// //               child: StreamBuilder<List<Appointment>>(
// //                 stream: Network.getCurrentAppointmentStream(),
// //                 builder: (builder, snapsot) {
// //                   print(
// //                       'The value is ${snapsot.data} with connection state ${snapsot.connectionState}');

// //                   switch (snapsot.connectionState) {
// //                     case ConnectionState.active:
// //                       List<Appointment> temp = snapsot.data!;
// //                       return tabBarWidget(temp, context);

// //                     default:
// //                       return CustomLoadingDialog();
// //                   }
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget tabBarWidget(List<Appointment> appointment, BuildContext context) {
// //     return TabBarView(
// //       children: [
// //         ...[
// //           AppointmentStatus.Created,
// //           AppointmentStatus.Accepted,
// //           AppointmentStatus.Finished
// //         ].map(
// //           (status) {
// //             List<Appointment> displayList = appointment
// //                 .where((element) => element.status == status)
// //                 .toList();
// //             return ListView.builder(
// //               itemCount: displayList.length,
// //               itemBuilder: (itemBuilder, index) {
// //                 print(displayList[index]);
// //                 switch (status) {
// //                   case AppointmentStatus.Finished:
// //                     return CompleteAppointmentContainer(
// //                       appointment: displayList[index],
// //                       function: () async {
// //                         await showDialog(
// //                           context: context,
// //                           builder: (context) => StatefulBuilder(
// //                             builder: (context, setState) {
// //                               return CustomAlertDialog(
// //                                 context: context,
// //                                 title: 'Finish Booking',
// //                                 columnWidgets: [
// //                                   BillingWidget(
// //                                     displayList[index],
// //                                   ),
// //                                 ],
// //                               );
// //                             },
// //                           ),
// //                         );
// //                       },
// //                     );

// //                   default:
// //                     return AppointmentWidget(
// //                       appointment: displayList[index],
// //                       isLastElement: index + 1 == displayList.length,
// //                     );
// //                 }
// //               },
// //             );
// //           },
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class AppointmentWidget extends StatelessWidget {
// //   const AppointmentWidget({
// //     Key? key,
// //     this.appointment,
// //     required this.isLastElement,
// //     this.widget,
// //   }) : super(key: key);

// //   final bool isLastElement;
// //   // final Map _schedule;
// //   final Appointment? appointment;
// //   final Widget? widget;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Card(
// //         elevation: 3,
// //         shadowColor: Colors.black38,
// //         margin: !isLastElement ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
// //         child: (widget != null)
// //             ? widget
// //             : Padding(
// //                 padding: EdgeInsets.all(15),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.stretch,
// //                   children: [
// //                     // CircleAvatar(
// //                     //   backgroundImage: AssetImage(_schedule['img']),
// //                     // ),
// //                     // SizedBox(
// //                     //   width: 10,
// //                     // ),
// //                     CustomPatientWidget(patientID: appointment!.patientID!),
// //                     // CustomFutureBuilder<Patient>(
// //                     //   futureFunction:
// //                     //       Network.getPatientDetails(appointment.patientID!),
// //                     //   onSuccessWidget: (patient) {
// //                     //     print(patient);
// //                     //     return ListTile(
// //                     //       title: Text(
// //                     //         patient.person!.name,
// //                     //         style: Theme.of(context).textTheme.bodyText2!.copyWith(
// //                     //               color: Style.darkerText,
// //                     //               fontWeight: FontWeight.w600,
// //                     //             ),
// //                     //       ),
// //                     //       subtitle: Padding(
// //                     //         padding: EdgeInsets.symmetric(vertical: 5),
// //                     //         child: Text(
// //                     //           appointment.patientID.toString(),
// //                     //           // _schedule['doctorTitle'],
// //                     //           style: Theme.of(context).textTheme.caption!.copyWith(
// //                     //                 color: Style.lightText,
// //                     //                 fontSize: 12,
// //                     //               ),
// //                     //         ),
// //                     //       ),
// //                     //       trailing: IconButton(
// //                     //         onPressed: () =>
// //                     //             launch('tel:${patient.person!.contact1}'),
// //                     //         icon: Icon(
// //                     //           Icons.phone,
// //                     //           color: Colors.green,
// //                     //         ),
// //                     //       ),
// //                     //     );
// //                     //   },
// //                     // ),

// //                     SizedBox(
// //                       height: 15,
// //                     ),
// //                     ColouredCard(
// //                       doctorID: appointment!.doctorID!,
// //                       slot: appointment!.slot ??
// //                           Slot(
// //                             from: TimeOfDay.now(),
// //                             to: TimeOfDay.now(),
// //                           ),
// //                     ),
// //                     SizedBox(
// //                       height: 15,
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         RowHalfButton(
// //                           isPrimary: false,
// //                           text: 'Cancel',
// //                         ),
// //                         SizedBox(
// //                           width: 20,
// //                         ),
// //                         RowHalfButton(
// //                           isPrimary: true,
// //                           text: 'Reschedule',
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //       ),
// //     );
// //   }
// // }

// // // class AppointmentWidget extends StatelessWidget {
// // //   const AppointmentWidget({
// // //     Key? key,
// // //     required this.isLastElement,
// // //     required Map schedule,
// // //   })  : _schedule = schedule,
// // //         super(key: key);

// // //   final bool isLastElement;
// // //   final Map _schedule;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Card(
// // //       margin: !isLastElement ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
// // //       child: Padding(
// // //         padding: EdgeInsets.all(15),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.stretch,
// // //           children: [
// // //             Row(
// // //               children: [
// // //                 CircleAvatar(
// // //                   backgroundImage: AssetImage(_schedule['img']),
// // //                 ),
// // //                 SizedBox(
// // //                   width: 10,
// // //                 ),
// // //                 Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       _schedule['doctorName'],
// // //                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
// // //                             color: Style.darkerText,
// // //                             fontWeight: FontWeight.w600,
// // //                           ),
// // //                     ),
// // //                     SizedBox(
// // //                       height: 5,
// // //                     ),
// // //                     Text(
// // //                       _schedule['doctorTitle'],
// // //                       style: Theme.of(context).textTheme.caption!.copyWith(
// // //                             color: Style.lightText,
// // //                             fontSize: 12,
// // //                             // fontWeight: FontWeight.w600,
// // //                           ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //             SizedBox(
// // //               height: 15,
// // //             ),
// // //             DateTimeCard(),
// // //             SizedBox(
// // //               height: 15,
// // //             ),
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 RowHalfButton(
// // //                   isPrimary: false,
// // //                   text: 'Cancel',
// // //                 ),
// // //                 SizedBox(
// // //                   width: 20,
// // //                 ),
// // //                 RowHalfButton(
// // //                   isPrimary: true,
// // //                   text: 'Reschedule',
// // //                 ),
// // //               ],
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

import 'package:doctor_booking_application/doctor/doctor_appointment_page.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

// class RowHalfButton extends StatelessWidget {
//   final bool isPrimary;
//   final String text;
//   final VoidCallback? onPressed;

//   const RowHalfButton({
//     Key? key,
//     this.isPrimary = true,
//     this.onPressed,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(
//             padding: EdgeInsets.all(12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//               side: BorderSide(
//                 color: Colors.black45,
//                 width: 0.87,
//               ),
//             ),
//             backgroundColor: (isPrimary)
//                 ? Theme.of(context).primaryColor
//                 : Style.primary.shade50.withOpacity(0.72)),
//         child: Text(
//           text,
//           style: Theme.of(context).textTheme.button!.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: (isPrimary) ? Colors.white : Style.primary.shade700,
//               ),
//         ),
//         onPressed: () {
//           if (onPressed != null) {
//             onPressed!();
//           }
//         },
//       ),
//     );
//   }
// }


// class RowIconWithText extends StatelessWidget {
//   final IconData icon;
//   final String value;
//   final bool isWhiteText;
//   final bool blackText;
//   const RowIconWithText({
//     Key? key,
//     required this.icon,
//     required this.value,
//     this.isWhiteText = false,
//     this.blackText = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: (isWhiteText)
//               ? Colors.white.withOpacity(0.87)
//               : (blackText)
//                   ? Style.darkText
//                   : Theme.of(context).primaryColor,
//           size: 15,
//         ),
//         SizedBox(
//           width: 5,
//         ),
//         Text(
//           value,
//           style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                 fontSize: 12,
//                 // letterSpacing: 0.4,
//                 color: (isWhiteText)
//                     ? Colors.white
//                     : (blackText)
//                         ? Colors.black54
//                         : Theme.of(context).primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//       ],
//     );
//   }
// }
