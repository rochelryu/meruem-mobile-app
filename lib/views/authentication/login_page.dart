import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../size_configs.dart';
import '../../validators.dart';
import '../pages.dart';
import '../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  static String rootName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  void onSubmit() {
    _loginKey.currentState!.validate();
  }

  List<Map<String, dynamic>> _loginFocusNodes = [
    {"focus": FocusNode(), "controller": new TextEditingController()},
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.blockSizeV!;
    return Stack(
      children: [
        Positioned(
          bottom: height * 3,
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            child: Image.asset('assets/images/auth/login_bg.png'),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [

                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Connexion rapide',
                                    style: kBodyText3,
                                  ),
                                  Divider(
                                    height: 30,
                                    color: kPrimaryColor.withOpacity(0.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Form(
                                      key: _loginKey,
                                      child: Column(
                                        children: [
                                          MyTextFormField(
                                            hint: 'Numero',
                                            icon: Icons.phone_android,
                                            fillColor: kScaffoldBackground,
                                            inputType:
                                                TextInputType.phone,
                                            inputAction: TextInputAction.next,
                                            focusNode: _loginFocusNodes[0]["focus"],
                                            controller: _loginFocusNodes[0]["controller"],
                                            validator: numberValidator,
                                          ),
                                          MyTextButton(
                                            buttonName: 'Connexion',
                                            onPressed: onSubmit,
                                            bgColor: kPrimaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Vous n'avez pas de compte ? "),
                                      SmallTextButton(
                                        buttonText: 'Inscrivez-vous',
                                        page: SignUpPage(),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
