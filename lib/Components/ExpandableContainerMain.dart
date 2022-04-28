import 'package:flutter/material.dart';

import '../style.dart';

class ExpandContainerPage extends StatelessWidget {
  final Widget title;

  final String eContFirst;
  final String eContSecond;
  final String desc;
  final List<ColumnText>? list;
  final String lastContainerValue;
  final bool isCustomDropDownValue;
  final Widget? customWidget;

  ExpandContainerPage({
    required this.title,
    this.eContFirst = 'Details',
    this.eContSecond = '',
    this.desc = '',
    this.list,
    this.lastContainerValue = '',
    this.isCustomDropDownValue = false,
    this.customWidget,
  }) : assert((list != null) || customWidget != null);

  //TODO: INITIALIZE WITH MAIN ROW ELEMENTS,
  //TODO: GET IT REPLICATED FROM THAT PAGE...
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Style.lightText.withOpacity(0.32),
          width: 0.87,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ExpansionTile(
        //THE ROW ELEMENT OR PASS THE LIST OF WIDGETS AND SPREAD IT WITHIN THE ROW (MAINAXISALIGNMENT.SPACEBETWEEN)
        title: title,
        tilePadding: EdgeInsets.all(0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: (customWidget == null)
                ? Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: list!
                        .map(
                          (e) => ColumnText(
                            title: e.title,
                            subtitle: e.subtitle,
                          ),
                        )
                        .toList(),
                  )
                : customWidget,
          ),
        ],
      ),
    );
  }
}

class ColumnText extends StatelessWidget {
  final String title;
  final String subtitle;
  ColumnText({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    //make it expanded and constrain the size in the main file from where it's been called...
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Style.primary.shade500.withOpacity(0.32),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Style.primary.withOpacity(0.87),
            width: 0.60,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Style.primary.withOpacity(0.60),
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Style.primary.withOpacity(0.87),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
