import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class RoundedPrimaryButton extends StatelessWidget {
  final String title;
  const RoundedPrimaryButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 164),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 56),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black45,
            width: 0.4,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 18,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.share_rounded,
              size: 20,
              color: Style.primary.shade700,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 14,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.bold,
                        color: Style.primaryColor.withOpacity(0.87),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      onPressed: () async {},
    );
  }
}
