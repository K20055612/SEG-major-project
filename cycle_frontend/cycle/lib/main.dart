import 'package:cycle/pages/home_page.dart';
import 'package:cycle/pages/edit_user_profile.dart';
import 'package:cycle/pages/navigation_page.dart';
import 'package:cycle/pages/signup_login_pages/forgot_password_page.dart';
import 'package:cycle/pages/signup_login_pages/login_page.dart';
import 'package:cycle/pages/terms_policy_pages/privacy_policy_page.dart';
import 'package:cycle/pages/signup_login_pages/signup_page.dart';
import 'package:cycle/pages/terms_policy_pages/terms_of_use_page.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cycle/pages/slide_up_widget.dart';
import 'package:cycle/pages/menu.dart';
import 'package:google_fonts/google_fonts.dart';

// Default page for users that are not logged in.
String _defaultPageId = LoginPage.id;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Checks cache if user's credentials are still saved so that user does not need
  // to login every time the app is opened.
  bool _isLoggedIn = await UserDetailsHelper.isLoggedIn();
  if (_isLoggedIn) {
    _defaultPageId = MainPage.id;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: HomePage.id,
      routes: {
        SignupPage.id: (context) => SignupPage(),
        TermsOfUsePage.id: (context) => TermsOfUsePage(),
        PrivacyPolicyPage.id: (context) => PrivacyPolicyPage(),
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => MainPage(),
        HomePage.id: (context) => HomePage(),
        EditProfilePage.id: (context) => EditProfilePage(),
        ForgotPasswordPage.id: (context) => ForgotPasswordPage(),
        NavigationPage.id: (context) => NavigationPage(),
      },
    );
  }
}
