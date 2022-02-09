
// import 'package:doctor_booking_application/Registration/doctor_registration.dart';
// import 'package:flutter/material.dart';

// class HospitalformWidget extends StatelessWidget {
// //   const HospitalformWidget({Key key}) : super(key: key);

// //   @override
// //   _HospitalformWidgetState createState() => _HospitalformWidgetState();
// // }

// // class _HospitalformWidgetState extends State<HospitalformWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
     
//       backgroundColor: Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
//                     child: FieldTitle(
//                       text: 'Hospital Name',
//                     ),
//                   ),
//                 ),
//                 FieldWidget(
//                   labelName: 'Hospital',
//                   hintName: 'Full Name',
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: FieldTitle(
//                     text: 'Hospital Picture  ',
//                   ),
//                 ),
//                 UploadButtonWidget(),
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: FieldTitle(
//                     text: 'Address',
//                   ),
//                 ),
//                 FieldWidget(
//                   labelName: 'Address',
//                   hintName: 'House no, Street, Area',
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: FieldTitle(
//                     text: 'City',
//                   ),
//                 ),
//                 FieldWidget(
//                   labelName: 'City',
//                   hintName: 'City Name',
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: FieldTitle(
//                     text: 'State',
//                   ),
//                 ),
//                 FieldWidget(
//                   labelName: 'State',
//                   hintName: 'State Full Name',
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: FieldTitle(
//                     text: 'Pincode',
//                   ),
//                 ),
//                 FieldIntWidget(
//                   labelName: 'Pin',
//                   hintName: '123456',
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: FieldTitle(
//                     text: 'Hospital Type',
//                   ),
//                 ),
//                 FieldWidget(
//                   labelName: 'Type',
//                   hintName: 'clinic, speciality hospital',
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: FieldTitle(
//                     text: 'HelpLine Number',
//                   ),
//                 ),
//                 FieldIntWidget(
//                   labelName: 'Help Line',
//                   hintName: 'helpline',
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional(-1, 0),
//                   child: FieldTitle(
//                     text: 'Email Address',
//                   ),
//                 ),
//                 FieldWidget(
//                   labelName: 'Hospital Email',
//                   hintName: 'name@email.com',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
