abstract class RemoteDatabaseRepository{
  Future<void> login({required String email,required password});
}