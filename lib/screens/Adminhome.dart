import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:placementapp/pages/Loginscreen.dart';
import 'package:placementapp/main.dart';
//import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Adminhome extends StatefulWidget {
  final FirebaseUser user;

  const Adminhome({Key key, this.user}) : super(key: key);
  @override
  _AdminhomeState createState() => _AdminhomeState(user);
}

class _AdminhomeState extends State<Adminhome> {
    String name, email;
  _AdminhomeState(this.user);
  final db = Firestore.instance;
  Future getdata() async {
    final Future<DocumentSnapshot> document =
        Firestore.instance.collection('users').document(user.uid).get();

    await document.then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        name = snapshot.data['name'];
        email = snapshot.data['email'];
      });
    });
  }

 @override
  void initState() {
    super.initState();
    getdata();
    setState(() {
      db.collection('users').document(user.uid).updateData({'name': name});
    });
  }
  final FirebaseUser user;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[300],
        title: Text(
          "Placement App-Admin",
          style: GoogleFonts.pattaya(fontSize: 30),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              '$name',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            accountEmail: Text(
              '$email',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "S",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "About",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.info,
              color: Colors.blueAccent,
            ),
            onTap: () {},
          ),
          ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.logout,
                color: Colors.blueAccent,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Loginscreen()));
              }),
          InkWell(
            borderRadius: BorderRadius.circular(500),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.redAccent),
            ),
          ),
        ],
      )),
      body: Container(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
