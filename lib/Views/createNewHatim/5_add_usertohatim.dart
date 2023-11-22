import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

final filteredUsers = StateProvider<List<MyUser>>((ref) {
  List<MyUser> filteredUsers = [];
  return filteredUsers;
});

// ignore: must_be_immutable
class AddUserToHatimPage extends ConsumerWidget {
  int selectedPartIndex;
  AddUserToHatimPage({super.key, required this.selectedPartIndex});
  List<MyUser> userList = [];
  final String _addUserToHatimTitle = "Katılımcı Ekle";
  final String _searchHintText = "Katılımcı ara...";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    userList = ref.watch(fetchUsers).value ?? [];
    var favoritesPeople =
        ref.read(userViewModelProvider).user!.favoritesPeople ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(_addUserToHatimTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                onChanged: (value) {
                  // Her harf girişi değiştiğinde, listede filtreleme yap
                  // Bu örnekte, kullanıcı adında girilen değeri içerenleri filtrele
                  filterUsers(ref, value);
                },
                decoration: InputDecoration(
                  // labelText: _searchLabel,
                  hintText: _searchHintText,
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ref.watch(filteredUsers).length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    ref.read(hatimPartsProvider).updateOwnerOfPart(
                        selectedPartIndex, ref.watch(filteredUsers)[index]);
                    ref.invalidate(filteredUsers);
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text(ref.watch(filteredUsers)[index].username),
                  ),
                );
              },
            ),
          ),

          //for favorites People
          Expanded(
              child: Wrap(
            spacing: 4.0,
            children: [
              for (int i = 0; i < favoritesPeople.length; i++) ...[
                ElevatedButton(
                    onPressed: () {
                      ref.read(hatimPartsProvider).updateOwnerOfPart(
                          selectedPartIndex, favoritesPeople[i]);
                      ref.invalidate(filteredUsers);
                      Navigator.pop(context);
                    },
                    child: Text(favoritesPeople[i].username))
              ]
            ],
          )),
        ],
      ),
    );
  }

  void filterUsers(WidgetRef ref, String query) {
    // Kullanıcı listesini filtrele
    // Bu örnekte, kullanıcı adında girilen değeri içerenleri filtrele
    ref.read(filteredUsers.notifier).state = userList
        .where(
            (user) => user.username.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
