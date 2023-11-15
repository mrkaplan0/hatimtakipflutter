import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/Views/Widgets/header.dart';
import 'package:hatimtakipflutter/Views/authentication/signinpage.dart';

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
  final String _invalidMail = "Geçersiz email adresi";
  final String _invalidPassword = "Sifre en az 6 karakter olmalı.";
  final String _canNotNilText = "Bu alan bos birakilamaz.";

  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

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
                const SizedBox(height: 350, child: HeaderWidget()),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //email formfield
                        emailFormfield(context),

                        // password formfield
                        passwordFormfield(context),

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
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
            child: Text(_signUpButtonText))
      ],
    );
  }

  TextButton signInAnonymoslyButton() {
    return TextButton(onPressed: () {}, child: Text(_signInAnonymouslyText));
  }

  TextFormField passwordFormfield(BuildContext context) {
    return TextFormField(
      focusNode: focusNode3,
      initialValue: "1234555",
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
      validator: (value) => value!.length < 6 ? _invalidPassword : null,
      onFieldSubmitted: (value) {
        focusNode3.unfocus();
      },
      onSaved: (String? gelenSifre) {
        _password = gelenSifre!;
      },
    );
  }

  TextFormField emailFormfield(BuildContext context) {
    return TextFormField(
      focusNode: focusNode2,
      initialValue: "kaplan@kaplan.com",
      keyboardType: TextInputType.emailAddress,
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
      validator: (String? mail) {
        if (mail == "") {
          return _canNotNilText;
        } else {
          if (!mail!.contains("@")) {
            return _invalidMail;
          }
        }
      },
      onFieldSubmitted: (value) {
        focusNode2.unfocus();
        FocusScope.of(context).requestFocus(focusNode3);
      },
      onSaved: (String? gelenMail) {
        _email = gelenMail!;
      },
    );
  }
}
