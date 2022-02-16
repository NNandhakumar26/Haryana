import 'package:doctor_booking_application/Template/styles/colors.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

import '../styles/styles.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus { Upcoming, Complete, Cancel }

List<Map> schedules = [
  {
    'img': 'assets/images/doctor.jpg',
    'doctorName': 'Mr. John Doe',
    'doctorTitle': 'Dental Checkup',
    'reservedDate': 'Monday, Aug 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/doctor.jpg',
    'doctorName': 'Mr. Mauldya Imran',
    'doctorTitle': 'Skin Checkup',
    'reservedDate': 'Monday, Sep 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/doctor.jpg',
    'doctorName': 'Mr. Rihanna Garland',
    'doctorTitle': 'General Checkup',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/images/doctor.jpg',
    'doctorName': 'Mr. John Doe',
    'doctorTitle': 'Something Related to Skin',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Complete
  },
  {
    'img': 'assets/images/doctor.jpg',
    'doctorName': 'Mr. Sam Smithh',
    'doctorTitle': 'Unknown',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
  {
    'img': 'assets/images/doctor.jpg',
    'doctorName': 'Mr. Sam Smithh',
    'doctorTitle': 'Skin Irritation',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
];

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status;
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 4,
            ),
            child: Text(
              'Schedule',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (FilterStatus filterStatus in FilterStatus.values)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (filterStatus == FilterStatus.Upcoming) {
                                status = FilterStatus.Upcoming;
                                _alignment = Alignment.centerLeft;
                              } else if (filterStatus ==
                                  FilterStatus.Complete) {
                                status = FilterStatus.Complete;
                                _alignment = Alignment.center;
                              } else if (filterStatus == FilterStatus.Cancel) {
                                status = FilterStatus.Cancel;
                                _alignment = Alignment.centerRight;
                              }
                            });
                          },
                          child: Center(
                            child: Text(
                              filterStatus.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    color: Colors.black26,
                                    letterSpacing: 0.60,
                                  ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              AnimatedAlign(
                duration: Duration(milliseconds: 200),
                alignment: _alignment,
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      status.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSchedules.length,
              itemBuilder: (context, index) {
                var _schedule = filteredSchedules[index];
                bool isLastElement = filteredSchedules.length + 1 == index;
                return AppointmentWidget(
                  isLastElement: isLastElement,
                  schedule: _schedule,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class AppointmentWidget extends StatelessWidget {
  const AppointmentWidget({
    Key? key,
    required this.isLastElement,
    required Map schedule,
  })  : _schedule = schedule,
        super(key: key);

  final bool isLastElement;
  final Map _schedule;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: !isLastElement ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(_schedule['img']),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _schedule['doctorName'],
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Style.darkerText,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _schedule['doctorTitle'],
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Style.lightText,
                            fontSize: 12,
                            // fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            DateTimeCard(),
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
                RowHalfButton(
                  isPrimary: true,
                  text: 'Reschedule',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RowHalfButton extends StatelessWidget {
  final bool isPrimary;
  final String text;
  const RowHalfButton({
    Key? key,
    this.isPrimary = true,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
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
              : Theme.of(context).primaryColor.withOpacity(0.02),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                    (isPrimary) ? Colors.white : Theme.of(context).primaryColor,
              ),
        ),
        onPressed: () {},
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  final bool haveWhiteBackground;
  const DateTimeCard({
    Key? key,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RowIconWithText(
            icon: Icons.calendar_today,
            value: 'Mon, July 29',
            isWhiteText: haveWhiteBackground,
          ),
          RowIconWithText(
            icon: Icons.access_alarm,
            value: '11:00 ~ 12:10',
            isWhiteText: haveWhiteBackground,
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
  const RowIconWithText({
    Key? key,
    required this.icon,
    required this.value,
    this.isWhiteText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: (isWhiteText)
              ? Colors.white.withOpacity(0.87)
              : Theme.of(context).primaryColor,
          size: 15,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12,
                color: (isWhiteText)
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
