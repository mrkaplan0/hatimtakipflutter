import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndiviPageViewModel extends StateNotifier<bool> {
  IndiviPageViewModel(bool state) : super(state);

  void makeTrue() {
    state = true;
    print(state);
  }

  void makeFalse() {
    state = false;
    print(state);
  }
}
