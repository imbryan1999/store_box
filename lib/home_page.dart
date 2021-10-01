import 'package:flutter/material.dart';
import 'package:store_box/db_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Store Box'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  int i = await DBHelper.instance
                      .insert({DBHelper.colName: 'Bryan'});
                  print('The inserted id is $i');
                },
                child: const Text('Insert'),
                style: ElevatedButton.styleFrom(primary: Colors.green)),
            ElevatedButton(
                onPressed: () async {
                  List<Map<String, dynamic>> queryRows =
                      await DBHelper.instance.queryAll();
                  print(queryRows);
                },
                child: const Text('Query'),
                style: ElevatedButton.styleFrom(primary: Colors.yellow)),
            ElevatedButton(
                onPressed: () async {
                  int updateId = await DBHelper.instance
                      .update({DBHelper.colId: 5, DBHelper.colName: 'jACK'});
                },
                child: const Text('Update'),
                style: ElevatedButton.styleFrom(primary: Colors.blue)),
            ElevatedButton(
                onPressed: () async {
                  int rowsDelete = await DBHelper.instance.delete(3);
                  print(rowsDelete);
                },
                child: const Text('Delete'),
                style: ElevatedButton.styleFrom(primary: Colors.red)),
          ],
        ),
      ),
    );
  }
}
