import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Services/auth_service.dart';
import 'package:hatimtakipflutter/Viewmodels/user_viewmodel.dart';

final authServiceProvider =
    Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

final userViewModelProvider = ChangeNotifierProvider((_) => UserViewModel());
