// import 'package:flutter/material.dart';

// class SlotBookingWidget extends StatefulWidget {
//   @override
//   State<SlotBookingWidget> createState() => _SlotBookingWidgetState();
// }

// class _SlotBookingWidgetState extends State<SlotBookingWidget> {
//   DateTime _focusedDay = DateTime.now();
//   CalendarFormat _calendarFormat = CalendarFormat.month;

//   DateTime? _selectedDay;
//   Appointment appointment = Appointment(
//     id: '1',
//     dateList: DateTime.now(),
//     // dateList: [
//     //   DateTime(2022, 2, 1),
//     //   DateTime(2022, 2, 2),
//     //   DateTime(2022, 2, 3),
//     //   DateTime(2022, 2, 4),
//     //   DateTime(2022, 2, 5),
//     //   DateTime(2022, 2, 6),
//     //   DateTime(2022, 2, 7),
//     //   DateTime(2022, 2, 8),
//     //   DateTime(2022, 2, 9),
//     //   DateTime(2022, 2, 10),
//     //   DateTime(2022, 2, 11),
//     //   DateTime(2022, 2, 12),
//     //   DateTime(2022, 2, 13),
//     //   DateTime(2022, 2, 14),
//     //   DateTime(2022, 2, 15),
//     //   DateTime(2022, 2, 16),
//     //   DateTime(2022, 2, 17),
//     //   DateTime(2022, 2, 18),
//     //   DateTime(2022, 2, 19),
//     //   DateTime(2022, 2, 20),
//     //   DateTime(2022, 2, 21),
//     //   DateTime(2022, 2, 22),
//     //   DateTime(2022, 2, 23),
//     //   DateTime(2022, 2, 24),
//     //   DateTime(2022, 2, 25),
//     //   DateTime(2022, 2, 26),
//     //   DateTime(2022, 2, 27),
//     //   DateTime(2022, 2, 28),
//     // ],

//     appointmentList: [
//       AppointmentStatus(
//         startTime: TimeOfDay(hour: 9, minute: 00),
//         endTime: TimeOfDay(hour: 9, minute: 30),
//         isAvailable: true,
//       ),
//       AppointmentStatus(
//         startTime: TimeOfDay(hour: 16, minute: 00),
//         endTime: TimeOfDay(hour: 16, minute: 30),
//         isAvailable: true,
//       ),
//       AppointmentStatus(
//         startTime: TimeOfDay(hour: 20, minute: 00),
//         endTime: TimeOfDay(hour: 20, minute: 30),
//         isAvailable: true,
//       ),
//       AppointmentStatus(
//         startTime: TimeOfDay(hour: 13, minute: 00),
//         endTime: TimeOfDay(hour: 13, minute: 30),
//         isAvailable: true,
//       ),
//     ],
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         child: CompanyAppbar(title: 'Select Your Slot'),
//         preferredSize: Size(double.infinity, 60),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Theme(
//                 data: ThemeData(
//                   primaryColor: Colors.red,
//                 ),
//                 child: TableCalendar<String>(
//                   firstDay: DateTime.utc(2010, 10, 16),
//                   lastDay: DateTime.utc(2030, 3, 14),
//                   calendarFormat: CalendarFormat.week,
//                   focusedDay: _focusedDay,
//                   selectedDayPredicate: (day) {
//                     return isSameDay(_selectedDay, day);
//                   },
//                   // eventLoader: (value) {
//                   //   print(value);
//                   //   return ['Event 1'];
//                   // },
//                   onDaySelected: (selectedDay, focusedDay) {
//                     if (!isSameDay(_selectedDay, selectedDay)) {
//                       setState(() {
//                         _selectedDay = selectedDay;
//                         _focusedDay = focusedDay;
//                       });
//                     }
//                   },
//                   onFormatChanged: (format) {
//                     if (_calendarFormat != format) {
//                       setState(() {
//                         _calendarFormat = format;
//                       });
//                     }
//                   },
//                   onPageChanged: (focusedDay) {
//                     // No need to call `setState()` here
//                     _focusedDay = focusedDay;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ...Session.values
//                   .map(
//                     (e) => Column(
//                       children: [
//                         TitleText(
//                           title: e.toString().split('.')[1].toUpperCase(),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Wrap(
//                             spacing: 12,
//                             runSpacing: 12,
//                             children: appointment
//                                 .getAppointmentList(e)
//                                 .map(
//                                   (value) => InkWell(
//                                     onTap: () {
//                                       manageAppointments(value);
//                                     },
//                                     child: Chip(
//                                       elevation: (value.isAvailable) ? 4 : 2,
//                                       shadowColor: Colors.black45,
//                                       padding: EdgeInsets.all(8),
//                                       backgroundColor: value.isAvailable
//                                           ? Style.primary.shade50
//                                           : Colors.green,
//                                       label: Text(
//                                         value.startTime.format(
//                                           context,
//                                         ),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .caption!
//                                             .copyWith(
//                                               fontSize: 13,
//                                               letterSpacing: 0.4,
//                                               color: value.isAvailable
//                                                   ? Style.darkText
//                                                   : Colors.white,
//                                             ),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                                 .toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                   .toList(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(24),
//         child: BouncingButton(
//           voidCallback: () {
//             Style.AnimatedNavigation(
//               context,
//               AppointmentPatientDetailsScreen(),
//             );
//           },
//           title: 'Next',
//         ),
//       ),
//     );
//   }

//   void manageAppointments(AppointmentStatus appointmentStatus) {
//     appointment.appointmentList.forEach(
//       (element) {
//         if (element == appointmentStatus) {
//           element.isAvailable = false;
//         } else
//           element.isAvailable = true;
//       },
//     );
//     setState(() {});
//   }
// }

// enum Session { morning, afternoon, evening }

// class Appointment {
//   String id;
//   //Should we include the appropriate doctor ID
//   List<AppointmentStatus> appointmentList;
//   DateTime dateList;

//   Appointment({
//     required this.id,
//     required this.appointmentList,
//     required this.dateList,
//   });

//   List<AppointmentStatus> getAppointmentList(Session session) {
//     switch (session) {
//       case Session.morning:
//         return appointmentList.where((appointment) {
//           return appointment.startTime.hour > 6 &&
//               appointment.endTime.hour < 12;
//         }).toList();
//       case Session.afternoon:
//         return appointmentList.where((appointment) {
//           return appointment.startTime.hour > 12 &&
//               appointment.endTime.hour < 18;
//         }).toList();
//       case Session.evening:
//         return appointmentList.where((appointment) {
//           return appointment.startTime.hour > 18 &&
//               appointment.endTime.hour < 24;
//         }).toList();
//       default:
//         return [];
//     }
//   }
// }

// class AppointmentStatus {
//   TimeOfDay startTime;
//   TimeOfDay endTime;
//   bool isEmergencySlot;
//   bool isAvailable;

//   AppointmentStatus({
//     required this.startTime,
//     required this.endTime,
//     this.isEmergencySlot = false,
//     this.isAvailable = false,
//   });

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is AppointmentStatus &&
//         other.startTime == startTime &&
//         other.endTime == endTime &&
//         other.isEmergencySlot == isEmergencySlot &&
//         other.isAvailable == isAvailable;
//   }

//   @override
//   int get hashCode {
//     return startTime.hashCode ^
//         endTime.hashCode ^
//         isEmergencySlot.hashCode ^
//         isAvailable.hashCode;
//   }
// }

// class AppointmentPatientDetailsScreen extends StatefulWidget {
//   const AppointmentPatientDetailsScreen({Key? key}) : super(key: key);

//   @override
//   State<AppointmentPatientDetailsScreen> createState() =>
//       _AppointmentPatientDetailsScreenState();
// }

// class _AppointmentPatientDetailsScreenState
//     extends State<AppointmentPatientDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool isMyDetails = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         child: CompanyAppbar(
//           title: 'Patient Details Confirmation',
//         ),
//         preferredSize: Size(double.infinity, 60),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             CheckboxListTile(
//               value: isMyDetails,
//               onChanged: (value) {
//                 setState(
//                   () {
//                     isMyDetails = value ?? false;
//                   },
//                 );
//               },
//               title: Text(
//                 'Checkup For Myself',
//                 style: Theme.of(context).textTheme.headline6!.copyWith(
//                       fontSize: 16,
//                       color: Style.darkText,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
