import '../../../domain/repositories/database/remote_database_repository.dart';

class RestApiRepository implements RemoteDatabaseRepository{

  @override
  Future<void> login({required String email, required password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

}