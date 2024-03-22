import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndiviPageViewModel extends StateNotifier<bool> {
  IndiviPageViewModel(bool state) : super(state);

//in individual Page to activate undo button if page is deleted.
  void makeTrue() {
    state = true;
  }

  void makeFalse() {
    state = false;
  }
}
