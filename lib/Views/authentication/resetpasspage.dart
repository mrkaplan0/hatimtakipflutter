import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

final isPassReset = StateProvider<bool>((ref) => false);

class ResetPasswordPage extends ConsumerWidget {
  ResetPasswordPage({super.key});

  final String _resetButtonText = tr("Sifreyi Sifirlayin");
  final String _emailLabelText = tr("Email");
  final String _emailHintText = tr('Emailinizi giriniz.');
  final String _invalidMail = tr("Gecersiz email adresi");
  final String _canNotNilText = tr("Bu alan bos birakilamaz.");
  final String _goBackButtonText = tr("Geri don");
  final String _weSendedEmailText =
      tr("Size bir sifirlama maili gönderdik. E-mailinizi kontrol edin.");

  final TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_resetButtonText),
      ),
      body: Column(children: [
        Center(
          child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (ref.watch(isPassReset) == false) ...[
                    emailFormfield(context),
                  ],
                  if (ref.watch(isPassReset) == true) ...[
                    Text(_weSendedEmailText)
                  ],
                  const SizedBox(height: 20),
                  CustomButton(
                      btnText: ref.watch(isPassReset) == false
                          ? _resetButtonText
                          : _goBackButtonText,
                      onPressed: () {
                        ref.watch(isPassReset) == false
                            ? _resetPassword(context, ref)
                            : goToRouterPage(context, ref);
                      }),
                ],
              )),
        ),
      ]),
    );
  }

  TextFormField emailFormfield(BuildContext context) {
    return TextFormField(
      controller: _controllerEmail,
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
    );
  }

  void _resetPassword(BuildContext context, WidgetRef ref) async {
    if (_controllerEmail.text.isNotEmpty) {
      ref.read(isPassReset.notifier).state = await ref
          .read(authServiceProvider)
          .resetPassword(_controllerEmail.text);
    }
  }

  void goToRouterPage(BuildContext context, WidgetRef ref) {
    ref.invalidate(isPassReset);
    Navigator.popAndPushNamed(context, "/RouterPage");
  }
}
