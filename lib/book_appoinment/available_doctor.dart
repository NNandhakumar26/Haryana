import 'package:doctor_booking_application/Components/company_appbar.dart';
import 'package:doctor_booking_application/Template/tabs/ScheduleTab.dart';
import 'package:doctor_booking_application/book_appoinment/book_appoinment_main.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class AvailableDoctorPage extends StatelessWidget {
  const AvailableDoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 249, 250),
      appBar: PreferredSize(
        child: CompanyAppbar(
          title: 'Available Doctors',
        ),
        preferredSize: Size(double.infinity, 60),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (itemBuilder, index) => DoctorIntroWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorIntroWidget extends StatelessWidget {
  final bool disableOnTap;
  const DoctorIntroWidget({
    Key? key,
    this.disableOnTap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 148),
      onPressed: () {
        if (!disableOnTap) {
          Style.AnimatedNavigation(
            context,
            DoctorPage(),
          );
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 6,
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: Style.primary.shade50,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: Use hero here to the next screeen
              ImageWithChipWidget(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dr. Murari',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Style.primary.shade600,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w600,
                            // fontSize: (isMain) ? 24 : 16,
                          ),
                    ),
                    IconWithText(rating: '4.5'),
                  ],
                ),
              ),

              Divider(
                thickness: 0.24,
                indent: 16,
                endIndent: 16,
                color: Colors.grey.shade400,
              ),
              RowIconWithText(
                icon: Icons.location_pin,
                value: '2Kms Away',
                blackText: true,
              ),
              8.height,
              RowIconWithText(
                icon: Icons.timer,
                value: 'Available Today',
                blackText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
