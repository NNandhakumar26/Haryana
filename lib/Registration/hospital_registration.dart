import 'package:doctor_booking_application/Components/textfield_without_controller.dart';
import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/modals/hospital.dart';
import 'package:flutter/material.dart';

class HospitalformWidget extends StatelessWidget {
//   const HospitalformWidget({Key key}) : super(key: key);

//   @override
//   _HospitalformWidgetState createState() => _HospitalformWidgetState();
// }

// class _HospitalformWidgetState extends State<HospitalformWidget> {
  final Hospital? hospital;

  HospitalformWidget({required this.hospital});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TitleInputFieldWidget(
                  title: 'Hospital Name',
                  fieldWidget: FullTextField(
                    title: 'Enter Hospital Name',
                    onChanged: (value) {
                      hospital!.hospitalName = value;
                    },
                  ),
                ),

                // Align(
                //   alignment: AlignmentDirectional(-1, 0),
                //   child: FieldTitle(
                //     text: 'Hospital Picture  ',
                //   ),
                // ),
                // UploadButtonWidget(),

                TitleInputFieldWidget(
                  title: 'Address',
                  fieldWidget: FullTextField(
                    title: 'House no, Street, Area',
                    onChanged: (String value) {
                      hospital!.hospitalAddress!.streetName = value;
                    },
                  ),
                ),
                TitleInputFieldWidget(
                  title: 'City',
                  fieldWidget: FullTextField(
                    title: 'City Name',
                    onChanged: (String value) {
                      hospital!.hospitalAddress!.city = value;
                    },
                  ),
                ),
                TitleInputFieldWidget(
                  title: 'State',
                  fieldWidget: FullTextField(
                    title: 'State Full Name',
                    onChanged: (String value) {
                      hospital!.hospitalAddress!.state = value;
                    },
                  ),
                ),
                TitleInputFieldWidget(
                  title: 'Pincode',
                  fieldWidget: FullTextField(
                    inputType: TextInputType.number,
                    title: 'In Number',
                    onChanged: (String value) {
                      if (int.tryParse(value) != null) {
                        hospital!.hospitalAddress!.pincode = int.parse(value);
                      }
                    },
                  ),
                ),
                TitleInputFieldWidget(
                  title: 'Hospital Type',
                  fieldWidget: FullTextField(
                    title: 'Type of Hospital',
                    onChanged: (String value) {
                      hospital!.hospitalType = value;
                    },
                  ),
                ),
                TitleInputFieldWidget(
                  title: 'Help Line Number',
                  fieldWidget: FullTextField(
                    inputType: TextInputType.number,
                    title: 'HelpLine',
                    onChanged: (String value) {
                      if (int.tryParse(value) != null) {
                        hospital!.hospitalHelplineNo = int.parse(value);
                      }
                    },
                  ),
                ),
                TitleInputFieldWidget(
                  title: 'Hospital Email',
                  fieldWidget: FullTextField(
                    inputType: TextInputType.emailAddress,
                    title: 'email address',
                    onChanged: (String value) {
                      hospital!.hospitalEmail = value;
                    },
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
