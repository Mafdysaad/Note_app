import 'package:flutter/material.dart';
import 'package:sqflit/sqflitdb.dart';

class Edit extends StatefulWidget {
  const Edit({super.key, this.Title, this.note, this.id});
  final Title;
  final note;
  final id;

  @override
  State<Edit> createState() => _AddnotesState();
}

class _AddnotesState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    sqldb db = sqldb();
    GlobalKey<FormState> formkey = GlobalKey();
    TextEditingController note = TextEditingController();
    TextEditingController title = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Enter title',
                  labelText: 'Title',
                  labelStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 1),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                validator: (value) => value!.isEmpty ? 'vilad value' : null,
                controller: widget.Title,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.top,
                maxLines: 4,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Enter your note',
                  labelText: 'Note',
                  labelStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 1),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                validator: (value) => value!.isEmpty ? 'vilad value' : null,
                controller: widget.note,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      int respons = await db.updateData('''
                          UPDATE notes SET title = ${title.text},
                          note = ${note.text} WHERE 
                          id = ${widget.id}
                          
                        ''');
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('home', (route) => false);
                    }
                  },
                  elevation: 30,
                  color: Colors.amber,
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('home', (route) => false);
                  },
                  elevation: 30,
                  color: Colors.amber,
                  child: const Text(
                    'Cansel',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
