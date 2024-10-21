import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sqflit/edit.dart';
import 'package:sqflit/sqflitdb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  sqldb db = sqldb();
  bool isloding = true;
  List mylist = [];
  Future reddata() async {
    List<Map> respons = await db.readData('SELECT * FROM notes');
    mylist.addAll(respons);
    isloding = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    reddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('addnotes');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.greenAccent,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
        appBar: AppBar(
          title: const Text('sql'),
        ),
        body: isloding == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: mylist.length,
                itemBuilder: (context, index) => Dismissible(
                  key: ValueKey(mylist[index]['id']),
                  onDismissed: (direction) async {
                    await db.deleteData(
                        'DELETE FROM notes WHERE id = ${mylist[index]['id']}');
                  },
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Edit(
                        note: mylist[index]['note'] ,
                        Title: mylist[index]['title'],
                        id: mylist[index]['id'],
                      )));
                    },
                    child: Card(
                        child: ListTile(
                      title: Text('${mylist[index]['title']}'),
                      trailing: Text('${mylist[index]['note']}'),
                    )),
                  ),
                ),
              ));
  }
}
