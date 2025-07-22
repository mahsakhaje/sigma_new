class GlobalAppData {
  static final GlobalAppData _instance = GlobalAppData._internal();
  String _pelaksefid = "";
  String _insta = "";
  String _aparat = "";
  String _linkedin = "";
  String _telegram = "";

  String get insta => _insta;

  String get telegram => _telegram;

  set insta(String value) {
    _insta = value;
  }

  set telegram(String value) {
    _telegram = value;
  }

  factory GlobalAppData() {
    return _instance;
  }

  GlobalAppData._internal();

  // Getter method to access the value
  String get pelaksefid => _pelaksefid;

  // Setter method to update the value
  void setPelaksefid(String newValue) {
    _pelaksefid = newValue;
  }

  // Setter method to update the value
  void setInsta(String newValue) {
    _insta = newValue;
  }

  String get aparat => _aparat;

  String get linkedin => _linkedin;

  set linkedin(String value) {
    _linkedin = value;
  }

  set aparat(String value) {
    _aparat = value;
  }
}
