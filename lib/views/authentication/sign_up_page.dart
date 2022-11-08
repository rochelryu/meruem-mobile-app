import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meruem/views/otp.dart';
import 'package:meruem/views/verify_user.dart';
import 'package:meruem/views/home_screen.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../validators.dart';
import '../pages.dart';
import '../../widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  static String rootName = '/signup';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpKey = GlobalKey<FormState>();

  void onSubmit() {
    if(_signUpKey.currentState!.validate()) {
      Navigator.pushNamed(context, Otp.rootName);
    }
  }

  List<Map<String, dynamic>> _signUpFocusNodes = [
    {"focus": FocusNode(), "controller": new TextEditingController()},
    {"focus": FocusNode(), "controller": new TextEditingController()},
    {"focus": FocusNode(), "controller": new TextEditingController()},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = SizeConfig.blockSizeV!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  child:
                  SvgPicture.asset(
                      "assets/images/auth/signup.svg",
                      color: Colors.red,
                      semanticsLabel: 'illustration inscription',
                    height: 170,
                  )
                ),
                SizedBox(
                  height: height * 2,
                ),
                Text(
                  'Créer votre compte',
                  style: kTitle2,
                ),
                SizedBox(
                  height: height * 2,
                ),
                Form(
                  key: _signUpKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        fillColor: Colors.white,
                        hint: 'Nom & prénom',
                        icon: Icons.person,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                        focusNode: _signUpFocusNodes[0]["focus"],
                        controller: _signUpFocusNodes[0]["controller"],
                        validator: nameValidator,
                      ),
                      MyTextFormField(
                          hint: 'Numero (Ex: +225XXXXXXXXXX)',
                          icon: Icons.phone_android,
                          fillColor: Colors.white,
                          inputType: TextInputType.phone,
                          inputAction: TextInputAction.next,
                          focusNode: _signUpFocusNodes[1]["focus"],
                          controller: _signUpFocusNodes[1]["controller"],
                          validator: numberValidator),
                      MyTextFormField(
                          hint: 'Email',
                          icon: Icons.email_outlined,
                          fillColor: Colors.white,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          focusNode: _signUpFocusNodes[2]["focus"],
                          controller: _signUpFocusNodes[2]["controller"],
                          validator: emailValidator),

                      SizedBox(
                        height: height * 2,
                      ),
                      MyTextButton(
                        buttonName: 'Créer compte',
                        onPressed: onSubmit,
                        bgColor: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 3,
                          color: kSecondaryColor.withOpacity(0.4),
                        ),
                      ),
                      Text(
                        'Ou vous avez déjà un compte ?',
                        style: kBodyText3,
                      ),
                      Expanded(
                        child: Divider(
                          height: 3,
                          color: kSecondaryColor.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: height * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SmallTextButton(
                      buttonText: 'Connectez-vous en cliquant ici !',
                      page: LoginPage(),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
