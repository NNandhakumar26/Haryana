import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class BouncingButton extends StatelessWidget {
  final String title;
  final VoidCallback voidCallback;
  final isWhiteButton;
  BouncingButton({
    this.title = 'Done',
    required this.voidCallback,
    this.isWhiteButton = false,
  });

  final double _scaleFactor = 1;

  _onPressed(BuildContext context) {
    Future.delayed(Duration(milliseconds: 248), () {
      voidCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 164),
      onPressed: () => _onPressed(context),
      child: Container(
        height: 54,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: (isWhiteButton)
              ? Colors.white
              : Theme.of(context).primaryColor.withOpacity(0.60),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: (isWhiteButton)
                      ? Theme.of(context).primaryColor.withOpacity(0.87)
                      : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
