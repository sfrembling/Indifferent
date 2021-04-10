import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:upayme_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/screens/account_register.dart';
import 'package:upayme_app/widgets/custom_button.dart';
import 'package:upayme_app/widgets/custom_input.dart';


class LoginPage extends StatefulWidget {
  
  @override
  _LoginPageState createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {
  
  //Displaying Error message for incorrect account input
  Future<void>_alertDialogBuilder(String error ) async {
    return showDialog(
        context: context,
        //Setting click barrier for closing error message
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("INPUT ERROR"),
            content: Container(
              child: Text(error),//Displaying error message
            ),
            //Closes Alert Dialog
            actions: [
              FlatButton(
                  child: Text("Close Dialog"),
                  onPressed:() {
                    //Closes Error Dialog
                    Navigator.pop(context);
                  }
              )

            ],
          );
        }
    );

  }
  
  //Will Login to User Registered Account
  Future<String>login2Account()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail,
          password: _loginPassword);
      return null;//if null returned user Login successful
    }
    on FirebaseAuthException catch(e)
    {
      if (e.code == 'weak-password')
      {
        //Displaying error if unable to Login user
        return'The password provided is too weak.';
      } 
      else if (e.code == 'email-already-in-use') 
      {
        return'The account already exists for that email.';
      }
      return e.message;//Returns error message
    }
    catch(e)
    {
      return e.toString();
    }
  }

  void _submitForm() async
  {
    //Will show loading dialog
    setState(() 
             {
      _loginFormLoading= true;
    });
    //Initiates account Login
    String _login2AccountFeedback= await login2Account();
    //if null Error when Logging into account
    if(_login2AccountFeedback !=null){
      //will display error dialog
      _alertDialogBuilder(_login2AccountFeedback);
      //Will not display loading dialog..returns to regular state
      setState(() 
               {
        _loginFormLoading= false;
      });
    }//Landing page runs a check using stream Builder and advances to homepage
  }


  //Sets Login button value
  bool _loginFormLoading= false;

  //String Holds user Login input values
  String _loginEmail = "";
  String _loginPassword = "";

  //Password Input Focus Node
  FocusNode _passwordFocusNode;

  @override
  void initState() 
  {
    _passwordFocusNode=FocusNode();
    super.initState();
  }

  @override
  void dispose()
  {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Text("Welcome To UPayMe,\nLogin to your account",
                textAlign: TextAlign.center,
                  style: Constants.boldheading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email..",
                    onChanged: (value)
                    {
                      _loginEmail = value;
                    },
                    onSubmitted: (value)
                    {
                      //Once email is submitted focus is set on password
                      _passwordFocusNode.requestFocus();

                    },
                  ),
                  CustomInput(
                    hintText: "Password..",
                    onChanged: (value)
                    {
                      _loginPassword=value;
                    },
                    //Focuses on the password field Upon email entry
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value){//Submitting user password input to system
                      _submitForm();
                    },
                  ),
                  CustomButton(
                    text: "Login",
                    onPressed: ()
                    {
                      _submitForm();
                    },
                    //Activates Circle Loading feature
                    isLoading: _loginFormLoading,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CustomButton(
                  text: "Sign Up",
                  onPressed: () 
                  {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context)=>AccountRegister()
                      ),
                    );
                  },
                  outlinebutton: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

