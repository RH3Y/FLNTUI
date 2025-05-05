import 'package:flutter/material.dart';
import 'package:lml/models/note.dart';


class EditScreen extends StatefulWidget {
  final Note? note;
  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  
  @override
  void initState() {
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.content);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,40,16,2),
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back, color: Colors.white),),
                //Text('Edit Note', style: TextStyle(fontSize: 24, color: Colors.white),),                
              ],
            ),
          Expanded(child: ListView(
            children: [
              TextField(
                controller: _titleController,
                style: TextStyle(color: Colors.white, fontSize: 30),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 30),
                ),
              ),
              TextField(
                controller: _contentController,
                style: TextStyle(color: Colors.white, fontSize: 18),
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Content', 
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              )
            ],
          ),)
        ],),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pop(context, [_titleController.text, _contentController.text]);
      },
      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      child: Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}