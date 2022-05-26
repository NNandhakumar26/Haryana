import 'dart:async';

import 'package:doctor_booking_application/Components/textfield_without_controller.dart';
import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/Registration/modern_ui.dart';
import 'package:doctor_booking_application/book_appoinment/available_doctor.dart';
import 'package:doctor_booking_application/database/cloud_database.dart';
import 'package:doctor_booking_application/database/database_export.dart';
import 'package:doctor_booking_application/doctor/doctor_appointment_page.dart';
import 'package:doctor_booking_application/main_page.dart';
import 'package:doctor_booking_application/modals/appointment.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:uuid/uuid.dart';

class BookSlotPage extends StatefulWidget {
  final Appointment? appointment;
  BookSlotPage({
    Key? key,
    this.appointment,
  }) : super(key: key);

  @override
  State<BookSlotPage> createState() => _BookSlotPageState();
}

class _BookSlotPageState extends State<BookSlotPage> {
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final descriptionController = TextEditingController();
  bool isMyDetails = false;

  int currentIndex = (Local.getAppointmentId == null) ? 0 : 1;
  Stream<List<Appointment>>? appointmentStream;
  // StreamController? tempController;
  StreamSubscription<List<Appointment>>? appointmentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Local.setAppointmentId(null);
    //make a check and nullify the value
    startStreamService();
  }

  void startStreamService({bool includeStream = true}) {
    if (Local.getAppointmentId != null) {
      if (includeStream)
        appointmentStream = Network.getPatientAppointmentStream(
          appointment: Local.getAppointmentId!,
        ).asBroadcastStream();
      else
        appointmentStream = Network.getPatientAppointmentStream(
          appointment: Local.getAppointmentId!,
        );
      appointmentController = appointmentStream!.listen(
        (event) {
          for (var item in event) {
            if (item.appointmentID == Local.getAppointmentId!.appointmentID) {
              if (item.status == AppointmentStatus.Finished) {
                Local.setAppointmentId(null);
              }
            }
          }
        },
      );
    }
  }

  //Get the booking details if already booked
  @override
  Widget build(BuildContext context) {
    return ModernUIWidget(
      titleList: ['Book Slot', 'Payment Page'],
      currentIndex: currentIndex,
      widgetList: [
        SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CheckboxListTile(
                  value: isMyDetails,
                  onChanged: (value) {
                    if (value ?? false) {
                      nameController.text = 'Nandha Kumar';
                      phoneController.text = '9585447986';
                    } else {
                      nameController.text = '';
                      phoneController.text = '';
                    }
                    //change this to value listenable builder
                    setState(
                      () {
                        isMyDetails = value ?? true;
                      },
                    );
                  },
                  title: Text(
                    'Fill in my details',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    TitleInputFieldWidget(
                      title: 'Name',
                      fieldWidget: FullTextField(
                        controller: nameController,
                      ),
                    ),
                    TitleInputFieldWidget(
                      title: 'Mobile Number',
                      fieldWidget: FullTextField(
                        controller: phoneController,
                      ),
                    ),
                    TitleInputFieldWidget(
                      title: 'Problem Description',
                      fieldWidget: FullTextField(
                        multiLine: 4,
                        controller: descriptionController,
                      ),
                    ),
                  ],
                ),
              ),
              if (Style.keyboardIsVisible(context)) 164.height,
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // if the appointment id is null, then get back to previous screen
            if (Local.getAppointmentId != null)
              StreamBuilder<List<Appointment>>(
                stream: appointmentStream,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong from our side, Try Again Later',
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Almost Done, We'll get back to you soon"),
                    );
                  }
                  try {
                    List<Appointment> createdAppointments = snapshot.data!
                        .where((element) =>
                            element.status == AppointmentStatus.Created)
                        .toList();

                    int? index = createdAppointments.indexWhere((element) =>
                        element.appointmentID ==
                        Local.getAppointmentId!.appointmentID);

                    print('The index is $index');
                    return (createdAppointments[index].status ==
                            AppointmentStatus.Created)
                        ? createdStatusWidget(context, index, snapshot,
                            createdAppointments.length)
                        : finishedStatusWidget(context);
                  } catch (e) {
                    print(
                        'The error encountered is $e with the response is ${snapshot.data}');
                    return finishedStatusWidget(context);
                  }
                },
              ),
          ],
        ),
      ],
      buttonText: (currentIndex == 0) ? 'Pay Now \u{20B9}150' : 'Download Slip',
      onPressed: () async {
        if (currentIndex == 0) {
          Style.loadingDialog(
            context,
            title: 'Please Wait',
          );
          var uuid = Uuid();
          //TODO: Get teh amount paid from the user
          // TODO: the place picker also has got the uuid.. check with that
          Appointment thisAppointment = widget.appointment!.copyWith(
            patientID: '',
            patientName: nameController.text,
            patientNumber: phoneController.text,
            description: descriptionController.text,
            staus: AppointmentStatus.Created,
            appointmentID: uuid.v4(),
          );
          await Network.createAppointment(
            thisAppointment,
            thisAppointment.actualDateTime!,
          ).then(
            (value) async {
              if (value is Appointment) {
                await Local.setAppointmentId(thisAppointment).then(
                  (value) {
                    startStreamService();
                    Navigator.pop(context);
                  },
                );
              }
            },
          );
          setState(
            () {
              currentIndex = 1;
            },
          );
        } else {
          Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DoctorRegistrationPage(),
          //   ),
          // );
        }
      },
    );
  }

  Column finishedStatusWidget(BuildContext context) {
    Local.setAppointmentId(null);
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Text(
            'Finish',
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: Colors.white.withOpacity(0.98),
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Hope You had a great service with us!!!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Style.darkText.withOpacity(0.87),
                  fontSize: 18,
                ),
          ),
        ),
      ],
    );
  }

  Column createdStatusWidget(BuildContext context, int index,
      AsyncSnapshot<List<Appointment>> snapshot, int listLength) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Katar wishing You A Quicker Recovery!!!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Style.darkText.withOpacity(0.87),
                  fontSize: 18,
                ),
          ),
        ),
        16.height,
        Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              color: Style.primary.shade600,
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DarkTitleView(
                (index == 0) ? 'Get Well Soon!!!' : index.toString(),
              ),
              8.height,
              Text(
                'You are among the queue of length $listLength',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Style.darkText.withOpacity(0.98),
                      fontSize: 18,
                    ),
              ),
              12.height,
              Bounce(
                duration: Duration(milliseconds: 164),
                onPressed: () {},
                // onPressed: () => _launchURL(),
                child: Card(
                  color: Style.primary.shade400,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          8.height,
                          RowIconWithText(
                            icon: Icons.location_pin,
                            value: 'रस्ता देखे',
                            isWhiteText: true,
                          ),
                          8.height,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              12.height,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  'टोकन सिर्फ 1 दिन 1 व्यक्ति के लिए मान्य होगा।',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Style.primary.shade400,
                      ),
                ),
              ),
            ],
          ),
        ),
        16.height,
        // if (_isBannerAdReady)
        //   Container(
        //     height: 80,
        //     width: double.infinity,
        //     child: Align(
        //       alignment: Alignment.topCenter,
        //       child: Container(
        //         width: _bannerAd.size.width.toDouble(),
        //         height: _bannerAd.size.height.toDouble(),
        //         child: AdWidget(ad: _bannerAd),
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    nameController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    if (appointmentController != null) appointmentController!.cancel();
  }
}
