// ignore_for_file: avoid_print

import 'package:baaba_devs_sqflite/Services/db_helper.dart';
import 'package:flutter/material.dart';

class DatabaseScreen extends StatelessWidget {
  const DatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //create
            ElevatedButton(
                onPressed: () async {
                  var data = await DatabaseHelper.instance
                      .insertRecord({DatabaseHelper.columnName: 'AhmadAkhtar'});
                  print(data.toString());
                },
                child: const Text('create')),
            //Read
            ElevatedButton(
                onPressed: () async {
                  var data = await DatabaseHelper.instance.queryDatabase();
                  print(data);
                },
                child: const Text('Read')),
            //Update
            ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.instance.updateRecord({
                    DatabaseHelper.columnId: 21,
                    DatabaseHelper.columnName: 'Muhammad Ahamd'
                  });
                },
                child: const Text('Update')),
            //Delete
            ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.instance.deleteRecord(20);
                },
                child: const Text('Delete')),
          ],
        ),
      ),
    );
  }
}
