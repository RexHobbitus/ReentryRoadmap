abstract class LocalDatabaseRepository{
  Future<void> initialize();
  Future<void> saveToken();
  Future<String> getToken();

}