
import 'package:flutter/cupertino.dart';

import '../../../domain/repositories/database/local_database_repository.dart';

class HiveDatabaseRepository implements LocalDatabaseRepository{
  @override
  Future<String> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<void> saveToken() {
    // TODO: implement saveToken
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() async{
    debugPrint("++++++++++ INITIALIZED LOCAL DATABASE +++++++++++");
  }

}