import 'package:doctor_booking_application/Components/loading.dart';
import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class CustomFutureBuilder<T> extends StatefulWidget {
  final Widget Function(T) onSuccessWidget;
  final bool runOnce;
  final Widget? onFailure;
  final Widget? onEmpty;
  final Future<T> futureFunction;
  final String loadingText;

  CustomFutureBuilder({
    required this.onSuccessWidget,
    this.runOnce = true,
    this.onFailure,
    this.onEmpty,
    this.loadingText = 'Loading',
    required this.futureFunction,
  });

  @override
  _CustomFutureBuilderState<T> createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  final _memoizer = AsyncMemoizer<T>();

  Future<T> _fetchData() {
    return _memoizer.runOnce(() => widget.futureFunction);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _fetchData(),
      builder: (
        BuildContext context,
        AsyncSnapshot<T> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomLoadingDialog(
            title: widget.loadingText,
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            print('Entering into success widget');
            return widget.onSuccessWidget(snapshot.data!);
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
