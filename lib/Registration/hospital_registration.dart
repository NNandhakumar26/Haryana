import 'dart:io';
import 'package:doctor_booking_application/Components/image_picker.dart';
import 'package:doctor_booking_application/Components/textfield_without_controller.dart';
import 'package:doctor_booking_application/Registration/doctor_registration.dart';
import 'package:doctor_booking_application/modals/doctors.dart';
import 'package:doctor_booking_application/modals/hospital.dart';
import 'package:flutter/material.dart';

class HospitalformWidget extends StatelessWidget {
  final Hospital? hospital;
  final ValueNotifier<File?> image = ValueNotifier<File?>(null);
  final ValueNotifier<File?> hospitalLogo = ValueNotifier<File?>(null);

  final String? values = null;

  HospitalformWidget({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TitleInputFieldWidget(
              title: 'Hospital Name',
              fieldWidget: FullTextField(
                title: 'Enter Hospital Name',
                onSaved: (value) {
                  hospital!.hospitalName = value;
                },
              ),
            ),
            TitleInputFieldWidget(
              title: 'Hospital Type',
              fieldWidget: FullTextField(
                title: 'Type of Hospital',
                onSaved: (String value) {
                  hospital!.hospitalType = value;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TitleInputFieldWidget(
                title: 'Upload Hospital Logo',
                fieldWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ValueListenableBuilder<File?>(
                      valueListenable: hospitalLogo,
                      builder: (builder, value, child) {
                        if (value == null)
                          return ThisPageButton(
                            function: () async {
                              await showDialog(
                                context: context,
                                builder: (builder) => GetImageWidget(),
                              ).then(
                                (value) {
                                  if (value != null) {
                                    hospitalLogo.value = value;
                                  }
                                },
                              );
                            },
                          );
                        else
                          return Container(
                            child: ImageListTile(
                              value: value,
                              function: () {
                                hospitalLogo.value = null;
                              },
                            ),
                          );
                      },
                    ),
                  ),
                ),
              ),
            ),
            TitleInputFieldWidget(
              title: 'Primary Help Line Number',
              fieldWidget: FullTextField(
                inputType: TextInputType.number,
                title: 'HelpLine',
                onSaved: (String value) {
                  if (int.tryParse(value) != null) {
                    hospital!.primaryContact = int.parse(value);
                  }
                },
              ),
            ),
            TitleInputFieldWidget(
              title: 'Secondary Help Line Number',
              fieldWidget: FullTextField(
                inputType: TextInputType.number,
                title: 'HelpLine',
                onSaved: (String value) {
                  if (int.tryParse(value) != null) {
                    hospital!.secondaryContact = int.parse(value);
                  }
                },
              ),
            ),
            TitleInputFieldWidget(
              title: 'Hospital Email',
              fieldWidget: FullTextField(
                inputType: TextInputType.emailAddress,
                title: 'email address',
                onSaved: (String value) {
                  hospital!.hospitalEmail = value;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TitleInputFieldWidget(
                title: 'Upload Hospital Image',
                fieldWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ValueListenableBuilder<File?>(
                      valueListenable: image,
                      builder: (builder, value, child) {
                        if (value == null)
                          return ThisPageButton(
                            function: () async {
                              await showDialog(
                                context: context,
                                builder: (builder) => GetImageWidget(),
                              ).then(
                                (value) {
                                  if (value != null) {
                                    image.value = value;
                                  }
                                },
                              );
                            },
                          );
                        else
                          return Container(
                            child: ImageListTile(
                              value: value,
                              function: () {
                                image.value = null;
                              },
                            ),
                          );
                      },
                    ),
                  ),
                ),
              ),
            ),
            TitleInputFieldWidget(
              title: 'Address',
              fieldWidget: FullTextField(
                title: 'House no, Street, Area',
                onSaved: (String value) {
                  hospital!.hospitalAddress!.streetName = value;
                },
              ),
            ),
            TitleInputFieldWidget(
              title: 'City',
              fieldWidget: FullTextField(
                title: 'City Name',
                onSaved: (String value) {
                  hospital!.hospitalAddress!.city = value;
                },
              ),
            ),
            TitleInputFieldWidget(
              title: 'State',
              fieldWidget: FullTextField(
                title: 'State Full Name',
                onSaved: (String value) {
                  hospital!.hospitalAddress!.state = value;
                },
              ),
            ),
            TitleInputFieldWidget(
              title: 'Pincode',
              fieldWidget: FullTextField(
                inputType: TextInputType.number,
                title: 'In Number',
                onSaved: (String value) {
                  if (int.tryParse(value) != null) {
                    hospital!.hospitalAddress!.pincode = int.parse(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageListTile extends StatelessWidget {
  final File value;
  final VoidCallback function;
  const ImageListTile({
    Key? key,
    required this.value,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 0.32,
        ),
      ),
      leading: CircleAvatar(
        foregroundImage: FileImage(value),
      ),
      title: Text(
        'Hospital Image',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black54,
            ),
      ),
      trailing: IconButton(
        onPressed: () => function(),
        icon: Icon(
          Icons.delete,
          color: Colors.red.withOpacity(0.87),
        ),
      ),
    );
  }
}

class ThisPageButton extends StatelessWidget {
  final VoidCallback function;
  final String? text;
  const ThisPageButton({
    Key? key,
    this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 0.87,
        ),
      ),
      onPressed: () => function(),
      child: Text(
        text ?? 'Pick an Image',
        style: Theme.of(context).textTheme.button!.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
