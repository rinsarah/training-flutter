import 'package:flutter/material.dart';
import 'package:todo_apps/pages/create.dart';
import 'package:todo_apps/pages/login.dart';
import 'package:todo_apps/services/web-service.dart';
import 'package:todo_apps/widgets/loading.dart';

class HomePage extends StatefulWidget {
  final String userName;
  HomePage({this.userName});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Map> dummyList = [
    {
      "id": 1,
      "title": "Dummy Data",
      "description": "Oh la la joker",
      "status": "In progress",
      "date": "18 Oct 2019"
    },
    {
      "id": 1,
      "title": "Dummy Data",
      "description": "Oh la la joker",
      "status": "In progress",
      "date": "18 Oct 2019"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Apps'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePage(userName: widget.userName),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: FutureBuilder(
          future: getTodo(),
          builder: (context, result) {
            if (result.hasData) {
              return itemList(result.data);
            } else {
              return Loading();
            }
          },
        ),
      ),
      backgroundColor: Color(0xfff0f0f0),
    );
  }

  Future getTodo() async {
    return await WebService().getRequest('/list_todo');
  }

  Widget itemList(List todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        return itemTodo(todos[index]);
      },
    );
  }

  Widget itemTodo(Map todo) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  todo['username'] + ' - ' + todo['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  todo['date'],
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              todo['description'],
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
