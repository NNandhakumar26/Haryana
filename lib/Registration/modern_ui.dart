import 'package:animate_do/animate_do.dart';
import 'package:doctor_booking_application/Widgets/boucing_button.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class ModernUIWidget extends StatelessWidget {
  final List<String> titleList;
  final int currentIndex;
  final List<Widget> widgetList;
  final String buttonText;
  final VoidCallback onPressed;

  const ModernUIWidget({
    Key? key,
    required this.titleList,
    required this.currentIndex,
    required this.widgetList,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - 32,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 16, bottom: 12, right: 16, left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    //TODO:value notifier heree
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stepper(
                            elevation: 0,
                            margin: EdgeInsets.all(0),
                            type: StepperType.horizontal,
                            controlsBuilder: (BuildContext context,
                                    ControlsDetails details) =>
                                SizedBox.shrink(),
                            steps: [
                              for (var i = 0; i < titleList.length; i++)
                                Step(
                                  title: Text(''),
                                  content: SizedBox.shrink(),
                                  state: StepState.disabled,
                                  isActive: (i <= currentIndex) ? true : false,
                                ),
                            ],
                          ),
                        ),
                        Text(
                          titleList[currentIndex],
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Style.darkerText,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            elevation: 4,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: widgetList[currentIndex],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ElasticIn(
                            duration: Duration(milliseconds: 800),
                            child: Container(
                              height: 48,
                              child: BouncingButton(
                                voidCallback: () => onPressed(),
                                isWhiteButton: true,
                                title: buttonText,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
