import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:recipe/UI/View/recipe_list/list_view.dart';
import 'package:recipe/constants.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primaryColor: kPrimaryColor),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animateController;
  late AnimationController _secondStepController;
  late AnimationController _thirdStepController;
  late AnimationController _fourStepController;

  int curIndex = 0;
  double overall = 2.0;
  String overallStatus = "Normal";
  String usingTimes = 'No';
  int? usingTimes2;


  List<SecondQuestion> usingCollection = [
    SecondQuestion('no', 'No'),
    SecondQuestion('yes', 'Yes')
  ];
  List<FourQuestion> usingCollection2 = [
    FourQuestion(15, '0-15 min.'),
    FourQuestion(45, '15-45 min.'),
    FourQuestion(9999, '45+ min.')
  ];

  late Animation<double> longPressAnimation;
  late Animation<double> secondTransformAnimation;
  late Animation<double> thirdTransformAnimation;
  late Animation<double> fourTransformAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _secondStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _thirdStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fourStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    fourTransformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _fourStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    secondTransformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _secondStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    thirdTransformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _thirdStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));


    _secondStepController.addListener(() {
      setState(() {});
    });

    _thirdStepController.addListener(() {
      setState(() {});
    });

    _fourStepController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animateController.dispose();
    _secondStepController.dispose();
    _thirdStepController.dispose();
    _fourStepController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startSecondStepAnimation() async {
    try {
      await _secondStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startThirdStepAnimation() async {
    try {
      await _thirdStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFourStepAnimation() async {
    try {
      await _fourStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 32.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted
          ? BottomAppBar(
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    curIndex += 1;
                    if (curIndex == 1) {
                      _startSecondStepAnimation();
                    } else if (curIndex == 2) {
                      _startThirdStepAnimation();
                    } else if (curIndex == 3) {
                      _startFourStepAnimation();
                    }else if (curIndex == 4){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                          builder:
                          (BuildContext context) => RecipeListView(overallStatus, usingTimes, thirdQuestionList, usingTimes2)));
                    }
                  });
                },
                child: Center(
                    child: Text(
                  curIndex < 3 ? 'Continue' : 'Finish',
                  style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
                )),
              ),
            ))
          : null,
    );
  }

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30.0),
          height: 10.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(4, (int index) {
              return Container(
                decoration: BoxDecoration(
                  color: index <= curIndex ? kPrimaryColor : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                height: 10.0,
                width: (_width - 32.0 - 15.0) / 4.0,
                margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
              );
            }),
          ),
        ),
        curIndex == 0
            ? _getFirstStep()
            : curIndex == 1
                ? _getSecondStep()
                : curIndex == 2
                    ? _getThirdStep()
                    : _getFourStep(),
      ],
    );
  }

  Widget _getFirstStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Question 1'),
            Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text('What is your nutritional preference?')),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                overallStatus,
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Slider(
                  activeColor: kPrimaryColor,
                  inactiveColor: kPrimaryColor,
                  value: overall,
                  onChanged: (value) {
                    setState(() {
                      overall = value.round().toDouble();
                      _getOverallStatus(overall);
                    });
                  },
                  label: '${overall.toInt()}',
                  divisions: 30,
                  min: 1.0,
                  max: 3.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getSecondStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - secondTransformAnimation.value), 0.0),
          child: Opacity(
            opacity: secondTransformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 2'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('Do you follow any diet?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 108.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  usingTimes = using.identifier;
                                });
                              },
                              child: Container(
                                height: 50.0,
                                color: usingTimes == using.identifier
                                    ? kPrimaryColor.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: kPrimaryColor,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (value) {
                                              setState(() {
                                                usingTimes = value as String;
                                              });
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                    Divider(
                                      height: index < usingCollection.length
                                          ? 1.0
                                          : 0.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<ThirdQuestion> thirdQuestionList = [
    ThirdQuestion('Meat', false),
    ThirdQuestion('Chicken', false),
    ThirdQuestion('Tomato', false),
    ThirdQuestion('Potato', false),
    ThirdQuestion('Pasta', false),
    ThirdQuestion('Union', false),
    ThirdQuestion('Chili', false),
    ThirdQuestion('Mushroom', false),
    ThirdQuestion('Oil', false),
  ];
  Widget _getThirdStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - thirdTransformAnimation.value), 0.0),
          child: Opacity(
            opacity: thirdTransformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 3'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('Which of the following ingredients do you not have?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 467.0,
                      child: Card(
                        child: Column(
                          children: List.generate(thirdQuestionList.length,
                              (int index) {
                            ThirdQuestion question = thirdQuestionList[index];
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTapUp: (detail) {
                                    setState(() {
                                      question.isSelected =
                                          !question.isSelected;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    color: question.isSelected
                                        ? kPrimaryColor.withAlpha(100)
                                        : Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: question.isSelected,
                                            onChanged: (value) {
//                                          print(value);
                                              setState(() {
                                                question.isSelected = value!;
                                              });
                                            }),
                                        Text(question.displayContent)
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: index < thirdQuestionList.length
                                      ? 1.0
                                      : 0.0,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFourStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - fourTransformAnimation.value), 0.0),
          child: Opacity(
            opacity: fourTransformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 4'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('Which of the meal preparation times do you prefer?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 158.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection2.length,
                                  (int index) {
                                final using = usingCollection2[index];
                                return GestureDetector(
                                  onTapUp: (detail) {
                                    setState(() {
                                      usingTimes2 = using.identifier;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    color: usingTimes2 == using.identifier
                                        ? kPrimaryColor.withAlpha(100)
                                        : Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                                activeColor: kPrimaryColor,
                                                value: using.identifier,
                                                groupValue: usingTimes2,
                                                onChanged: (value) {
                                                  setState(() {
                                                    usingTimes2 = value as int;
                                                  });
                                                }),
                                            Text(using.displayContent)
                                          ],
                                        ),
                                        Divider(
                                          height: index < usingCollection2.length
                                              ? 1.0
                                              : 0.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getOverallStatus(double overall) {
    switch (overall.toInt()) {
      case 1:
        overallStatus = 'Vegetable';
        break;
      case 2:
        overallStatus = 'Normal';
        break;
      default:
        overallStatus = 'Vegan';
        break;
    }
  }
}

class AnimationBox extends StatelessWidget {
  AnimationBox(
      {Key? key,  required this.controller,  required this.screenWidth,  required this.onStartAnimation})
      : width = Tween<double>(
          begin: screenWidth,
          end: 40.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.3,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        alignment = Tween<AlignmentDirectional>(
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topStart,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = BorderRadiusTween(
            begin: BorderRadius.circular(20.0),
            end: BorderRadius.circular(2.0)).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 40.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        movement = EdgeInsetsTween(
          begin: EdgeInsets.only(top: 0.0),
          end: EdgeInsets.only(top: 30.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        scale = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        numberOfStep = IntTween(
          begin: 1,
          end: 4,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  final VoidCallback onStartAnimation;
  final Animation<double> controller;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<AlignmentDirectional> alignment;
  final Animation<BorderRadius?> radius;
  final Animation<EdgeInsets> movement;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<int> numberOfStep;
  final double screenWidth;
  final double overral = 3.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) {
        return Stack(
          alignment: alignment.value,
          children: <Widget>[
            Opacity(
              opacity: 1.0 - opacity.value,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    height: 10.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(numberOfStep.value, (int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color:
                                index == 0 ? kPrimaryColor : Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          height: 10.0,
                          width: (screenWidth - 15.0) / 5.0,
                          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 34.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Question 1'),
                          Container(
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text(
                                  'Overall, how would you rate our service?')),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 50.0),
                            child: Text(
                              'Normal',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity:
                  controller.status == AnimationStatus.dismissed ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                  Text(
                    'Welcome, answer the questions yourself by AI.',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
                    child: Text(
                      'By answering this 3 minutes question by AI, you help us improve our service event better for you',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Opacity(
              opacity: opacity.value,
              child: GestureDetector(
                onTap: onStartAnimation,
                child: Transform.scale(
                  scale: scale.value,
                  child: Container(
                    margin: movement.value,
                    width: width.value,
                    child: GestureDetector(
                      child: Container(
                        height: height.value,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: radius.value),
                        child: Center(
                          child: controller.status == AnimationStatus.dismissed
                              ? Text(
                                  'Start',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SecondQuestion {
  final String identifier;
  final String displayContent;

  SecondQuestion(this.identifier, this.displayContent);
}

class ThirdQuestion {
  final String displayContent;
  bool isSelected;

  ThirdQuestion(this.displayContent, this.isSelected);
}

class FourQuestion {
  final int identifier;
  final String displayContent;

  FourQuestion(this.identifier, this.displayContent);
}
