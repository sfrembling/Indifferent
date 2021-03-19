import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upayme_app/widgets/custom_button.dart';
import 'package:upayme_app/widgets/custom_input.dart';

import '../constants.dart';
class AccountRegister extends StatefulWidget {
  @override
  _AccountRegisterState createState() => _AccountRegisterState();
}

class _AccountRegisterState extends State<AccountRegister> {
//Displaying Error message for incorrect account input
  Future<void>_alertDialogBuilder(String error )async {
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

  //Creates New User Account
  Future<String>createAccount()async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail,
          password: _registerPassword);
      return null;//if null returned user successfully registered
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {//Displaying error if unable to register user
        return'Please make password stronger.';
      } else if (e.code == 'email-already-in-use') {
        return'Account with email exists, Please Login.';
      }
      return e.message;//Returns error message
    }catch(e){
      return e.toString();
    }
  }

  void _submitForm() async{
    //Will show loading dialog
   setState(() {
     _registerFormLoading= true;
   });
   //Initiates creating  account
    String _createAccountFeedback= await createAccount();
   //if null Error when creating account
    if(_createAccountFeedback !=null){
      //will display error dialog
      _alertDialogBuilder(_createAccountFeedback);
      //Will not display loading dialog if account error occurs
      setState(() {
        _registerFormLoading= false;
      });
    }else{
      //String returns null user successfully logged in
      Navigator.pop(context);
    }
  }


  //Sets register button value
  bool _registerFormLoading= false;

  //String Holds user register input values
  String _registerEmail = "";
  String _registerPassword = "";

  //Password Input Focus Node
  FocusNode _passwordFocusNode;

  @override
  void initState(){
    _passwordFocusNode=FocusNode();
    super.initState();
  }

  @override
   void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
   }

   @override
  Widget build(BuildContext context) {
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
                child: Text("Create A New Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldheading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email..",
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {
                      //Once email is submitted focus is set on password
                      _passwordFocusNode.requestFocus();

                    },
                  ),
                  CustomInput(
                    hintText: "Password..",
                    onChanged: (value){
                      _registerPassword=value;
                    },
                    //Focuses on the password field Upon email entry
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                      onSubmitted: (value){//Submitting user password input to system
                        _submitForm();
                      },
                  ),
                  CustomButton(
                      text: "Register Account",
                      onPressed: (){
                        _submitForm();
                      },
                    //Activates Circle Loading feature
                      isLoading: _registerFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CustomButton(
                  text: "Return To UPayMe Login",
                  onPressed: () {
                    //Returns back to Log in screen
                    Navigator.pop(context);
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

