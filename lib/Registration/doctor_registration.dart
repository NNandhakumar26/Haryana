import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:doctor_booking_application/Components/image_picker.dart';
import 'package:doctor_booking_application/Components/textfield_without_controller.dart';
import 'package:doctor_booking_application/modals/doctors.dart';

import '../style.dart';

class DoctorRegistrationPage extends StatelessWidget {
  final Doctor? doctor;

  DoctorRegistrationPage({Key? key, this.doctor}) : super(key: key);

  final Slot slots = Slot(from: TimeOfDay.now(), to: TimeOfDay.now());
  final String? radioButtonValue = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _image = ValueNotifier<File?>(null);
  final ValueNotifier<String> gender = ValueNotifier<String>('');
  final ValueNotifier<Slot> currentSlot =
      ValueNotifier(Slot(from: TimeOfDay.now(), to: TimeOfDay.now()));
  final slotList = ValueNotifier(<Slot>[]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ValueListenableBuilder(
                  valueListenable: _image,
                  builder: (context, value, child) {
                    return Badge(
                      position: BadgePosition.bottomEnd(
                        end: 2,
                      ),
                      toAnimate: false,
                      badgeColor: Theme.of(context).primaryColor,
                      badgeContent: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.all(4),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: (_image.value == null)
                              ? EdgeInsets.all(24)
                              : EdgeInsets.all(0),
                        ),
                        child: (_image.value == null)
                            ? Icon(
                                Icons.person_rounded,
                                size: 50,
                                color: Colors.white70,
                              )
                            : CircleAvatar(
                                radius: 50,
                                foregroundImage: FileImage(_image.value!),
                              ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (builder) => GetImageWidget(),
                          ).then(
                            (value) {
                              if (value != null) {
                                _image.value = value;
                              }
                            },
                          );
                        },
                      ),
                    );
                  }),
              TitleInputFieldWidget(
                title: 'Full Name',
                fieldWidget: FullTextField(
                  title: 'First Last Name',
                  onChanged: (String value) {
                    doctor!.doctorName = value;
                  },
                ),
              ),
              ValueListenableBuilder<String>(
                valueListenable: gender,
                builder: (builder, thisGender, child) {
                  return TitleInputFieldWidget(
                    title: 'Gender',
                    fieldWidget: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.48,
                          child: RadioListTile(
                            activeColor: Theme.of(context).primaryColor,
                            contentPadding: EdgeInsets.all(0),
                            value: 'Male',
                            groupValue: thisGender,
                            onChanged: (values) {
                              print(values);
                              gender.value = 'Male';
                            },
                            toggleable: true,
                            title: Text(
                              'Male',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.48,
                          child: RadioListTile(
                            activeColor: Theme.of(context).primaryColor,
                            contentPadding: EdgeInsets.all(0),
                            value: 'Female',
                            groupValue: thisGender,
                            onChanged: (values) {
                              gender.value = 'Female';
                            },
                            toggleable: true,
                            title: Text(
                              'Female',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
                  onChanged: (String value) {
                    if (int.tryParse(value) != null) {
                      doctor!.doctorAge = int.parse(value);
                    }
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Experience',
                fieldWidget: FullTextField(
                  inputType: TextInputType.number,
                  title: 'In years',
                  onChanged: (String value) {
                    doctor!.doctorExperience = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Address',
                fieldWidget: FullTextField(
                  title: 'House No, Street, Area',
                  onChanged: (String value) {
                    doctor!.doctorAddress!.streetName = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'City',
                fieldWidget: FullTextField(
                  title: 'City Name',
                  onChanged: (String value) {
                    doctor!.doctorAddress!.city = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'State',
                fieldWidget: FullTextField(
                  title: 'State Name',
                  onChanged: (String value) {
                    doctor!.doctorAddress!.state = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Pincode',
                fieldWidget: FullTextField(
                  inputType: TextInputType.number,
                  title: 'In number',
                  onChanged: (String value) {
                    if (int.tryParse(value) != null) {
                      doctor!.doctorAddress!.pincode = int.parse(value);
                    }
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Specialist',
                fieldWidget: FullTextField(
                  title: 'Occupation',
                  onChanged: (String value) {
                    doctor!.doctorSpecialization = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Qualification',
                fieldWidget: FullTextField(
                  title: 'Degree',
                  onChanged: (String value) {
                    doctor!.doctorQualification = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Email Address',
                fieldWidget: FullTextField(
                  inputType: TextInputType.emailAddress,
                  title: 'Email',
                  onChanged: (String value) {
                    doctor!.doctorEmail = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Phone Number',
                fieldWidget: FullTextField(
                  inputType: TextInputType.number,
                  title: '9876543210',
                  onChanged: (String value) {
                    if (int.tryParse(value) != null) {
                      doctor!.doctorPhoneNo = int.parse(value);
                    }
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Hospital',
                fieldWidget: FullTextField(
                  title: 'Hospital Name',
                  onChanged: (String value) {
                    doctor!.doctorHospital = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Average OPD Fees',
                fieldWidget: FullTextField(
                  inputType: TextInputType.number,
                  title: 'In Rupees',
                  onChanged: (String value) {
                    if (double.tryParse(value) != null) {
                      doctor!.doctorFees = double.parse(value);
                    }
                  },
                ),
              ),
              ValueListenableBuilder<Slot>(
                valueListenable: currentSlot,
                builder: (builder, builderSlot, child) {
                  print(builderSlot.toString());
                  return TitleInputFieldWidget(
                    title: 'Time Available',
                    fieldWidget: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      side: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        // width: 3.2,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      helpText: 'Select a date',
                                    ).then(
                                      (value) {
                                        if (value != null) {
                                          currentSlot.value.from = value;
                                          currentSlot.notifyListeners();
                                        }
                                      },
                                    );
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        2.48,
                                    child: Text(
                                      builderSlot.from
                                          .replacing(
                                              hour:
                                                  builderSlot.from.hourOfPeriod)
                                          .toString()
                                          .split('(')[1]
                                          .replaceAll(
                                            ')',
                                            '',
                                          ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      side: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        // width: 3.2,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      helpText: 'Select a date',
                                    ).then(
                                      (value) {
                                        if (value != null) {
                                          currentSlot.value.to = value;
                                          print(
                                              'currentslot value is ${currentSlot.value.toString()}');
                                          print(
                                              'builder slot value is ${builderSlot.toString()}');
                                          currentSlot.notifyListeners();
                                        }
                                      },
                                    );
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        2.48,
                                    child: Text(
                                      builderSlot.to
                                          .replacing(
                                              hour: builderSlot.to.hourOfPeriod)
                                          .toString()
                                          .split('(')[1]
                                          .replaceAll(
                                            ')',
                                            '',
                                          ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: CheckboxListTile(
                            value: builderSlot.isEmergencySlot,
                            onChanged: (value) {
                              currentSlot.value.isEmergencySlot = value!;
                              currentSlot.notifyListeners();
                            },
                            title: Text(
                              'Is Emergency Slot',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(),
                            ),
                            subtitle: Text(
                              '<<Some description about emergency slot>>',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: Colors.black45,
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal,
                                      ),
                            ),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            slotList.value.add(currentSlot.value);

                            currentSlot.value = Slot(
                                from: TimeOfDay.now(), to: TimeOfDay.now());
                            currentSlot.notifyListeners();
                            slotList.notifyListeners();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Add To Slot List',
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ValueListenableBuilder<List<Slot>>(
                valueListenable: slotList,
                builder: (builder, value, child) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black26,
                        width: 0.60,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Slot List',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                        ),
                        ...value
                            .map(
                              (e) => Column(
                                children: [
                                  CheckboxListTile(
                                    value: e.isEmergencySlot,
                                    secondary: IconButton(
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        slotList.value.remove(e);
                                        slotList.notifyListeners();
                                      },
                                    ),
                                    // secondary: Text(
                                    //   '${e.from.hourOfPeriod} - ${e.to.hourOfPeriod}',
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .bodyText1!
                                    //       .copyWith(),
                                    // ),
                                    onChanged: (value) {
                                      e.isEmergencySlot = value!;
                                      slotList.notifyListeners();
                                    },
                                    title: Text(
                                      'Slot ${value.indexOf(e) + 1}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    subtitle: Text(
                                      '${e.from.toString().split('(')[1].replaceAll(')', '')} - ${e.to.toString().split('(')[1].replaceAll(')', '')}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.black45,
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.60,
                                    color: Colors.black26,
                                    indent: 8,
                                    endIndent: 8,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Call when you want to show the time picker
// final DateTime? newDate =

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
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
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
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Style.darkText,
          ),
    );
  }
}

class Slot {
  TimeOfDay from;
  TimeOfDay to;
  bool isEmergencySlot;

  Slot({
    required this.from,
    required this.to,
    this.isEmergencySlot = false,
  });

  @override
  String toString() =>
      'Slot(from: $from, to: $to, isEmergencySlot: $isEmergencySlot)';
}
