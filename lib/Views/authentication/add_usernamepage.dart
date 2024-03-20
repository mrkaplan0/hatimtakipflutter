import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

// ignore: must_be_immutable
class AddUsernamePage extends ConsumerWidget {
  AddUsernamePage({super.key});

  final String _usernameNotUsableText =
      tr("Bu kullanici adi kullaniliyor! / \nKullanici adi alani bos.");
  final String _usernameCanNotNilText = tr(" Bu alan bos birakilamaz.");
  final String _usernameHintText = tr('Kullanici adinizi giriniz.');
  final String _approveBtnText = tr("Onayla");
  List<MyUser> userList = [];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    userList = ref.watch(fetchUsers).value ?? [];
    debugPrint(userList.toString());
    return Scaffold(
      body: Center(
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
                usernameFormfield(context, ref),
                const SizedBox(height: 20),
                CustomButton(
                    btnText: _approveBtnText,
                    onPressed: ref.watch(isUsernameNotAvailableProv) == true
                        ? null
                        : () {
                            _saveUsername(context, ref);
                          }),
              ],
            )),
      ),
    );
  }

  TextFormField usernameFormfield(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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

  void _saveUsername(BuildContext context, WidgetRef ref) async {
    if (_controller.text.isNotEmpty &&
        ref.watch(isUsernameNotAvailableProv) == false) {
      ref.watch(userViewModelProvider.notifier).user?.username =
          _controller.text;
      await ref
          .read(firestoreProvider)
          .saveMyUser(ref.read(userViewModelProvider).user!)
          .then((value) {
        if (value) {
          Navigator.popAndPushNamed(context, "/RouterPage");
        }
      });
    }
  }
}
