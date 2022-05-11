import 'package:doctor_booking_application/Components/textfield_without_controller.dart';
import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/Registration/modern_ui.dart';
import 'package:doctor_booking_application/book_appoinment/available_doctor.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class BookSlotPage extends StatefulWidget {
  BookSlotPage({Key? key}) : super(key: key);

  @override
  State<BookSlotPage> createState() => _BookSlotPageState();
}

class _BookSlotPageState extends State<BookSlotPage> {
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final problemStatementController = TextEditingController();
  bool isMyDetails = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ModernUIWidget(
      titleList: ['Book Slot', 'Payment Page'],
      currentIndex: currentIndex,
      widgetList: [
        Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CheckboxListTile(
                value: isMyDetails,
                onChanged: (value) {
                  if (value ?? false) {
                    nameController.text = 'Nandha Kumar';
                    phoneController.text = '9888888888';
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
                      controller: problemStatementController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            DoctorIntroWidget(
              disableOnTap: true,
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
              child: Text(
                'Your Booking Number is : 5',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Style.darkerText.withOpacity(0.98),
                      fontSize: 18,
                    ),
              ),
            ),
            16.height,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Kathar Wishs You A Quicker Recovery!!!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Style.darkText.withOpacity(0.87),
                      fontSize: 18,
                    ),
              ),
            ),
          ],
        )
      ],
      buttonText: (currentIndex == 0) ? 'Pay Now \u{20B9}150' : 'Download Slip',
      onPressed: () {
        if (currentIndex == 0) {
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
}
