import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:meruem/views/verify_user.dart';

import '../app_styles.dart';
import 'home_screen.dart';


class Otp extends StatefulWidget {
  static String rootName = '/otp';

  const Otp({
    required Key key,
  }) : super(key: key);

  @override
  _OtpState createState() => new _OtpState();
}

class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  // Constants
  final int time = 60;
  late AnimationController _controller;

  // Variables
  late Size _screenSize;
  int? _currentDigit;
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;

  late Timer timer;
  late int totalTimeInSeconds;
  late bool _hideResendButton;
  bool loadVerification =false;
  bool loadRequest = false;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;



// Return "Verification Code" label
  get _getVerificationCodeLabel {
    return new Text(
      "Verification Code",
      textAlign: TextAlign.center,
      style: new TextStyle(
          fontSize: 28.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "Montserrat"),
    );
  }

// Return "Email" label
  get _getEmailLabel {
    return new Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: new Text(
        "Veuillez entrer le code de confirmation qui a été envoyé par email",
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontFamily: "Montserrat"),
      ),
    );
  }

// Return "OTP" input field
  get _getInputField {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
      ],
    );
  }

// Returns "OTP" input part
  get _getInputPart {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getVerificationCodeLabel,
        _getEmailLabel,
        _getInputField,
        _hideResendButton ? _getTimerText : _getResendButton,
        _getOtpKeyboard
      ],
    );
  }

// Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: new Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.access_time, color: kSecondaryColor),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 15.0, kSecondaryColor)
          ],
        ),
      ),
    );
  }

// Returns "Resend" button
  get _getResendButton {
    return new InkWell(
      child: new Container(
        height: 42,
        width: 150,
        color: kSecondaryColor,
        alignment: Alignment.center,
        child: new Text(
          "Renvoyer le code",
          style:
              new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      onTap: () async {
        setState(() {
          _hideResendButton = true;
          totalTimeInSeconds = time;
        });
        _startCountdown();
        Fluttertoast.showToast(
            msg: "Code renvoyé veuillez verifier",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0
        );

        // Resend you OTP via API or anything
      },
    );
  }

// Returns "Otp" keyboard
  get _getOtpKeyboard {
    return new Container(
        height: _screenSize.width - 80,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardActionButton(
                      label: loadRequest ? LoadingIndicator(indicatorType: Indicator.ballClipRotateMultiple,colors: [kPrimaryColor], strokeWidth: 2) :Icon(
                        Icons.check_circle,
                        color: kPrimaryColor,
                        size: 32.0,
                      ),
                      onPressed: () async {
                        List<int> beta = [
                          _firstDigit!,
                          _secondDigit!,
                          _thirdDigit!,
                          _fourthDigit!,
                        ];
                        if (beta.join("").indexOf('null') == -1 && !loadRequest) {
                          print(beta.join(""));
                          setState(() {
                            loadRequest = true;
                          });
                          //final verify = await consumeAPI.verifyTwilio(beta.join(""));

                          Timer(Duration(seconds: 3), () {
                            setState(() {
                              loadRequest = false;
                            });
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => VerifyUser(key: UniqueKey(), redirect: HomeScreen.rootName,)));
                        }
                      }),
                  /*new SizedBox(
                  width: 80.0,
                ),*/
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: new Icon(
                        Icons.backspace,
                        color: kSecondaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_fourthDigit != null) {
                            _fourthDigit = null;
                          } else if (_thirdDigit != null) {
                            _thirdDigit = null;
                          } else if (_secondDigit != null) {
                            _secondDigit = null;
                          } else if (_firstDigit != null) {
                            _firstDigit = null;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

// Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;

    super.initState();
    loadInfo();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  loadInfo() async {
    /*final user = await DBProvider.db.getClient();
    setState(() {
      newClient = user;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: Container(
        width: _screenSize.width,
//        padding: new EdgeInsets.only(bottom: 16.0),
        child: _getInputPart,
      ),
    );
  }

// Returns "Otp custom text field"
  Widget _otpTextField(int? digit) {
    return new Container(
      width: 25.0,
      height: 45.0,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: kPrimaryColor,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: kPrimaryColor,
      ))),
    );
  }

// Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({required String label, required VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 80.0,
          width: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: kSecondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

// Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({required Widget label, required VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

// Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }


}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  final double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration!;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, child) {
          return Text(
            timerString,
            style: TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
