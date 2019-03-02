class ChairState {
  int major;
  int minor;
  int battery;
  int temprature;
  String state;

  ChairState(int majorValue, int minorValue) {
    major = majorValue;
    minor = minorValue;
    battery = minor ~/ 256;
    temprature = major % 256;
    if (majorValue == 0) state = '000000';
    else state = (major ~/ 256).toRadixString(2);
  }
}