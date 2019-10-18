import 'package:flutter/material.dart';
import 'package:todo_apps/services/helper-service.dart';
import 'package:todo_apps/services/web-service.dart';
import 'package:todo_apps/widgets/loading.dart';

class CreatePage extends StatefulWidget {
  final String userName;
  CreatePage({this.userName});

  @override
  State<StatefulWidget> createState() {
    return CreatePageState();
  }
}

class CreatePageState extends State<CreatePage> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  bool validation = false;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: showLoading == false
          ? SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: form,
                autovalidate: validation,
                child: Column(
                  children: <Widget>[
                    inputTitle(),
                    SizedBox(height: 10),
                    inputDesc(),
                    SizedBox(height: 20),
                    button(context),
                  ],
                ),
              ),
            )
          : Loading(),
      backgroundColor: Color(0xfff0f0f0),
    );
  }

  Widget inputTitle() {
    return TextFormField(
      controller: title,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        labelText: 'Title',
        labelStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextStyle(
        fontSize: 20.0,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Title is required";
        }
        return null;
      },
    );
  }

  Widget inputDesc() {
    return TextFormField(
      controller: description,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        labelText: 'Description',
        labelStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextStyle(
        fontSize: 18.0,
      ),
      maxLines: 5,
      validator: (String value) {
        if (value.isEmpty) {
          return "Description is required";
        }
        return null;
      },
    );
  }

  Widget button(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: double.infinity,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          'Save'.toUpperCase(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (form.currentState.validate()) {
            // Navigator.pop(context);
            submitForm();
          } else {
            setState(() {
              validation = true;
            });
          }
        },
      ),
    );
  }

  void submitForm() async {
    setState(() {
      showLoading = true;
    });

    Map params = {
      'username': widget.userName,
      'title': title.text,
      'description': description.text,
    };

    WebService().sendingRequest('/create_todo', params).then((result) {
      setState(() {
        showLoading = false;
      });
      HelperService().displayToast(result['msg']);
      Navigator.pop(context);
    }).catchError((error) {
      setState(() {
        showLoading = false;
      });
      HelperService().displayToast(error);
    });
  }
}
