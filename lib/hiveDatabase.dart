import 'package:hive_flutter/hive_flutter.dart';
import 'sharedPreference.dart';
import 'package:latihanresponsi/dataModel.dart';


class HiveDatabase {
  Box<DataModel> _localDB = Hive.box<DataModel>("data");

  void addData(DataModel data) {
    _localDB.add(data);
  }

  int getLength() {
    return _localDB.length;
  }

  bool checkLogin(String username, String password) {
    bool found = false;
    for (int i = 0; i < getLength(); i++) {
      final storedData = _localDB.getAt(i)!;

      if (username == storedData.username &&
          DataModel.encryptPassword(password) == storedData.encryptedPassword) {
        SharedPreference().setLogin(username);
        print("Login Success");
        found = true;
        break;
      } else {
        found = false;
      }
    }

    return found;
  }
}