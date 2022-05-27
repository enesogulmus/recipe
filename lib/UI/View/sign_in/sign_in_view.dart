import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe/UI/View/ai_screen/ai_view.dart';
import 'package:recipe/UI/View/reset_password/reset_password_view.dart';
import 'package:recipe/UI/View/sign_up/sign_up_view.dart';
import 'package:recipe/constants.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // form key
  static final _formKey = GlobalKey<FormState>();
  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // email field
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
    // password field
    final  passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        final regex = RegExp(r'^.{8,}$');
        if(value!.isEmpty){
          return kEmptyPasswordWarning;
        }
        if(!regex.hasMatch(value)){
          return kValidPasswordWarning;
        }
      },
      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: kPasswordIcon,
          contentPadding: kTextPadding,
          hintText: kPassword,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )

    );
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor,
      child: MaterialButton(
        padding: kTextPadding,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(kLogin, textAlign: TextAlign.center, style: TextStyle(
          fontSize: 20, color: kTextColor, fontWeight: FontWeight.bold
        ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: kBackGroundColor,
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
                    kInputMargin,
                    passwordField,
                    kButtonMargin,
                    loginButton,
                    kBottomMargin,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                            kHaveAccount
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpView()));
                          },
                          child: const Text(
                            kSignUp,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w900,
                              fontSize: kFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    kBottomMargin,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                            "or "
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w900,
                              fontSize: kFontSize,
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //login function
  void signIn(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) =>{
        Fluttertoast.showToast(
            msg: kLoginSuccess
        ),
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => aiView())
        ),
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




