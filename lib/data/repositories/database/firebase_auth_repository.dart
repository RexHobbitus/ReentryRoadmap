import 'package:reentry_roadmap/data/models/app_user_json.dart';

import '../../../domain/entities/app_user.dart';
import '../../../domain/repositories/database/authentication_repository.dart';
import 'firebase_collection.dart';

class FirebaseAuthRepository extends FirebaseCollection
    implements AuthenticationRepository {
  @override
  Future<AppUser> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    /// first authenticate user
    var userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    ///  get user record
    var userDocument =
        await usersCollection.doc(userCredential.user?.uid).get();

    /// get data of user  => convert to Model class (data layer) => then entity (domain layer) => return;
    return AppUserJson.fromJson(userDocument.data() as Map<String, dynamic>)
        .toDomain();
  }

  @override
  Future<AppUser> createAccount(
      {required String email, required String password}) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> forgetPassword({required String email}) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> logout({required String email}) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
