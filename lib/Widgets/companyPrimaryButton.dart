import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Color? buttonColor;
  final Color? foregroundColor;
  final VoidCallback? function;
  final double? elevation;
  final bool isSingleButton;
  final double? buttonWidth;

  PrimaryButton(
      {this.title = 'Done',
      this.buttonColor,
      this.foregroundColor,
      required this.function,
      this.elevation,
      this.isSingleButton = true,
      this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 164),
      onPressed: () => function!(),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          height: 54,
          width: buttonWidth ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color:
                buttonColor ?? Theme.of(context).primaryColor.withOpacity(0.87),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                title,
                style: (isSingleButton)
                    ? Theme.of(context).textTheme.button!.copyWith(
                          color: foregroundColor ?? Colors.white,
                          // fontSize: 20,
                          // fontWeight: FontWeight.w800,
                        )
                    : Theme.of(context).textTheme.button!.copyWith(),
              ),
            ),
          ),
        ),
        // child: ElevatedButton(
        //   onPressed: () {},
        //   style: ElevatedButton.styleFrom(
        //     elevation: elevation ?? 0,
        //     shape: StadiumBorder(),
        //     primary: buttonColor ?? Style.primary.withOpacity(0.87),
        //   ),
        //   child: Padding(
        //     padding: EdgeInsets.all(14.0),
        //     child: Text(
        //       title,
        //       style: (isSingleButton)
        //           ? Theme.of(context).textTheme.button!.copyWith(
        //               color: foregroundColor,
        //               fontSize: 20,
        //               fontWeight: FontWeight.w800,
        //             )
        //           : Theme.of(context).textTheme.button!,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
