import 'package:doctor_booking_application/Components/alert_dialog.dart';
import 'package:doctor_booking_application/Components/loading.dart';
import 'package:doctor_booking_application/Widgets/future_builder.dart';
import 'package:doctor_booking_application/Widgets/titleView.dart';
import 'package:doctor_booking_application/database/database_export.dart';
import 'package:doctor_booking_application/modals/model_export.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

enum FilterStatus { Upcoming, Complete, Cancel }

class DoctorAppointmentPage extends StatelessWidget {
  DoctorAppointmentPage({
    Key? key,
  }) : super(key: key);
  final FilterStatus status = FilterStatus.Upcoming;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TitleView(
                  title: 'Today\'s Schedule',
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Style.primary.shade50.withOpacity(0.60),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: TabBar(
                  unselectedLabelStyle:
                      Theme.of(context).textTheme.bodyText2!.copyWith(
                            letterSpacing: 0.60,
                          ),
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
                  onTap: (value) {},
                  tabs: ['Upcoming', 'Ongoing', 'Finished']
                      .map(
                        (e) => Center(
                          child: Text(
                            e,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Appointment>>(
                  // stream: Network.getCurrentAppointmentStream(),
                  stream: Network.doctorInstance
                      .doc(Network.tempDoctorId)
                      .collection('Appointments')
                      .doc(dateToString(DateTime.now()))
                      .snapshots()
                      .map(
                        (value) =>
                            (value.data()!['appointments'] as List<dynamic>)
                                .map(
                                  (e) => Appointment.fromMap(e),
                                )
                                .toList(),
                      ),
                  builder: (builder, snapsot) {
                    print(
                        'The value is ${snapsot.data} with connection state ${snapsot.connectionState}');

                    switch (snapsot.connectionState) {
                      case ConnectionState.active:
                        List<Appointment> temp = snapsot.data!;
                        return tabBarWidget(temp, context);

                      default:
                        return CustomLoadingDialog();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabBarWidget(List<Appointment> appointment, BuildContext context) {
    return TabBarView(
      children: [
        ...[
          AppointmentStatus.Created,
          AppointmentStatus.Accepted,
          AppointmentStatus.Finished
        ].map(
          (status) {
            List<Appointment> displayList = appointment
                .where((element) => element.status == status)
                .toList();
            return ListView.builder(
              itemCount: displayList.length,
              itemBuilder: (itemBuilder, index) {
                print(displayList[index]);
                switch (status) {
                  case AppointmentStatus.Finished:
                    return CompleteAppointmentContainer(
                      appointment: displayList[index],
                      function: () async {
                        await showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) {
                              return CustomAlertDialog(
                                context: context,
                                title: 'Finish Booking',
                                columnWidgets: [
                                  // BillingWidget(
                                  //   displayList[index],
                                  // ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );

                  default:
                    return AppointmentWidget(
                      appointment: displayList[index],
                      isLastElement: index + 1 == displayList.length,
                    );
                }
              },
            );
          },
        ),
      ],
    );
  }

  // Widget billingWidgets(BuildContext context) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Table(
  //         defaultColumnWidth: FlexColumnWidth(),
  //         children: [
  //           ...[
  //             ['Consultation Charges', '2500'],
  //             ['CGST', '250'],
  //             ['SGST', '250'],
  //             ['Total', '3000'],
  //           ]
  //               .map(
  //                 (e) => TableRow(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 4.0),
  //                       child: Text(
  //                         '${e[0]}',
  //                         style:
  //                             Theme.of(context).textTheme.subtitle2!.copyWith(
  //                                   color: Colors.black54,
  //                                 ),
  //                       ),
  //                     ),
  //                     Text(
  //                       '  :  ',
  //                       style: Theme.of(context).textTheme.subtitle2!.copyWith(
  //                             color: Colors.black54,
  //                           ),
  //                     ),
  //                     Text(
  //                       e[1],
  //                       textAlign: TextAlign.right,
  //                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
  //                             color: Colors.black87,
  //                             fontWeight: FontWeight.w600,
  //                           ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //               .toList()
  //         ],
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
  //         child: FullTextField(
  //           title: 'Amount Paid',
  //         ),
  //       ),
  //       FullTextField(
  //         title: 'Remarks',
  //         multiLine: 4,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
  //         child: RowHalfButton(
  //           text: 'Finish',
  //           onPressed: () async{
  //             //TODO: Finish the appointment
  //             Style.loadingDialog(context,title: 'Finishing Appointment');
  //             Network.finishAppointment()
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

}

class CompleteAppointmentContainer extends StatelessWidget {
  final VoidCallback function;
  final bool isHalfPage;
  // final Access access;
  final Appointment appointment;
  const CompleteAppointmentContainer({
    Key? key,
    required this.appointment,
    this.isHalfPage = false,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (isHalfPage) ? EdgeInsets.all(0) : EdgeInsets.all(4),
      child: Card(
        margin: (isHalfPage) ? EdgeInsets.all(2) : EdgeInsets.all(8),
        elevation: 2,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: (isHalfPage) ? EdgeInsets.all(10) : EdgeInsets.all(14),
          child: Column(
            children: [
              CustomPatientWidget(
                patientID: appointment.patientID!,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   'Token : ${appointment.patientID}',
                  //   style: Theme.of(context).textTheme.headline6!.copyWith(
                  //         color: Colors.black87,
                  //         fontSize: 12,
                  //       ),
                  // ),
                  Spacer(),
                  RowHalfButton(
                    isPrimary: true,
                    onPressed: () => function(),
                    text: 'Finish Now',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget({
    Key? key,
    required this.appointment,
    required this.isLastElement,
    this.widget,
  }) : super(key: key);

  final bool isLastElement;
  // final Map _schedule;
  final Appointment appointment;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black38,
        margin: !isLastElement ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
        child: (widget != null)
            ? widget
            : Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // CircleAvatar(
                    //   backgroundImage: AssetImage(_schedule['img']),
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    CustomPatientWidget(patientID: appointment.patientID ?? ''),
                    // CustomFutureBuilder<Patient>(
                    //   futureFunction:
                    //       Network.getPatientDetails(appointment.patientID!),
                    //   onSuccessWidget: (patient) {
                    //     print(patient);
                    //     return ListTile(
                    //       title: Text(
                    //         patient.person!.name,
                    //         style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    //               color: Style.darkerText,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //       ),
                    //       subtitle: Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 5),
                    //         child: Text(
                    //           appointment.patientID.toString(),
                    //           // _schedule['doctorTitle'],
                    //           style: Theme.of(context).textTheme.caption!.copyWith(
                    //                 color: Style.lightText,
                    //                 fontSize: 12,
                    //               ),
                    //         ),
                    //       ),
                    //       trailing: IconButton(
                    //         onPressed: () =>
                    //             launch('tel:${patient.person!.contact1}'),
                    //         icon: Icon(
                    //           Icons.phone,
                    //           color: Colors.green,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),
                    // ColouredCard(
                    //   doctorID: appointment!.doctorID!,
                    //   slot: appointment!.slot ??
                    //       Slot(
                    //         from: TimeOfDay.now(),
                    //         to: TimeOfDay.now(),
                    //       ),
                    // ),
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
                        Expanded(
                          child: PopupMenuButton<String>(
                            itemBuilder: (itemBuilder) => ['Finish', 'Payment']
                                .map(
                                  (item) => PopupMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ),
                                )
                                .toList(),
                            child: Container(
                              child: RowHalfButton(
                                isPrimary: true,
                                text: 'Finish',
                                onPressed: () {},
                              ),
                            ),
                            onSelected: (value) async {
                              await onPressed(context, value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> onPressed(BuildContext context, String value) async {
    Style.loadingDialog(context, title: 'Updating Status');

    await Network.updateAppointmentStatus(
            appointment.appointmentID!,
            (value == 'Finish')
                ? AppointmentStatus.Finished
                : AppointmentStatus.Cancelled,
            DateTime.now())
        .then(
      (value) {
        Navigator.pop(context);
      },
    );
  }
}

class CustomPatientWidget extends StatelessWidget {
  final String patientID;
  const CustomPatientWidget({
    Key? key,
    required this.patientID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Patient>(
      futureFunction: Future.value(Patient()),
      onSuccessWidget: (value) => Container(),
      // futureFunction: Network.getPatientDetails(patientID),
      // onSuccessWidget: (patient) => ListTile(
      //   title: Text(
      //     patient.person!.name,
      //     style: Theme.of(context).textTheme.headline6!.copyWith(
      //           color: Colors.black87,
      //           fontSize: 18,
      //         ),
      //   ),
      //   trailing: (patient.person?.contact1 != null)
      //       ? Tooltip(
      //           message: patient.person!.contact1!.toString(),
      //           child: IconButton(
      //             onPressed: () => launch('tel:${patient.person!.contact1!}'),
      //             icon: Icon(
      //               Icons.call,
      //               color: Colors.green,
      //             ),
      //           ),
      //         )
      //       : SizedBox.shrink(),
      //   subtitle: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 6.0),
      //     child: Text(
      //       'Age : ${patient.person!.age}',
      //       style: Theme.of(context).textTheme.caption,
      //     ),
      //   ),
      // ),
    );
  }
}

class RowHalfButton extends StatelessWidget {
  final bool isPrimary;
  final String text;
  final VoidCallback? onPressed;
  final bool isExpanded;
  const RowHalfButton(
      {Key? key,
      this.isPrimary = true,
      required this.text,
      this.onPressed,
      this.isExpanded = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (isExpanded)
        ? Expanded(
            child: button(context),
          )
        : button(context);
  }

  OutlinedButton button(BuildContext context) {
    return OutlinedButton(
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
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
    );
  }
}

class ColouredCard extends StatelessWidget {
  final bool haveWhiteBackground;
  final String doctorID;
  final Slot slot;
  const ColouredCard({
    Key? key,
    required this.doctorID,
    required this.slot,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFutureBuilder<Doctor>(
            onSuccessWidget: (doctor) => Text(
              'Nandha Kumarss',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 16,
                    letterSpacing: 0.4,
                    color: Style.primary.shade700,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            futureFunction: Future.value(Doctor()),
          ),
          6.height,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: RowIconWithText(
                    icon: Icons.calendar_today,
                    value: 'Today',
                    isWhiteText: haveWhiteBackground,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RowIconWithText(
                      alignment: MainAxisAlignment.end,
                      icon: Icons.access_alarm,
                      value:
                          '${Slot.timeToString(slot.from)} - ${Slot.timeToString(slot.to)}',
                      isWhiteText: haveWhiteBackground,
                    ),
                  ),
                ),
              ],
            ),
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
  final MainAxisAlignment alignment;
  const RowIconWithText({
    Key? key,
    required this.icon,
    required this.value,
    this.isWhiteText = false,
    this.blackText = false,
    this.alignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
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
        8.width,
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 12,
                  letterSpacing: 0.4,
                  color: (isWhiteText)
                      ? Colors.white
                      : (blackText)
                          ? Colors.black45
                          : Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
