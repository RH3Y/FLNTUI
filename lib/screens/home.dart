import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lml/models/note.dart';
import 'package:lml/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }
  
  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = sampleNotes.where((note) => 
          note.content.toLowerCase().contains(searchText.toLowerCase()) || 
          note.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    });
  }

  void deleteNote(int index){
    setState(() {
      filteredNotes.removeAt(index);
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,40,16,2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Flutter Notes', style: TextStyle(fontSize: 24, color: Colors.white),),
                IconButton(onPressed: (){}, icon: const Icon(Icons .sort, color: Colors.white))
                
              ],
            ),
            SizedBox(height: 20),
            TextField( // Search Bar Text
              onChanged: onSearchTextChanged,
              style: TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                fillColor: const Color.fromARGB(255, 19, 19, 19),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)
              ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  return Card(
                  elevation: 3, // for z-index purposes
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: const Color.fromARGB(255, 26, 26, 26),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => EditScreen(note: filteredNotes[index]),
                          ),
                        );
                        if (result != null) {
                          setState(() {

                          int originalIndex = sampleNotes.indexOf(filteredNotes[index]);
                          sampleNotes[originalIndex] = Note(
                            id: sampleNotes[originalIndex].id,
                            title: result[0],
                            content: result[1],
                            modifiedTime: DateTime.now());
                            
                          filteredNotes[index] = Note(
                            id: filteredNotes[index].id,
                            title: result[0],
                            content: result[1],
                            modifiedTime: DateTime.now()); 

                          });
                        }
                      },
                      title:RichText(
                        maxLines: 3,
                        text: TextSpan(
                          text: '${filteredNotes[index].title}\n', // title text
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: '${filteredNotes[index].content}\n', // content text
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                height: 1.5,
                              )
                            )
                          ]
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {deleteNote(index);},
                        icon: const Icon(Icons.delete, color: Colors.grey),
                      ),
                      subtitle: 
                        Text('Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(filteredNotes[index].modifiedTime)}', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey),)),
                    ),
                  );
                },
              )
            )
          ],
          
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );

          if (result != null) {
            setState(() {
            sampleNotes.add(Note(
              id: sampleNotes.length,
              title: result[0],
              content: result[1],
              modifiedTime: DateTime.now()));
            filteredNotes = sampleNotes;  
            });
          }
        },
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        child: Icon(Icons.add, size: 30, color: Colors.white ,),
      ),
    );
  }
}