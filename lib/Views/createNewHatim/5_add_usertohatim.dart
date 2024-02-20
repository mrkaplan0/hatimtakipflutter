// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Models/hatimpartmodel.dart';
import 'package:hatimtakipflutter/Models/myuser.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

final filteredUsers = StateProvider.autoDispose<List<MyUser>>((ref) {
  List<MyUser> filteredUsers = [];
  return filteredUsers;
});

// coming here
// from cuzSettings -> to add
// from detailsPage -> to update
enum FromPage { cuzSettings, hatimDetails }

// ignore: must_be_immutable
class AddUserToHatimPage extends ConsumerWidget {
  FromPage fromPage;
  int selectedPartIndex;
  HatimPartModel? part;
  AddUserToHatimPage(
      {super.key,
      required this.selectedPartIndex,
      required this.fromPage,
      this.part});

  List<MyUser> userList = [];
  final String _addUserToHatimTitle = tr("Katilimci Ekle");
  final String _searchHintText = tr("Katilimci ara...");

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
                  hintText: _searchHintText,
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ref.watch(filteredUsers).length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    if (fromPage == FromPage.cuzSettings) {
                      ref.read(hatimPartsProvider).updateOwnerOfPart(
                          selectedPartIndex, ref.watch(filteredUsers)[index]);
                    } else if (fromPage == FromPage.hatimDetails) {
                      await ref.read(firestoreProvider).updateOwnerOfPart(
                          ref.watch(filteredUsers)[index], part!);
                      ref.invalidate(fetchHatimParts);
                    }

                    // ignore: use_build_context_synchronously
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
                    onPressed: () async {
                      if (fromPage == FromPage.cuzSettings) {
                        ref.read(hatimPartsProvider).updateOwnerOfPart(
                            selectedPartIndex, favoritesPeople[i]);
                      } else if (fromPage == FromPage.hatimDetails) {
                        await ref
                            .read(firestoreProvider)
                            .updateOwnerOfPart(favoritesPeople[i], part!);
                        ref.invalidate(fetchHatimParts);
                      }

                      // ignore: use_build_context_synchronously
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
    ref.read(filteredUsers.notifier).state = userList
        .where(
            (user) => user.username.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
