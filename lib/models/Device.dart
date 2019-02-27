class Device {
  int major = 0;
  int minor = 0;

  void setValue({int major = 0, int minor = 0}) {
    this.major = major;
    this.minor = minor;
  }

  bool hasValue() {
    return major != 0 && minor != 0;
  }

  int battery() {
    if (!this.hasValue()) return 0;
    return minor ~/ 256;
  }
  
  int temprature() {
    if (!this.hasValue()) return 0;
    return major % 256;
  }

  String state() {
    if (!this.hasValue()) return '000000';
    int state = major ~/ 256;
    String stateString = state.toRadixString(2);
    return stateString;
  }
}