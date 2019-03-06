class ChairState {
  bool active = false;
  int major;
  int minor;
  int battery;
  int temprature;
  String state;
  bool buckle = true;
  bool lfix = true;
  bool rfix = true;
  bool routation = true;
  bool pad = true;
  bool leg = true;

  ChairState(int majorValue, int minorValue) {
    setValue(majorValue, minorValue);
  }

  void setValue(int majorValue, int minorValue) {
    if (majorValue > 0 && minorValue > 0) {
      active = true;
    }
    major = majorValue;
    minor = minorValue;
    battery = minor ~/ 256;
    temprature = major % 256;
    int stateInt = (major ~/ 256);
    if (majorValue == 0) state = '000000';
    else state = stateInt.toRadixString(2);

    buckle = (stateInt >> 5) % 2 == 1;
    lfix = (stateInt >> 4) % 2 == 1;
    rfix = (stateInt >> 3) % 2 == 1;
    routation = (stateInt >> 2) % 2 == 1;
    pad = (stateInt >> 1) % 2 == 1;
    leg = stateInt % 2 == 1;
    print('buckle: $buckle | lfix: $lfix | rfix: $rfix | routation: $routation | pad: $pad | leg: $leg');
  }

  void deactive() {
    active = false;
  }
}