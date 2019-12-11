import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uber/main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'driver_signup.dart';
import 'auth_D.dart';


class Driverlogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DriverloginState();
  }
}

class DriverloginState extends State<Driverlogin> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool _isHiddenPw = true;
  bool _isHiddenCPw = true;

  void _visiblePw() {
    setState(() {
      _isHiddenPw = !_isHiddenPw;
      _isHiddenCPw = _isHiddenCPw;
    });
  }

  void _visibleCPw() {
    setState(() {
      _isHiddenPw = _isHiddenPw;
      _isHiddenCPw = !_isHiddenCPw;
    });
  }

   bool _isLoading = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In', style: TextStyle(fontSize: 25.0)),
        backgroundColor: Color(0xff079CA3),
      ),
      body: ModalProgressHUD(
          inAsyncCall: _isLoading,
              child: Container(
            child: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            Text(
              'Join with යමං',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.0,
            ),
            // Text('Login',
            //     style: TextStyle(
            //         color: Color(0xff079CA3),
            //         fontWeight: FontWeight.bold,
            //         fontSize: 25.0)),
            // SizedBox(
            //   height: 30.0,
            // ),

            //Enter E-mail
            Center(
              child: Container(
                height: 40.0,
                width: 280.0,
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Enter the E-mail Address";
                    }
                    return null;
                  },
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      labelText: 'E-mail',
                      hintText: 'nikeshi@gmail.com',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            //Enter password
            Center(
              child: Container(
                height: 40.0,
                width: 280.0,
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Enter the Password";
                    }
                    return null;

                  }, 
              controller: passwordcontroller,
              obscureText: _isHiddenPw,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed:  _visiblePw,
                      icon: _isHiddenPw
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15.0),
                  labelText: 'Password',
                  hintText: 'Password',
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),

        //Navigate Signup
        Center(
          child: Container(
            child: GestureDetector(
              child: Text(
                'No Account yet?SignUp here',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 1.5),

              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            //Navigate Signup
            Center(
              child: Container(
                child: GestureDetector(
                  child: Text(
                    'No Account yet?SignUp here',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        fontSize: 15.0,
                        color: Color(0xff079CA3),
                        fontWeight: FontWeight.bold,
                        decorationThickness: 1.5),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DriverSignup(),
                        ));
                    //TODO:define ontap
                  },
                ),
              ),
            ),

            SizedBox(
              height: 10.0,
            ),


            //button for login
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: RaisedButton(
                  color: Color(0xff079CA3),
                  hoverColor: Color(0xffF5CA99),
                  onPressed: () async {
                    if (emailcontroller.text.isEmpty ||
                        passwordcontroller.text.isEmpty) {
                      setState(() {
                        _formKey.currentState.reset();
                      });

                      return;
                    } else {
                      setState(() {
                       _isLoading = true; 
                      });
                      bool res = await Auth().signInWithEmail(
                          emailcontroller.text, passwordcontroller.text);
                      if (res == true) {
                        print("hello");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (Route<dynamic> route) => false,
                        );

                        setState(() {
                         _isLoading = false; 
                        });
                      }else{
                        _isLoading = false;
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    side: BorderSide(color: Color(0xff079CA3)),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
            ),
                  return;
                } else {
                  bool res = await Auth().signInWithEmail(
                      emailcontroller.text, passwordcontroller.text);
                  if (res == true) {
                    print("hello");
                  }
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: Colors.pinkAccent),
              ),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              )),
        ),

        //Forget password
        Center(
          child: Container(
            child: GestureDetector(
              child: Text(
                'I forget my password',
                style: TextStyle(
                    decorationStyle: TextDecorationStyle.solid,
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),

              ),
            ),
            SizedBox(
              height: 10.0,
            )
          ]),
        )),
      ),
    );
  }
}
