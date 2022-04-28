// import 'package:doctor_booking_application/Components/ExpandableContainerMain.dart';
// import 'package:doctor_booking_application/Components/company_appbar.dart';
// import 'package:doctor_booking_application/Registration/doctor_registration.dart';
// import 'package:doctor_booking_application/Widgets/boucing_button.dart';
// import 'package:doctor_booking_application/constants.dart';
// import 'package:doctor_booking_application/main_page.dart';
// import 'package:doctor_booking_application/style.dart';
// import 'package:flutter/material.dart';

// class CustomSlotBuilderWidget extends StatefulWidget {
//   const CustomSlotBuilderWidget({Key? key}) : super(key: key);

//   @override
//   _CustomSlotBuilderWidgetState createState() =>
//       _CustomSlotBuilderWidgetState();
// }

// class _CustomSlotBuilderWidgetState extends State<CustomSlotBuilderWidget> {
//   final appointments = <AvailableAppointments>[];
//   final int averageDuration = 30;

//   final thisSlot = Slot(
//     from: TimeOfDay.now(),
//     to: TimeOfDay.now(),
//   );
//   final slotList = <Slot>[];

//   bool addSlot = false;

//   int steepCount = 0;

//   List<bool> isAvailable = [
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//   ];

//   final daysList = [
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday'
//   ];

//   List<int> get showList {
//     final list = <int>[0, 1, 2, 3, 4, 5, 6];
//     for (var appointment in appointments) {
//       for (int day in appointment.weekDay) {
//         for (int value in list) {
//           if (value == day) {
//             list.remove(value);
//             break;
//           }
//         }
//       }
//     }
//     return list;
//   }

//   void showSnackBar(String message) {
//     ScaffoldMessenger.of(registrationScreenScaffoldKey.currentContext!)
//         .showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   List<int> get selectedDays {
//     var tempList2 = <int>[];
//     for (var i = 0; i < isAvailable.length; i++) {
//       if (isAvailable[i]) {
//         tempList2.add(i);
//       }
//     }
//     return tempList2;
//   }

//   void refreshList() {
//     for (int i = 0; i < isAvailable.length; i++) isAvailable[i] = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         child: CompanyAppbar(title: 'Appointment Builder'),
//         preferredSize: Size(double.infinity, 60),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 if (appointments.isEmpty)
//                   Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.all(4),
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: Colors.black26,
//                         width: 0.60,
//                       ),
//                       color: Colors.transparent,
//                     ),
//                     alignment: Alignment.center,
//                     child: Column(
//                       children: [
//                         Text(
//                           'Appointments are empty',
//                           style: Theme.of(context).textTheme.caption!.copyWith(
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Text(
//                             'Add Appointments to continue',
//                             style: Theme.of(context).textTheme.overline,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ...appointments
//                     .map(
//                       (thisAppointment) => ExpandContainerPage(
//                         title: ListTile(
//                           title: Text(
//                             'Appointment ${appointments.indexOf(thisAppointment) + 1}',
//                             style: Theme.of(context).textTheme.caption,
//                           ),
//                         ),
//                         customWidget: Column(
//                           children: [
//                             ...thisAppointment.slots
//                                 .map(
//                                   (e) => IndividualSlotWidget(
//                                     thisSlot: e,
//                                     index:
//                                         (thisAppointment.slots.indexOf(e) + 1),
//                                     onChanged: (value) {
//                                       e.isEmergencySlot = value;
//                                       setState(() {});
//                                     },
//                                     onRemoved: (value) {
//                                       thisAppointment.slots.remove(e);
//                                       setState(() {});
//                                     },
//                                   ),
//                                 )
//                                 .toList(),
//                             Row(
//                               children: [
//                                 Text('Days'),
//                                 Spacer(),
//                                 TextButton(
//                                   onPressed: () async {
//                                     refreshList();
//                                     await showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (builder) {
//                                         return AlertDialog(
//                                           content: StatefulBuilder(
//                                             builder: (BuildContext context,
//                                                 StateSetter setState) {
//                                               return Column(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   ...showList
//                                                       .map(
//                                                         (e) => CheckboxListTile(
//                                                           value: isAvailable[e],
//                                                           onChanged: (value) {
//                                                             setState(
//                                                               () {
//                                                                 isAvailable[e] =
//                                                                     value ??
//                                                                         false;
//                                                               },
//                                                             );
//                                                           },
//                                                           title: Text(
//                                                             daysList[e],
//                                                             style: Theme.of(
//                                                                     context)
//                                                                 .textTheme
//                                                                 .bodyText1,
//                                                           ),
//                                                         ),
//                                                       )
//                                                       .toList(),
//                                                   24.height,
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () {
//                                                 refreshList();
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Text(
//                                                 'Cancel',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .button,
//                                               ),
//                                             ),
//                                             FloatingActionButton.extended(
//                                               backgroundColor:
//                                                   Style.primary.shade700,
//                                               onPressed: () {
//                                                 thisAppointment.weekDay
//                                                     .addAll(selectedDays);
//                                                 Navigator.pop(context);
//                                               },
//                                               label: Text(
//                                                 'Done',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .button!
//                                                     .copyWith(
//                                                       color: Colors.white
//                                                           .withOpacity(0.98),
//                                                     ),
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ).then(
//                                       (value) => setState(() {}),
//                                     );
//                                   },
//                                   child: Text(
//                                     'Add',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .button!
//                                         .copyWith(),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             ...thisAppointment.weekDay
//                                 .map(
//                                   (e) => ListTile(
//                                     title: Text(
//                                       daysList[e],
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .caption!
//                                           .copyWith(
//                                             fontSize: 16,
//                                             color: Colors.black87,
//                                           ),
//                                     ),
//                                     trailing: IconButton(
//                                       icon: Icon(
//                                         Icons.remove_circle_outline,
//                                         color: Colors.red,
//                                       ),
//                                       onPressed: () {
//                                         thisAppointment.weekDay.remove(e);

//                                         isAvailable
//                                             .map((element) => element = false);

//                                         setState(() {});
//                                       },
//                                     ),
//                                   ),
//                                 )
//                                 .toList(),
//                           ],
//                         ),
//                       ),
//                     )
//                     .toList(),
//                 addSlot
//                     ? Stepper(
//                         currentStep: steepCount,
//                         physics: BouncingScrollPhysics(),
//                         onStepTapped: (value) => setState(
//                           () {
//                             steepCount = value;
//                           },
//                         ),
//                         controlsBuilder: (context, builder) => Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               FloatingActionButton.extended(
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 onPressed: () {
//                                   if (steepCount == 0)
//                                     setState(() => steepCount++);
//                                   else {
//                                     appointments.add(
//                                       AvailableAppointments(
//                                         weekDay: selectedDays,
//                                         slots: slotList,
//                                       ),
//                                     );
//                                     refreshList();
//                                     steepCount = 0;
//                                     addSlot = false;
//                                     setState(() {});
//                                   }
//                                 },
//                                 label: Text(
//                                   (steepCount == 0) ? 'Next' : 'Finish',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .button!
//                                       .copyWith(
//                                         color: Colors.white.withOpacity(0.97),
//                                       ),
//                                 ),
//                                 backgroundColor: Style.primary.shade600,
//                               ),
//                             ],
//                           ),
//                         ),
//                         steps: [
//                           Step(
//                             title: Text(
//                               'Select Days',
//                               style: Theme.of(context).textTheme.bodyText1,
//                             ),
//                             content: Column(
//                               children: [
//                                 ...showList
//                                     .map(
//                                       (e) => CheckboxListTile(
//                                         value: isAvailable[e],
//                                         onChanged: (value) {
//                                           setState(
//                                             () {
//                                               isAvailable[e] = value ?? false;
//                                             },
//                                           );
//                                         },
//                                         title: Text(
//                                           daysList[e],
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1,
//                                         ),
//                                       ),
//                                     )
//                                     .toList(),
//                               ],
//                             ),
//                           ),
//                           Step(
//                             title: Text('Select Slots'),
//                             content: Column(
//                               children: [
//                                 ...slotList
//                                     .map(
//                                       (Slot e) => IndividualSlotWidget(
//                                         thisSlot: e,
//                                         index: (slotList.indexOf(e) + 1),
//                                         onChanged: (value) {
//                                           e.isEmergencySlot = value;
//                                           setState(() {});
//                                         },
//                                         onRemoved: (value) {
//                                           slotList.remove(e);
//                                           setState(() {});
//                                         },
//                                       ),
//                                     )
//                                     .toList(),
//                                 OutlinedButton(
//                                   onPressed: () async {
//                                     await showDialog(
//                                       context: context,
//                                       builder: (builder) => SlotBuilderWidget(
//                                         thisSlot: Slot(
//                                           from: TimeOfDay.now(),
//                                           to: TimeOfDay.now(),
//                                         ),
//                                       ),
//                                     ).then(
//                                       (value) {
//                                         if (value != null) {
//                                           slotList.add(value);
//                                           setState(() {});
//                                         }
//                                       },
//                                     );
//                                   },
//                                   child: Text(
//                                     'Add Slot',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1!
//                                         .copyWith(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.normal,
//                                         ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       )
//                     : (showList.isNotEmpty)
//                         ? OutlinedButton(
//                             onPressed: () => setState(
//                               () {
//                                 addSlot = true;
//                               },
//                             ),
//                             child: Text(
//                               'Add New Slot',
//                               style: Theme.of(context).textTheme.button,
//                             ),
//                           )
//                         : SizedBox.shrink(),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: BouncingButton(
//           voidCallback: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (builder) => MainPage(),
//               ),
//             );
//           },
//           title: 'Continue',
//         ),
//       ),
//     );
//   }
// }
