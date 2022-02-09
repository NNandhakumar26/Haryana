import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> itemList;
  final Function voidCallBack;
  final String selectedValue;

  CustomDropDown(
      {required this.itemList,
      required this.voidCallBack,
      required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Theme.of(context).primaryColor.withOpacity(0.24),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.48),
            width: 0.64,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: DropdownButtonFormField<String>(
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                letterSpacing: 0.2,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade500,
              ),
          hint: Text(
            'Select',
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                ),
          ),
          elevation: 20,
          isExpanded: true,
          validator: (value) => value == null ? 'Cannot Be Null' : null,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          items: itemList.map(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              );
            },
          ).toList(),
          onChanged: (value) => voidCallBack(value),
        ),
      ),
    );
  }
}
