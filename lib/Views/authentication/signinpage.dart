import 'package:flutter/material.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/Views/Widgets/header.dart';
import 'package:hatimtakipflutter/Views/homepage/homepage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late String _email, _password, _username;
  final String _usernameLabelText = "Kullanıcı Adı";
  final String _usernameHintText = 'Kullanıcı adınızı giriniz.';
  final String _emailLabelText = "E-mail";
  final String _emailHintText = 'E-mailinizi giriniz.';
  final String _passwordLabelText = 'Şifre';
  final String _passwordHintText = 'Şifrenizi giriniz.';
  final String _signUpButtonText = "Kaydolun";

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
                        //username formfield
                        usernameFormfield(),
                        //email formfield
                        emailFormfield(),

                        // password formfield
                        passwordFormfield(),

                        const SizedBox(height: 20),
                        CustomButton(
                            btnText: _signUpButtonText, onPressed: saveUser),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
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

  TextFormField usernameFormfield() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: _usernameLabelText,
          hintText: _usernameHintText,
          suffixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.person),
          )),
      onSaved: (String? username) {
        _username = username!;
      },
    );
  }

  saveUser() {
    //Navigator.popAndPushNamed(context, '/RouterPage');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
