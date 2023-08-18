import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/model/laundry.dart';
import '../../data/source/source_laundry.dart';

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);
  final controllerCustomerName = TextEditingController();
  final controllerWeight = TextEditingController();
  final controllerPrice = TextEditingController();

  add() async {
    bool success = await SourceLaundry.add(Laundry(
      customerName: controllerCustomerName.text,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      price: double.parse(controllerPrice.text),
      queueDate: DateTime.now(),
      status: 'Queue',
      weight: double.parse(controllerWeight.text),
    ));
    if (success) {
      DInfo.dialogSuccess('Success Add New Laundry');
      DInfo.closeDialog(actionAfterClose: () {
        Get.back(result: true);
      });
    } else {
      DInfo.dialogError('Failed Add New Laundry');
      DInfo.closeDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Add New'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DInput(
            controller: controllerCustomerName,
            title: 'Customer Name',
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerWeight,
            title: 'Weight',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerPrice,
            title: 'Price',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          ElevatedButton(
            onPressed: () {
              add();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
