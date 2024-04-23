// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/Views/Widgets/header.dart';
import 'package:hatimtakipflutter/Views/authentication/resetpasspage.dart';
import 'package:hatimtakipflutter/Views/authentication/signinpage.dart';
import 'package:hatimtakipflutter/main.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late String _email, _password;
  final String _emailLabelText = tr("Email");
  final String _emailHintText = tr('Emailinizi giriniz.');
  final String _passwordLabelText = tr('Sifre');
  final String _passwordHintText = tr('Sifrenizi giriniz.');
  final String _haveUaccountText = tr("Hesabiniz yok mu?");
  final String _signUpButtonText = tr("Kaydolun");
  final String _loginButtonText = tr("Giris Yap");
  final String _canNotNilText = tr("Bu alan bos birakilamaz.");
  final String _invalidMail = tr("Gecersiz email adresi");
  final String _invalidPassword = tr("Sifre en az 6 karakter olmali.");
  final String _resetPassButtonText = tr("Sifremi unuttum");

  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                //Header
                const SizedBox(height: 300, child: HeaderWidget()),

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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            resetPassButton(context),
                          ],
                        ),
                        CustomButton(
                            btnText: _loginButtonText,
                            onPressed: () async {
                              _login(context);
                            }),

                        const SizedBox(height: 50),

                        doYouHaveAccountButton(context)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  TextButton resetPassButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResetPasswordPage()));
        },
        child: Text(_resetPassButtonText));
  }

  TextFormField passwordFormfield(BuildContext context) {
    return TextFormField(
      focusNode: focusNode3,
      // initialValue: "1234555",
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
      // initialValue: "kaplan@kaplan.com",
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
        return null;
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

  Row doYouHaveAccountButton(BuildContext context) {
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

  _login(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        var createdUser = await ref
            .read(userViewModelProvider)
            .signInWithEmailAndPassword(_email, _password);
        if (createdUser != null) {
          if (mounted) {
            Navigator.of(context).popAndPushNamed("/RouterPage");
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e);
      _showErrorDialog(context, errorMessage);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text("${'Hata'.tr()}!"),
          content: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Kapat".tr()))
          ],
        );
      },
    );
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.'.tr();
      case 'wrong-password':
        return 'Incorrect password.'.tr();
      case 'invalid-email':
        return 'Invalid email address.'.tr();
      case 'user-disabled':
        return 'This user account has been disabled.'.tr();
      case 'email-already-in-use':
        return 'The email has already been registered. Please login or reset your password.'
            .tr();
      default:
        return 'An error occurred: ${e.message}';
    }
  }
}
