import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF84AB5C);
const kTextColor = Color(0xFF202E2E);
const kTextLightColor = Color(0xFF7286A5);
const kBackGroundColor = Color(0xFFFFFFFF);

const kEmailIcon = Icon(Icons.mail_outlined);
const kPasswordIcon = Icon(Icons.vpn_key_outlined);
const kUserIcon = Icon(Icons.account_circle_outlined);
const kBackIcon = Icon(Icons.arrow_back_outlined);

const kMaleProfile = "assets/images/chef_3.png";
const kFemaleProfile = "assets/images/chef_1.png";

const kTextPadding = EdgeInsets.fromLTRB(20, 15, 20, 15);

const String kValidFirstName = ('Please enter valid first name(Min. 3 Character)');
const String kValidLastName = ('Please enter valid last name(Min. 3 Character)');
const String kEmptyFirstNameWarning = ('Please enter your first name');
const String kEmptyLastNameWarning = ('Please enter your first name');
const String kEnterEmailWarning = ('Please enter your email address');
const String kValidEmailWarning = ('Please enter a valid email address');
const String kEmptyPasswordWarning = ('Password field is not empty');
const String kValidPasswordWarning = ('Please enter valid password(Min. 8 Character)');
const String kEqualPasswordWarning = ('Passwords do not match, Please check');
const String kHaveAccount = ('Do not have an account? ');
const String kLoginSuccess = ('Login Successfully');
const String kEmail = ('Email');
const String kPassword = ('Password');
const String kConfirmPassword = ('Confirm Password');
const String kFirstName = ('First Name');
const String kLastName = ('Last Name');
const String kLogin = ('Login');
const String kSignUp = ('Sign Up');

const double kFontSize = 15;

const Widget kInputMargin = SizedBox(height: 20,);
const Widget kLogoMargin = SizedBox(height: 75,);
const Widget kBottomMargin = SizedBox(height: 15,);
const Widget kButtonMargin = SizedBox(height: 35,);
const Widget kLogoHeight = SizedBox(height: 55,);

BoxShadow kBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  spreadRadius: 2,
  blurRadius: 8,
  offset: Offset(0, 0),
);

