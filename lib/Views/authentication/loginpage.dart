import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/Views/Widgets/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email, _password;
  final String _emailLabelText = "E-mail";
  final String _emailHintText = 'E-mailinizi giriniz.';
  final String _passwordLabelText = 'Şifre';
  final String _passwordHintText = 'Şifrenizi giriniz.';
  final String _signInAnonymouslyText = "Üye Olmadan Devam Et";
  final String _haveUaccountText = "Hesabınız yok mu?";
  final String _signUpButtonText = "Kaydolun";
  final String _loginButtonText = "Giriş Yap";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Header
                const HeaderWidget(),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //email formfield
                        emailFormfield(),

                        // password formfield
                        passwordFormfield(),

                        const SizedBox(height: 20),
                        CustomButton(
                            btnText: _loginButtonText, onPressed: () {}),
                        const SizedBox(height: 20),
                        const Text("&"),

                        //signIn anonymously
                        signInAnonymoslyButton(),

                        const SizedBox(height: 20),

                        doYouHaveAccountButton()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Row doYouHaveAccountButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_haveUaccountText),
        TextButton(onPressed: () {}, child: Text(_signUpButtonText))
      ],
    );
  }

  TextButton signInAnonymoslyButton() {
    return TextButton(onPressed: () {}, child: Text(_signInAnonymouslyText));
  }

  TextFormField passwordFormfield() {
    return TextFormField(
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: _passwordLabelText,
          hintText: _passwordHintText,
          suffixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.lock_outline_rounded),
          )),
      onSaved: (String? gelenSifre) {
        _password = gelenSifre!;
      },
    );
  }

  TextFormField emailFormfield() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: _emailLabelText,
          hintText: _emailHintText,
          suffixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.mail_outline_rounded),
          )),
      onSaved: (String? gelenMail) {
        _email = gelenMail!;
      },
    );
  }
}
