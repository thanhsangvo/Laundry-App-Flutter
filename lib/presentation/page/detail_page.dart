import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/data/model/laundry.dart';

import '../../config/status.dart';
import '../../data/source/source_laundry.dart';
import '../component/detail_laundry.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.laundry}) : super(key: key);
  final Laundry laundry;

  updateStatus() async {
    final controller = TextEditingController(text: laundry.status);
    var result = await Get.dialog(
      AlertDialog(
        title: const Text('Update Status'),
        content: DropdownButtonFormField<String>(
          value: controller.text,
          items: Status.listMenu.map((e) {
            return DropdownMenuItem<String>(value: e, child: Text(e));
          }).toList(),
          onChanged: (value) {
            controller.text = value ?? "";
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
    if ((result ?? false) && controller.text != '') {
      bool success =
          await SourceLaundry.updateStatus(laundry.id!, controller.text);
      if (success) {
        DInfo.dialogSuccess('Success Update Status');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError('Failed Update Status');
        DInfo.closeDialog();
      }
    }
  }

  delete() async {
    bool? yes = await DInfo.dialogConfirmation(
        Get.context!, 'Delete', 'Yes to confirm');
    // if (yes) {
    //   bool success = await SourceLaundry.delete(laundry.id!);
    //   if (success) {
    //     DInfo.dialogSuccess('Success Delete Laundry');
    //     DInfo.closeDialog(actionAfterClose: () {
    //       Get.back(result: true);
    //     });
    //   } else {
    //     DInfo.dialogError('Failed Delete Laundry');
    //     DInfo.closeDialog();
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Laundry'),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () => updateStatus(),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => delete(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: DetailLaundry(laundry: laundry),
    );
  }
}
