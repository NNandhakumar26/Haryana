import 'package:doctor_booking_application/Components/textfield_without_controller.dart';
import 'package:doctor_booking_application/modals/doctors.dart';
import 'package:flutter/material.dart';

import '../Widgets/textField.dart';

class DoctorRegistrationPage extends StatelessWidget {
  final Doctor? doctor;

  DoctorRegistrationPage({Key? key, this.doctor}) : super(key: key);

  final String? radioButtonValue = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TitleInputFieldWidget(
                  title: 'Full Name',
                  fieldWidget: FullTextField(
                    title: 'First Last Name',
                  ),
                ),
                // Align(
                //   alignment: AlignmentDirectional(-1, 0),
                //   child: TitleInputFieldWidget(
                //     title 'Sex',
                //   ),
                // ),
                // Align(
                //   alignment: AlignmentDirectional(-0.5, 0),
                //   child: Padding(
                //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                //     child: FlutterFlowRadioButton(
                //       options: ['Male', 'Female'],
                //       initialValue: '0',
                //       onChanged: (value) {
                //         // setState(() => radioButtonValue = value);
                //       },
                //       optionHeight: 25,
                //       textStyle: FlutterFlowTheme.bodyText1.override(
                //         fontFamily: 'Roboto',
                //         color: Colors.black,
                //       ),
                //       selectedTextStyle: FlutterFlowTheme.subtitle1,
                //       buttonPosition: RadioButtonPosition.left,
                //       direction: Axis.horizontal,
                //       radioButtonColor: FlutterFlowTheme.secondaryColor,
                //       inactiveRadioButtonColor: Color(0x8A000000),
                //       toggleable: false,
                //       horizontalAlignment: WrapAlignment.start,
                //       verticalAlignment: WrapCrossAlignment.start,
                //     ),
                //   ),
                // ),
                TitleInputFieldWidget(
                  title: 'Date of Birth',
                  fieldWidget: FullTextField(
                    title: 'DD-MM-YY',
                  ),
                ),
                TitleInputFieldWidget(
                  title: 'Age',
                  fieldWidget: FullTextField(
                    inputType: TextInputType.number,
                    title: 'In yrs',
                  ),
                ),

                TitleInputFieldWidget(
                  title: 'Experience',
                  fieldWidget: FullTextField(
                    inputType: TextInputType.number,
                    title: 'In years',
                  ),
                ),

                TitleInputFieldWidget(
                  title: 'Specialist',
                  fieldWidget: FullTextField(
                    title: 'Occupation',
                  ),
                ),

                TitleInputFieldWidget(
                  title: 'Email Address',
                  fieldWidget: FullTextField(
                    title: 'Email',
                  ),
                ),

                TitleInputFieldWidget(
                  title: 'Phone Number',
                  fieldWidget: FullTextField(
                    inputType: TextInputType.number,
                    title: '9876543210',
                  ),
                ),

                TitleInputFieldWidget(
                  title: 'Hospital',
                  fieldWidget: FullTextField(
                    title: 'Hospital Name',
                  ),
                ),
                FieldTitle(
                  text: 'Upload Picture',
                ),

                // UploadButtonWidget(),
                TitleInputFieldWidget(
                  title: 'Time Available',
                  fieldWidget: FullTextField(
                    title: '00:00AM - 00:00PM',
                  ),
                ),
                TitleInputFieldWidget(
                  title: 'OPD Fees',
                  fieldWidget: FullTextField(
                    title: 'In Rupees',
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

class TitleInputFieldWidget extends StatelessWidget {
  final String title;
  final Widget fieldWidget;

  const TitleInputFieldWidget({
    Key? key,
    required this.title,
    required this.fieldWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 4,
            ),
            child: FieldTitle(text: title),
          ),
          fieldWidget,
        ],
      ),
    );
  }
}

class FieldTitle extends StatelessWidget {
  final String text;
  const FieldTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
