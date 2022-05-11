import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  final String title;
  final String subtitle;
  // final Function? onPressed;
  final VoidCallback? onPressed;
  final Color? customColor;
  TitleView(
      {this.title = '', this.subtitle = '', this.onPressed, this.customColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 16,
                    color: customColor ?? Colors.black54,
                  ),
              // style: Theme.of(context).textTheme.headline6!.copyWith(
              //       fontSize: 19,
              //       fontWeight: FontWeight.bold,
              //       color: Style.darkerText.withOpacity(0.87),
              //     ),
            ),
          ),
          (subtitle != '')
              ? InkWell(
                  highlightColor: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  onTap: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: <Widget>[
                        Text(
                          subtitle,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Style.darkerText,
                              ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 16,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Style.darkerText,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Divider(
                    height: 2,
                    endIndent: 8,
                    color: Colors.black45,
                  ),
                ),
        ],
      ),
    );
  }
}
