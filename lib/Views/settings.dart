
import 'package:flutter/material.dart';
import 'package:pgpe_mobile/Entities/Professeur.dart';

import '../Entities/Matiere.dart';
import '../Services/GroupesService.dart';
import '../Services/Register.dart';
import '../Constant_Data/constants.dart';
import '../main.dart';
import '../session/SessionManager.dart';
import 'login.dart';
import 'studentview.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();
  @override
  initState()  {
    super.initState();
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Changer le mot de passe',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: kPrimaryColor,
          )
        ),
        SizedBox(height: 30.0),
        TextField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(
              color: kPrimaryColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: kPrimaryColor,
              ),
              hintText: 'Entrez votre nouveau mot de passe',
              hintStyle: TextStyle(
                color: kPrimaryColor,
              )
            ),
          ),

      ],
    );
  }
  Widget _buildConfPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _confPasswordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: kPrimaryColor,
              ),
              hintText: 'Confirmer votre mot de passe',
              hintStyle: TextStyle(
                color: kPrimaryColor,
              )
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildConfirm() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          String password = _passwordController.text;
          String confPassword = _confPasswordController.text;

          if (password != confPassword) {
            // Passwords don't match, show an error message
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('Les mots de passe ne correspondent pas. Veuillez réessayer.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            return;
          }
/*
          // Call the registration function
          RegisterResult result = await register.registerProf(email, password);

          if (result.isSuccess) {
            // Registration was successful, navigate to another screen or show a success message
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registration Successful'),
                  content: Text('You have successfully registered.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen1(),
                        ));
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            // Registration failed, show an error message
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registration Failed'),
                  content: Text(result.errorMessage ?? 'An error occurred.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }*/
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: kPrimaryColor,
        child: Text(
          'Confirmer',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:  BoxDecoration(
            //color: Color(0xFFD4E7FE),
              gradient: LinearGradient(
                  colors: [
                    kPrimaryColor,
                    kPrimaryLightColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Paramatres",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),),
        Positioned(
          top: 185,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height - 245,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child:Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height-345,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: ListView(
                      children: [
                        _buildPasswordTF(),
                        _buildConfPasswordTF(),
                        _buildConfirm(),


                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text("Se deconnecter",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.red,
                          ),),
                          SizedBox(height: 17.0),
                        ],),
                      SizedBox(width: 20,),
                      FloatingActionButton(
                          backgroundColor: Colors.red,
                          elevation: 0,
                          child: Icon(Icons.power_settings_new, color: Colors.white,size: 40,),
                          onPressed: () async {
                            await SessionManager.logOut();
                            // Navigate back to the login page or any other appropriate screen
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                          }
                      )
                    ],)
                ],
              )


          ),
        )
      ],
    );
  }
}


