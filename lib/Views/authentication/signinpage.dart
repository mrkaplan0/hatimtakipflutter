import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class SignInPage extends ConsumerWidget {
  SignInPage({super.key});

  late String _email, _password, _username;
  final String _usernameLabelText = tr("Kullanici Adi");
  final String _usernameHintText = tr('Kullanici adinizi giriniz.');
  final String _emailLabelText = tr("Email");
  final String _emailHintText = tr('Emailinizi giriniz.');
  final String _passwordLabelText = tr('Sifre');
  final String _passwordHintText = tr('Sifrenizi giriniz.');
  final String _signUpButtonText = tr("Kaydolun");
  final String _canNotNilText = tr("Bu alan bos birakilamaz.");
  final String _invalidMail = tr("Gecersiz email adresi");
  final String _invalidPassword = tr("Sifre en az 6 karakter olmali.");
  final String _usernameNotUsableText = tr(
      "Bu kullanici adi kullaniliyor! / Kullanici adi alani bos birakilamaz.");
  final String _usernameCanNotNilText = tr("Bu alan bos birakilamaz.");
  List<MyUser> userList = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(ref.watch(userViewModelProvider).state.toString());
    userList = ref.watch(fetchUsers).value ?? [];
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child:
                          Image(image: AssetImage('assets/images/logo.jpeg'))),
                ),
                Text(
                  _signUpButtonText,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //username formfield
                        usernameFormfield(context, ref),
                        //email formfield
                        emailFormfield(context),

                        // password formfield
                        passwordFormfield(context),

                        const SizedBox(height: 20),
                        CustomButton(
                            btnText: _signUpButtonText,
                            onPressed: () async {
                              saveUser(context, ref);
                            }),
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

  TextFormField usernameFormfield(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: _usernameLabelText,
          hintText: _usernameHintText,
          errorText: ref.watch(isUsernameNotAvailableProv) == true
              ? _usernameNotUsableText
              : null,
          suffixIcon: const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.person),
          )),
      validator: (String? username) {
        return username != "" ? null : _usernameCanNotNilText;
      },
      onChanged: (value) {
        ref.watch(isUsernameNotAvailableProv.notifier).state = userList.any(
            (user) =>
                user.username.trim().toLowerCase() ==
                value.trim().toLowerCase());
      },
    );
  }

  saveUser(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate() &&
        ref.watch(isUsernameNotAvailableProv.notifier).state == false &&
        _controller.text.isNotEmpty) {
      _username = _controller.text;
      _formKey.currentState?.save();
      var createdUser = await ref
          .read(userViewModelProvider)
          .createUserWithEmailAndPassword(_email, _password, _username);
      if (createdUser != null) {
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, '/RouterPage');
      }
    }
  }
}
