import 'package:nsutbazaar/repositories/firebase_repo.dart';
import 'package:nsutbazaar/repositories/firebase_storage_repo.dart';

class UserControl {
  final FirebaseStorageRepo _firebaseStoreageRepo;
  final FirebaseRepository _authRepository;

  UserControl(
    this._firebaseStoreageRepo,
    this._authRepository,
  );

  void editUserInfo(
      String fullname, String username, int phoneNumber, String rollNumber, String profileImg){
    if (fullname != "") {
      _authRepository.userModel.fullname = fullname;
    }
    if (username != "") {
      _authRepository.userModel.username = username;
    }

    if (phoneNumber != 0) {
      _authRepository.userModel.phoneNumber = phoneNumber;
    }
    if (rollNumber != "") {
      _authRepository.userModel.rollNumber = rollNumber;
    }
    _authRepository.userModel.profileImg = profileImg;
    _authRepository.updateUserModel();
  }
}
