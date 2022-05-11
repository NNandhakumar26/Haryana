import 'dart:io';
import 'package:doctor_booking_application/Components/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImageWidget extends StatelessWidget {
  final bool? fromGallery;
  GetImageWidget({Key? key, this.fromGallery = null}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      context: context,
      title: 'Pick Medium',
      onDone: () {},
      noActions: true,
      columnWidgets: ['Camera', 'Gallery']
          .map(
            (e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () async {
                    XFile? image;
                    if (e == 'Camera') {
                      image =
                          await _picker.pickImage(source: ImageSource.camera);
                    } else {
                      image =
                          await _picker.pickImage(source: ImageSource.gallery);
                    }
                    Navigator.pop(context, File(image!.path));
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 0,
                  ),
                  title: Text(
                    e,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                PopupMenuDivider(
                  height: 16,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
