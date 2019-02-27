class CodeTanslater {
  String analyse(int major, int minor) {
    int temp = major % 256;
    int battery = minor ~/ 256;
    int state = major ~/ 256;
    String stateString = state.toRadixString(2);

    print('major: $major, minor: $minor');
    return 'state: $stateString, temp: $temp, battery: $battery';
  }
}