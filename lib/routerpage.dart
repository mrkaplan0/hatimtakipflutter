import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Viewmodels/user_viewmodel.dart';
import 'package:hatimtakipflutter/Views/authentication/add_usernamepage.dart';
import 'package:hatimtakipflutter/Views/authentication/loginpage.dart';
import 'package:hatimtakipflutter/Views/homepage/homepage.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

class RouterPage extends ConsumerWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userViewModelProvider).user;

    if (ref.watch(userViewModelProvider.notifier).state == ViewState.idle) {
      if (user == null) {
        debugPrint("router null user");
        return const LoginPage();
      } else if (user.username == "") {
        debugPrint("router isimisz user $user");
        return AddUsernamePage();
      } else {
        debugPrint("router home user $user");
        return const HomePage();
      }
    } else {
      return Container(
        color: Colors.white,
        child: const Center(
            child: CircularProgressIndicator(
          color: Colors.cyan,
        )),
      );
    }
  }
}
