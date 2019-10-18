import 'package:flutter/material.dart';
import 'package:todo_apps/pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  bool validation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            backGroundLayer(context),
            mainLayer(context),
          ],
        ),
      ),
    );
  }

  Widget backGroundLayer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Colors.deepPurple,
            Colors.deepPurple,
          ],
        ),
        color: Colors.deepPurple,
      ),
    );
  }

  Widget mainLayer(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        child: Form(
          key: form,
          autovalidate: validation,
          child: Column(
            children: <Widget>[
              iconApp(120),
              SizedBox(height: 40.0),
              inputUserName(),
              SizedBox(height: 20.0),
              button(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconApp(double size) {
    return Image.asset(
      'assets/icons/minion.png',
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }

  Widget inputUserName() {
    return TextFormField(
      controller: userName,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        hintText: 'Username',
        contentPadding: EdgeInsets.only(
          top: 18.0,
          right: 18.0,
          bottom: 18.0,
          left: 25.0,
        ),
        errorStyle: TextStyle(
          color: Colors.yellow,
        ),
      ),
      style: TextStyle(
        fontSize: 16.0,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Username is required";
        }
        return null;
      },
    );
  }

  Widget button(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: double.infinity,
      child: RaisedButton(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        color: Color(0xffffc108),
        child: Text(
          'Continue'.toUpperCase(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (form.currentState.validate()) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  userName: userName.text,
                ),
              ),
            );
          } else {
            setState(() {
              validation = true;
            });
          }
        },
      ),
    );
  }
}
