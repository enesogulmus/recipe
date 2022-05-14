import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe/Core/SERVICES/Users.dart';
import 'package:recipe/UI/View/ai_screen/ai_view.dart';
import 'package:recipe/constants.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _auth = FirebaseAuth.instance;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // fill genderList
  final genderList = ['Male', 'Female', 'Unknown'];
  // selected value on genderList
  static String? dropDownValue;
  //editing Controller
  final firstNameEditingController = TextEditingController();

  final lastNameEditingController = TextEditingController();

  final emailEditingController = TextEditingController();

  final passwordEditingController = TextEditingController();

  final confirmPasswordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //firstname field
    final  firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value){
          final regex = RegExp(r'^.{3,}$');
          if(value!.isEmpty){
            return kEmptyFirstNameWarning;
          }
          if(!regex.hasMatch(value)){
            return kValidFirstName;
          }
          return null;
        },
        onSaved: (value){
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: kUserIcon,
          contentPadding: kTextPadding,
          hintText: kFirstName,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )

    );
    //lastname field
    final  lastNameField = TextFormField(
        autofocus: false,
        controller: lastNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value){
          if(value!.isEmpty){
            return kEmptyLastNameWarning;
          }
          return null;
        },
        onSaved: (value){
          lastNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: kUserIcon,
          contentPadding: kTextPadding,
          hintText: kLastName,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )

    );
    //gender field
    final genderField = Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black38, width: 1)
        ),
        child: DropdownButtonHideUnderline(
          child:DropdownButton(
            items: genderList.map((value) => DropdownMenuItem(
            child: Text(value),
            value: value)).toList(),
            onChanged: (genderList) {
              setState(() {
                dropDownValue = (genderList) as String?;
              });
            },
            value: dropDownValue,
            hint: Text('Gender'),
            borderRadius: BorderRadius.circular(10),
            iconSize: 24,
            icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black38),
            isExpanded: true,
            autofocus: false,
          ),
        ),
      ),
    );
    //email field
    final  emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
          emailEditingController.text = value!;
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
    //password field
    final  passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          final regex = RegExp(r'^.{1,}$');
          if(value!.isEmpty){
            return kEmptyPasswordWarning;
          }
          if(!regex.hasMatch(value)){
            return kValidPasswordWarning;
          }
        },
        onSaved: (value){
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: kPasswordIcon,
          contentPadding: kTextPadding,
          hintText: kPassword,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )

    );
    //confirmPassword Field
    final  confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value){
          if(confirmPasswordEditingController.text != passwordEditingController.text){
            return kEqualPasswordWarning;
          }
          return null;
        },
        onSaved: (value){
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: kPasswordIcon,
          contentPadding: kTextPadding,
          hintText: kConfirmPassword,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )

    );

    //Sign Up Button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor,
      child: MaterialButton(
        padding: kTextPadding,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(kSignUp, textAlign: TextAlign.center, style: TextStyle(
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
        title: Center(
          child: Row(
            children: [
              SizedBox(
                  height: 55,
                  width: 225,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  )
              ),
            ],
          ),
        ),
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
              padding: const EdgeInsets.all(48.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /*SizedBox(
                      height: 50,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      )
                  )
                    kLogoMargin,*/
                    firstNameField,
                    kInputMargin,
                    lastNameField,
                    kInputMargin,
                    genderField,
                    kInputMargin,
                    emailField,
                    kInputMargin,
                    passwordField,
                    kInputMargin,
                    confirmPasswordField,
                    kButtonMargin,
                    signUpButton,
                    kBottomMargin,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signUp(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        postDetailsToFirestore()
      }
      ).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      }
      );
    }
  }
  postDetailsToFirestore() async{
    // calling our fireStore
    // calling our users services
    //sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Users users = Users();
    // writing all the values
    users.email = user!.email;
    users.uid = user.uid;
    users.firstName = firstNameEditingController.text;
    users.lastName = lastNameEditingController.text;
    users.gender = dropDownValue.toString();

    await firebaseFirestore.collection('users').doc(user.uid).set(users.toMap());
    Fluttertoast.showToast(msg: 'Account created successfully');
    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => aiView()), (route) => false);

  }
/*  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      )
    ),
  );*/
}
