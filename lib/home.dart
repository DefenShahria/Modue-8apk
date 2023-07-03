import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _titlecon = TextEditingController();
  TextEditingController _subtitlecon = TextEditingController();
  TextEditingController _daycon = TextEditingController();

  List<Todo> todos=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO-DO'),
      ),
      body: ListView.separated(
        itemCount: todos.length,
          itemBuilder: (context,index){
            return ListTile(
              onTap: (){
                todos[index].done ? todos[index].done =false : todos[index].done= true;
                if(mounted){
                  setState(() {});
                }
              },
              onLongPress:(){
                showTodoDetails(todos[index]);
              } ,
              leading:todos[index].done ? Icon(Icons.done_rounded) : Icon(Icons.timelapse) ,
              title: Text(todos[index].title),
              subtitle: Text(todos[index].description),
              
            );
      },
        separatorBuilder: (context,index){
            return const Divider(height: 0,);
    },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            newtodo();
          },
          child: const Icon(Icons.add),

    ),
    );
  }

  void newtodo() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController _titlecon = TextEditingController();
        TextEditingController _subtitlecon = TextEditingController();
        TextEditingController _daycon = TextEditingController();

        return AlertDialog(
          title: Text('Add new Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titlecon,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _subtitlecon,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _daycon,
                decoration: InputDecoration(
                  hintText: 'Days Required',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_titlecon.text.trim().isNotEmpty &&
                    _subtitlecon.text.trim().isNotEmpty) {
                  todos.add(Todo(
                    _titlecon.text.trim(),
                    _subtitlecon.text.trim(),
                    false,
                    _daycon.text.trim(),
                  ));
                  if (mounted) {
                    setState(() {});
                  }
                  _titlecon.clear();
                  _subtitlecon.clear();
                  _daycon.clear();
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showTodoDetails(Todo todo) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Todo Details',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Title: ${todo.title}'),
              const SizedBox(height: 8.0),
              Text('Description: ${todo.description}'),
              const SizedBox(height: 8.0),
              Text('Days Required: ${todo.time}'),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    todos.remove(todo);
                  });
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }




}

class Todo {

  String title,description,time;
  bool done;
  Todo(this.title,this.description,this.done,this.time);

}