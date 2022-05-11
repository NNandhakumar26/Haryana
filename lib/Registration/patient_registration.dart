import 'dart:io';
import 'package:badges/badges.dart';
import 'package:doctor_booking_application/Components/company_appbar.dart';
import 'package:doctor_booking_application/Components/image_picker.dart';
import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/Widgets/boucing_button.dart';
import 'package:doctor_booking_application/Widgets/titleView.dart';
import 'package:doctor_booking_application/database/database_export.dart';
import 'package:doctor_booking_application/modals/model_export.dart';
import 'package:flutter/material.dart';
import '../style.dart';
import '../Components/textfield_without_controller.dart';

class PatientRegistration extends ChangeNotifier {
  PatientRegistration({
    required this.patient,
  })  : this.dateOfBirth = ValueNotifier(patient.person?.dob ?? DateTime.now()),
        this.gender = ValueNotifier(patient.person!.gender);

  final Patient patient;

  final ValueNotifier<DateTime?> dateOfBirth;
  final ValueNotifier<String?> gender;

  void updateDate(DateTime date) {
    dateOfBirth.value = date;
  }

  void updateGender(String a) {
    gender.value = a;
  }
}

class PatientRegistrationPage extends StatelessWidget {
  final Patient patient;
  final bool isPatientApp;
  final bool isNewPatient;
  PatientRegistrationPage(
      {Key? key,
      required this.patient,
      this.isNewPatient = false,
      this.isPatientApp = false})
      : this.controller = PatientRegistration(patient: patient),
        super(key: key);
  final ValueNotifier<File?> _image = ValueNotifier<File?>(null);
  final PatientRegistration controller;

  @override
  Widget build(BuildContext context) {
    if (patient.person == null) patient.person = Person(address: Address());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: (isPatientApp) ? Size(double.infinity, 64) : Size(0, 0),
        child: CompanyAppbar(
          title: 'Basic Info',
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isPatientAppWidget(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget isPatientAppWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Visibility(
          visible: isPatientApp,
          child: Hero(
            tag: 'patient',
            child: ValueListenableBuilder(
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
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.87),
                      ),
                      child: (_image.value == null)
                          ? Icon(
                              Icons.verified_user,
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
          ),
        ),
        16.height,
        TitleView(
          title: 'Personal Information',
        ),
        8.height,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            children: [
              TitleInputFieldWidget(
                title: 'Full Name',
                fieldWidget: FullTextField(
                  title: 'First Last Name',
                  icon: Icons.person,
                  onChanged: (String value) {
                    patient.person!.name = value; //
                  },
                ),
              ),
              ValueListenableBuilder<String?>(
                valueListenable: controller.gender,
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
                            onChanged: (String? values) {
                              controller.updateGender(values.toString());
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
                              controller.updateGender(values.toString());
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
              Row(
                children: [
                  Expanded(
                    child: TitleInputFieldWidget(
                      title: 'Age',
                      fieldWidget: FullTextField(
                        inputType: TextInputType.number,
                        title: 'years',
                        onChanged: (String value) {
                          if (int.tryParse(value) != null) {
                            patient.person!.age = int.parse(value);
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: TitleInputFieldWidget(
                      title: '',
                      fieldWidget: FullTextField(
                        inputType: TextInputType.number,
                        title: 'Months',
                        onChanged: (String value) {
                          if (int.tryParse(value) != null) {
                            patient.person!.age = int.parse(value);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              TitleInputFieldWidget(
                title: 'Phone Number',
                fieldWidget: FullTextField(
                  inputType: TextInputType.number,
                  title: '9876543210',
                  onChanged: (String value) {
                    if (int.tryParse(value) != null) {
                      patient.person!.contact1 = int.parse(value);
                    }
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'Email Address',
                fieldWidget: FullTextField(
                  inputType: TextInputType.emailAddress,
                  title: 'Email',
                  onChanged: (String value) {
                    patient.person!.email = value;
                  },
                ),
              ),
              // ValueListenableBuilder<DateTime?>(
              //     valueListenable: controller.dateOfBirth,
              //     builder: (context, values, child) {
              //       return Padding(
              //         padding: const EdgeInsets.symmetric(
              //           vertical: 4,
              //           horizontal: 4,
              //         ),
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: Row(
              //                 children: [
              //                   Icon(
              //                     Icons.calendar_month,
              //                   ),
              //                   8.width,
              //                   FieldTitle(
              //                     text: 'Date of Birth',
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Expanded(
              //               child: CustomDatePicker(
              //                 selectedDate: values ?? DateTime.now(),
              //                 text: (values == null)
              //                     ? 'Date'
              //                     : values.toString().split(' ')[0],
              //                 function: (pickedDate) {
              //                   controller.updateDate(pickedDate);
              //                 },
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     }),

              TitleInputFieldWidget(
                title: 'Address',
                fieldWidget: FullTextField(
                  title: 'House No, Street, Area',
                  multiLine: 4,
                  onChanged: (String value) {
                    patient.person!.address!.streetName = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'City',
                fieldWidget: FullTextField(
                  title: 'City Name',
                  onChanged: (String value) {
                    patient.person!.address!.city = value;
                  },
                ),
              ),
              TitleInputFieldWidget(
                title: 'State',
                fieldWidget: FullTextField(
                  title: 'State Name',
                  onChanged: (String value) {
                    patient.person!.address!.state = value;
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
                      patient.person!.address!.pincode = int.parse(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        8.height,
        Padding(
          padding: const EdgeInsets.all(24),
          child: BouncingButton(
            voidCallback: () async {
              Style.loadingDialog(context, title: 'Adding Patient');
              await Network.createPatient(patient).then(
                (value) {
                  if (isNewPatient) {
                    // store the patient in the local database

                  }

                  Navigator.pop(context);
                  Navigator.pop(context, value);
                },
              );
            },
            title: 'Register Patient',
          ),
        ),
      ],
    );
  }
}
