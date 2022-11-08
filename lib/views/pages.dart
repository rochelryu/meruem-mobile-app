import 'package:flutter/cupertino.dart';

import 'otp.dart';
import 'home_screen.dart';

export './onboarding_page.dart';
export 'authentication/sign_up_page.dart';
export './authentication/login_page.dart';
export './authentication/forgot_password_page.dart';

final routes = {
  Otp.rootName: (context) => Otp(key: UniqueKey()),
  HomeScreen.rootName: (context) => HomeScreen(key: UniqueKey())
};
