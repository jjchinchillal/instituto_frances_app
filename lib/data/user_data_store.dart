class UserDataStore {
  static final UserDataStore _instance = UserDataStore._internal();
  factory UserDataStore() => _instance;
  UserDataStore._internal();

  Map<String, dynamic>? userData;

  void setUserData(Map<String, dynamic> data) {
    userData = data;
  }

  Map<String, dynamic>? getUserData() {
    return userData;
  }

  void clear() {
    userData = null;
  }
}
