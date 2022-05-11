import 'package:doctor_booking_application/Components/RowTextField.dart';
import 'package:doctor_booking_application/Components/company_appbar.dart';
import 'package:doctor_booking_application/Components/divider.dart';
import 'package:doctor_booking_application/Widgets/boucing_button.dart';
import 'package:doctor_booking_application/Widgets/future_builder.dart';
import 'package:doctor_booking_application/Widgets/search_widget.dart';
import 'package:doctor_booking_application/database/cloud_database.dart';
import 'package:doctor_booking_application/modals/hospital.dart';
import 'package:doctor_booking_application/modals/person.dart';
import 'package:doctor_booking_application/modals/slot.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_application/Components/textfield_without_controller.dart';
import 'package:doctor_booking_application/modals/doctors.dart';
import '../style.dart';

class DoctorRegistrationPage extends StatefulWidget {
  final Doctor doctor;

  DoctorRegistrationPage({Key? key, required this.doctor});

  @override
  State<DoctorRegistrationPage> createState() => _DoctorRegistrationPageState();
}

class _DoctorRegistrationPageState extends State<DoctorRegistrationPage> {
  final String? radioButtonValue = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.doctor.person == null) widget.doctor.person = Person();
    if (widget.doctor.person!.address == null)
      widget.doctor.person!.address = Address();
    if (widget.doctor.specializations == null)
      widget.doctor.specializations = [];

    return Material(
      color: Colors.transparent,
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
                  onChanged: (String value) {
                    widget.doctor.person!.name = value;
                  },
                ),
              ),

              // CustomDatePicker(selectedDate: doctor., function: function)
              // TitleInputFieldWidget(
              //   title: 'Date of Birth',
              //   fieldWidget: FullTextField(
              //     title: 'DD-MM-YY',
              //   ),
              // ),

              TitleInputFieldWidget(
                title: 'Age',
                fieldWidget: FullTextField(
                  inputType: TextInputType.number,
                  title: 'In yrs',
                  onChanged: (String value) {
                    if (int.tryParse(value) != null) {
                      widget.doctor.person!.age = int.parse(value);
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
                    widget.doctor.Experience = value;
                  },
                ),
              ),

              TitleInputFieldWidget(
                title: 'Address',
                fieldWidget: FullTextField(
                  title: 'House No, Street, Area',
                  onChanged: (String value) {
                    widget.doctor.person!.address!.streetName = value;
                  },
                ),
              ),

              TitleInputFieldWidget(
                title: 'City',
                fieldWidget: FullTextField(
                  title: 'City Name',
                  onChanged: (String value) {
                    widget.doctor.person!.address!.city = value;
                  },
                ),
              ),

              TitleInputFieldWidget(
                title: 'State',
                fieldWidget: FullTextField(
                  title: 'State Name',
                  onChanged: (String value) {
                    widget.doctor.person!.address!.state = value;
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
                      widget.doctor.person!.address!.pincode = int.parse(value);
                    }
                  },
                ),
              ),

              TitleInputFieldWidget(
                title: 'Qualification',
                fieldWidget: FullTextField(
                  title: 'Degree',
                  onChanged: (String value) {
                    widget.doctor.Qualification = value;
                  },
                ),
              ),

              TitleInputFieldWidget(
                title: 'Email Address',
                fieldWidget: FullTextField(
                  inputType: TextInputType.emailAddress,
                  title: 'Email',
                  onChanged: (String value) {
                    widget.doctor.person!.email = value;
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
                      widget.doctor.person!.contact1 = int.parse(value);
                    }
                  },
                ),
              ),

              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 6),
                title: Text('Specializations'),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Text('Select Specializations'),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onTap: () {
                  Style.navigateBack(
                    context,
                    SpecializationRegistrationPage(widget.doctor),
                  );
                },
              ),

              (widget.doctor.hospitalName == null)
                  ? ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      title: Text('Select Hospital'),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Text('Select Hospital'),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      onTap: () async {
                        await Style.navigateBack(context, SearchHospital())
                            .then(
                          (value) {
                            if (value is Hospital) {
                              widget.doctor.hospitalId = value.hospitalID;
                              widget.doctor.hospitalName = value.hospitalName;
                              setState(() {});
                            }
                          },
                        );
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FieldTitle(
                            text: 'Clinic Name',
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            initialValue: widget.doctor.hospitalName,
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.doctor.hospitalId = null;
                                    widget.doctor.hospitalName = null;
                                  });
                                },
                                icon: Icon(
                                  Icons.clear,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

              // FieldTitle(
              //   text: 'Upload Picture',
              // ),

              // UploadButtonWidget(),
              TitleInputFieldWidget(
                title: 'Average Duration per Session',
                fieldWidget: FullTextField(
                  inputType: TextInputType.number,
                  title: '(In Mins)',
                  onChanged: (String value) {
                    if (int.tryParse(value) != null)
                      widget.doctor.checkupDuration = int.parse(value);
                  },
                ),
              ),
              // TitleInputFieldWidget(
              //   title: 'Time Available',
              //   fieldWidget: FullTextField(
              //     title: '00:00AM - 00:00PM',
              //   ),
              // ),
              TitleInputFieldWidget(
                title: 'Average OPD Fees',
                fieldWidget: FullTextField(
                  inputType: TextInputType.number,
                  title: 'In Rupees',
                  onChanged: (String value) {
                    if (double.tryParse(value) != null) {
                      widget.doctor.doctorFees = double.parse(value);
                    }
                  },
                ),
              ),

              // Align(
              //   alignment: Alignment.center,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: BouncingButton(
              //       voidCallback: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (builder) => SpecializationRegistrationPage(
              //               doctor,
              //             ),
              //           ),
              //         );
              //       },
              //       title: 'Proceed',
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecializationRegistrationPage extends StatefulWidget {
  final Doctor doctor;
  const SpecializationRegistrationPage(this.doctor, {Key? key})
      : super(key: key);

  @override
  State<SpecializationRegistrationPage> createState() =>
      _SpecializationRegistrationPageState();
}

class _SpecializationRegistrationPageState
    extends State<SpecializationRegistrationPage> {
  TextEditingController searchValue = TextEditingController();

  bool checkAvailability(String value) {
    try {
      return (widget.doctor.specializations!.firstWhere(
                (element) => element == value,
              ) ==
              -1)
          ? false
          : true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.doctor.specializations == null)
      widget.doctor.specializations = <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          CompanyAppbar(
            title: 'Specialization Registration',
          ),
          Expanded(
            child: CustomFutureBuilder<List<String>>(
                futureFunction: Network.getAllSpecializations(),
                onSuccessWidget: (specializationList) {
                  // display the list of specializations with the search text
                  // List<String> displayList = specializationList;
                  List<String> displayList = specializationList
                      .where(
                        (element) => element.toLowerCase().contains(
                              searchValue.text.toLowerCase(),
                            ),
                      )
                      .toList();
                  print('The display list is $displayList');
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: searchValue,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    searchValue.clear();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    size: 20,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => CustomDivider(),
                          itemCount: displayList.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(
                                displayList[index].toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              value: checkAvailability(displayList[index]),
                              onChanged: (bool? value) {
                                if (value ?? true) {
                                  widget.doctor.specializations!
                                      .add(displayList[index]);
                                } else {
                                  widget.doctor.specializations!
                                      .remove(displayList[index]);
                                }
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BouncingButton(
              voidCallback: () async {
                //show a loading dialog
                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (context) => CircularProgressIndicator(),
                // );

                // // await Network.addDoctor(widget.doctor);
                // // Navigator.push(
                // //   context,
                // //   MaterialPageRoute(
                // //     builder: (builder) => MainPage(),
                // //   ),
                // // );
                Navigator.pop(context);
              },
              title: 'Finish',
            ),
          ),
        ],
      ),
    );
  }
}

class SearchHospital extends StatefulWidget {
  const SearchHospital({Key? key}) : super(key: key);

  @override
  State<SearchHospital> createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital> {
  List<Hospital> hospitalList = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomFutureBuilder<List<Hospital>>(
        futureFunction: Network.getAllHospitals(),
        loadingText: 'Downloading Data',
        onSuccessWidget: (networkList) {
          hospitalList = networkList;
          print(hospitalList.toString());
          // displaylist
          List<Hospital> displayList = hospitalList
              .where(
                (Hospital hospital) => hospital.hospitalName!
                    .toLowerCase()
                    .contains(searchController.text),
              )
              .toList();

          return SearchDisplayWidget(
            title: 'Search Your Clinic',
            setState: () {
              setState(() {});
            },
            // child: DropdownButton<SearchWith>(
            //   value: searchWith,
            //   focusColor: Colors.transparent,
            //   style: TextStyle(color: Colors.white),
            //   underline: SizedBox(),
            //   items: SearchWith.values
            //       .map<DropdownMenuItem<SearchWith>>(
            //         (value) => DropdownMenuItem(
            //           value: value,
            //           child: Text(
            //             searhWithString(value),
            //             style: Theme.of(context).textTheme.bodyText2,
            //           ),
            //         ),
            //       )
            //       .toList(),
            //   onChanged: (SearchWith? value) {
            //     setState(() {
            //       searchWith = value ?? SearchWith.name;
            //     });
            //   },
            // ),
            searchController: searchController,
            displayList: displayList
                .map(
                  (e) => ListTile(
                    title: Text(e.hospitalName!),
                    subtitle: Text(e.hospitalAddress?.streetName ?? ''),
                    onTap: () {
                      Navigator.pop(context, e);
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class IndividualSlotWidget extends StatelessWidget {
  final Slot thisSlot;
  final int index;
  final void Function(Slot) onRemoved;
  final void Function(bool) onChanged;
  const IndividualSlotWidget({
    Key? key,
    required this.thisSlot,
    required this.index,
    required this.onChanged,
    required this.onRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          value: thisSlot.isEmergencySlot,
          secondary: InkWell(
            onTap: () => onRemoved(thisSlot),
            child: SizedBox(
              width: 30,
              child: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          onChanged: (value) => onChanged(value ?? false),
          title: Text(
            'Slot $index',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
          ),
          subtitle: Text(
            '${thisSlot.from.toString().split('(')[1].replaceAll(')', '')} - ${thisSlot.to.toString().split('(')[1].replaceAll(')', '')}',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.black45,
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        Divider(
          thickness: 0.32,
          color: Colors.black26,
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }
}

class SlotBuilderWidget extends StatefulWidget {
  final Slot thisSlot;
  const SlotBuilderWidget({Key? key, required this.thisSlot}) : super(key: key);

  @override
  _SlotBuilderWidgetState createState() => _SlotBuilderWidgetState();
}

class _SlotBuilderWidgetState extends State<SlotBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Slot Builder',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SlotTimePickerWidget(
            title: 'From',
            onChanged: (value) {
              widget.thisSlot.from = value;
              widget.thisSlot.to =
                  TimeOfDay(hour: value.hour, minute: value.minute + 30);
              setState(() {});
            },
            displayTime: widget.thisSlot.from,
          ),
          SlotTimePickerWidget(
            title: 'To',
            onChanged: (value) {
              widget.thisSlot.to = value;
              setState(() {});
            },
            displayTime: widget.thisSlot.to,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: CheckboxListTile(
              value: widget.thisSlot.isEmergencySlot,
              onChanged: (value) {
                widget.thisSlot.isEmergencySlot = value!;
                setState(() {});
              },
              title: Text(
                'Is Emergency Slot',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(),
              ),
              subtitle: Text(
                '<<Some description >>',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.black45,
                      fontSize: 8,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Style.primary.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
          onPressed: () {
            Navigator.pop(context, widget.thisSlot);
          },
          child: Text(
            'Add Slot',
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: Colors.white.withOpacity(0.98),
                ),
          ),
        ),
      ],
    );
  }
}

class SlotTimePickerWidget extends StatelessWidget {
  final String title;
  final Function(TimeOfDay) onChanged;
  final TimeOfDay displayTime;

  const SlotTimePickerWidget({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.displayTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: Colors.black45,
              ),
        ),
        Container(
          width: 160,
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(
                  color: Style.primary.shade600,
                  width: 0.87,
                ),
              ),
            ),
            onPressed: () async {
              await showTimePicker(
                context: context,
                initialTime: displayTime,
                helpText: 'Select a Time',
              ).then(
                (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
              );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.48,
              child: Text(
                displayTime
                    .replacing(hour: displayTime.hourOfPeriod)
                    .toString()
                    .split('(')[1]
                    .replaceAll(
                      ')',
                      '',
                    ),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(),
              ),
            ),
          ),
        ),
      ],
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
