import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/Registration/hospital_registration.dart';
import 'package:doctor_booking_application/Widgets/boucing_button.dart';
import 'package:doctor_booking_application/Widgets/future_builder.dart';
import 'package:doctor_booking_application/constants.dart';
import 'package:doctor_booking_application/database/cloud_database.dart';
import 'package:doctor_booking_application/database/local_database.dart';
import 'package:doctor_booking_application/main_page.dart';
import 'package:doctor_booking_application/modals/hospital.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../modals/doctors.dart';

class RegistrationMainPage extends StatefulWidget {
  RegistrationMainPage({Key? key}) : super(key: key);

  @override
  State<RegistrationMainPage> createState() => _RegistrationMainPageState();
}

class _RegistrationMainPageState extends State<RegistrationMainPage> {
  int futureIndex = 0;

  Hospital hospital = Hospital();
  Doctor doctor = Doctor();

  final titles = <String>[
    'Hospital Registration Form',
    'Approval Page',
    'Doctor Registration Form',
    'Get Started',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: registrationScreenScaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - 32,
            width: MediaQuery.of(context).size.width,
            child: CustomFutureBuilder<int>(
              futureFunction: Future.value(Local.getRegistrationIndex),
              onSuccessWidget: (indexValue) {
                futureIndex = Local.getRegistrationIndex;
                return Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SteeperWidget(
                        index: futureIndex,
                        titles: titles,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 10,
                              child: CenterWidget(
                                index: futureIndex,
                                hospital: hospital,
                                doctor: doctor,
                              ),
                            ),
                            8.height,
                            Expanded(
                              child: ElasticIn(
                                duration: Duration(milliseconds: 800),
                                child: Container(
                                  height: 48,
                                  child: BouncingButton(
                                    voidCallback: () async {
                                      await onPressed(context, futureIndex);
                                      if (futureIndex < 3) {
                                        // setState(
                                        //   () {
                                        //     index++;
                                        //   },
                                        // );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) => MainPage(
                                              doctorLogin: true,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    isWhiteButton: true,
                                    title: 'Update',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> onPressed(BuildContext context, int index) async {
    switch (index) {
      case 0:
        Style.loadingDialog(context, title: 'Registering Hospital');
        await Network.createHospital(hospital).then(
          (value) async => await Local.setRegistrationIndex(1).then((value) {
            Navigator.pop(context);
            setState(() {
              futureIndex = 1;
            });
          }),
        );
        break;
      case 1:
        print('Entered');
        await Local.setRegistrationIndex(2);
        setState(() {});
        break;
      case 2:
        Style.loadingDialog(context, title: 'Registering Doctor');

        await Network.createDoctor(doctor).then(
          (value) async => await Local.setRegistrationIndex(3).then((value) {
            Navigator.pop(context);
            setState(() {
              futureIndex = 3;
            });
          }),
        );
        break;
      default:
        return null;
    }
  }
}

class CenterWidget extends StatelessWidget {
  const CenterWidget(
      {Key? key,
      required this.index,
      required this.hospital,
      required this.doctor})
      : super(key: key);

  final int index;
  final Hospital hospital;
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: centerDisplayWidget(index: index),
      ),
    );
  }

  Widget centerDisplayWidget({
    Key? key,
    required index,
  }) {
    switch (index) {
      case 0:
        return HospitalRegistrationWidget(hospital: hospital);
      case 1:
        return ApprovalPage();
      case 2:
        return DoctorRegistrationPage(
          doctor: doctor,
        );
      case 3:
        // return CustomSlotBuilderWidget();
        //Display The message from the server
        return ApprovalPage();
      default:
        return Container();
    }
  }
}

class SteeperWidget extends StatelessWidget {
  const SteeperWidget({
    Key? key,
    required this.index,
    required this.titles,
  }) : super(key: key);

  final int index;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 12, right: 16, left: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      //TODO:value notifier heree
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stepper(
              elevation: 0,
              margin: EdgeInsets.all(0),
              type: StepperType.horizontal,
              controlsBuilder:
                  (BuildContext context, ControlsDetails details) =>
                      SizedBox.shrink(),
              steps: [
                for (var i = 0; i < 4; i++)
                  Step(
                    title: Text(''),
                    content: SizedBox.shrink(),
                    state: StepState.disabled,
                    isActive: (i <= index) ? true : false,
                  ),
              ],
            ),
          ),
          Text(
            titles[index],
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Style.darkerText,
                ),
          ),
        ],
      ),
    );
  }
}

class ApprovalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeInDown(
            delay: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 600),
            from: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Approval Staus',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Style.darkerText,
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          FadeInDown(
            delay: Duration(milliseconds: 600),
            duration: Duration(milliseconds: 500),
            from: 50,
            child: Text(
              //TODO:Get the approval status from the database...
              'You\'re approved!',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Style.darkText,
                  ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
