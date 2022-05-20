import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe/constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  static final _formKey = GlobalKey<FormState>();
  // editing controller
  final TextEditingController emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final  emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value){
          if(value!.isEmpty){
            return kEnterEmailWarning;
          }
          //reg expression of email validation
          if(!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)){
            return kValidEmailWarning;
          }
          return null;
        },
        onSaved: (value){
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: kEmailIcon,
          contentPadding: kTextPadding,
          hintText: kEmail,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )

    );

    final resetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor,
      child: MaterialButton(
        padding: kTextPadding,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          resetPassword(emailController.text);
        },
        child: const Text("Reset Password", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 20, color: kTextColor, fontWeight: FontWeight.bold
        ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: kBackIcon,
          color: kPrimaryColor,
          iconSize: 30,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: kBackGroundColor,
            child: Padding(
              padding: EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 55,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                        )
                    ),
                    kLogoMargin,
                    emailField,
                    kButtonMargin,
                    resetButton
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword(String email) async{
    if(_formKey.currentState!.validate()){
      await _auth.sendPasswordResetEmail(email: email).then((uid) =>{
        Fluttertoast.showToast(
            msg: "Reset Password E-mail Sent"
        ),
        Navigator.of(context).pop(),
      }
      ).catchError((e){
        Fluttertoast.showToast(
          msg: e!.message,
          backgroundColor: kPrimaryColor,
          textColor: kTextColor,
          fontSize: 16,
        );
      }
      );
    }
  }
}
