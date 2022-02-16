import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/Registration/hospital_registration.dart';
import 'package:doctor_booking_application/Widgets/boucing_button.dart';
import 'package:doctor_booking_application/main_page.dart';
import 'package:doctor_booking_application/modals/hospital.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../first_page/first_page.dart';
import '../modals/doctors.dart';

class RegistrationMainPage extends StatefulWidget {
  RegistrationMainPage({Key? key}) : super(key: key);

  @override
  State<RegistrationMainPage> createState() => _RegistrationMainPageState();
}

class _RegistrationMainPageState extends State<RegistrationMainPage> {
  int index = 0;
  final titles = <String>[
    'Hospital Registration Form',
    'Approval Page',
    'Doctor Registration Form',
    'Get Started',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - 32,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16),
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
                        Flexible(
                          child: Stepper(
                            elevation: 0,
                            margin: EdgeInsets.all(0),
                            type: StepperType.horizontal,
                            // physics: BouncingScrollPhysics(),
                            controlsBuilder: (BuildContext context,
                                    ControlsDetails details) =>
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
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Style.darkerText,
                                  ),
                        ),
                      ],
                    ),
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
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
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
                              child: CenterDisplayWidget(index: index),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          // flex: 2,
                          child: ElasticIn(
                            // delay: Duration(milliseconds: 400),
                            duration: Duration(milliseconds: 800),
                            child: Container(
                              height: 48,
                              child: BouncingButton(
                                voidCallback: () async {
                                  if (index < 3) {
                                    setState(() {
                                      index++;
                                    });
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MainPage()),
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
            ),
          ),
        ),
      ),
    );
  }
}

class CenterDisplayWidget extends StatelessWidget {
  final int index;
  const CenterDisplayWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return HospitalformWidget(
          hospital: Hospital(),
        );
      case 1:
        return ApprovalPage();
      case 2:
        return DoctorRegistrationPage(
          doctor: Doctor(slots: []),
        );
      case 3:
        return ApprovalPage();
      default:
        return Container();
    }
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
              'Waiting for approval',
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
