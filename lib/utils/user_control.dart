import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';

class UserControl {
  final FirebaseStoreageRepo _firebaseStoreageRepo;
  final FirebaseRepository _authRepository;

  UserControl(
    this._firebaseStoreageRepo,
    this._authRepository,
  );


  void editUserInfo(String username, String phone) {
    if(username !=""){_authRepository.userModel.username = username;}
    if(phone != ""){_authRepository.userModel.phoneNumber = phone as int;}
    _authRepository.updateUserModel();
  }
}
