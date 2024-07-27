import 'dart:collection';

// Map of brightness values to ASCII characters for various sensitivities
class AsciiCharactersBrightnessTreeMap {
  // TreeMap for range values keys -> Single ch
  SplayTreeMap<double, String> _treeMap = SplayTreeMap();
  var _keyRange = 35.1; // Default distance between 2 ch (MIN)

  AsciiCharactersBrightnessTreeMap(int charSensibility) {
    Map<double, String> selectedMap;
    switch (charSensibility) {
      case 2:
        selectedMap = _brightnessCharacterMid;
        _keyRange = 6.3;
        break;
      case 3:
        selectedMap = _brightnessCharacterMax;
        _keyRange = 2.7;
        break;
      default:
        // Default MIN Tree Map
        selectedMap = _brightnessCharacterMin;
        _keyRange = 35.1;
        break;
    }
    _treeMap = SplayTreeMap<double, String>.from(selectedMap, _compare);
  }

  // Comparator function for the TreeMap
  int _compare(double mapKey, double externalValue) {
    var halfRange = _keyRange / 2;
    if (mapKey == 250 && (externalValue >= (250 - halfRange))) return 0;
    if (mapKey == 4.3 && (externalValue < (4.3 + halfRange))) return 0;

    var temp = mapKey - externalValue;
    if (temp <= -halfRange) return 1; // Up - Brighther ch
    if (temp > halfRange) return -1; // Down - Darker ch

    return 0;
  }

  // Small ASCII character set
  final Map<double, String> _brightnessCharacterMin = {
    250: " ",
    214.9: ".",
    179.8: "*",
    144.7: "+",
    109.6: "&",
    74.5: "8",
    39.4: "#",
    4.3: "@",
  };

  // Medium ASCII character set
  final Map<double, String> _brightnessCharacterMid = {
    250: " ",
    243.7: ".",
    237.4: "'",
    231.1: ",",
    224.8: "^",
    218.5: ";",
    212.2: "+",
    205.9: "*",
    199.6: "z",
    193.3: "s",
    187: "v",
    180.7: "J",
    174.4: "|",
    168.1: "F",
    161.8: "C",
    155.5: "f",
    149.2: "3",
    142.9: "l",
    136.6: "u",
    130.3: "o",
    124: "Z",
    117.7: "x",
    111.4: "y",
    105.1: "2",
    98.8: "S",
    92.5: "q",
    86.2: "6",
    79.9: "9",
    73.6: "4",
    67.3: "O",
    61: "b",
    54.7: "A",
    48.4: "H",
    42.1: "8",
    35.8: "#",
    29.5: "B",
    23.2: "0",
    16.9: "W",
    10.6: "%",
    4.3: "@",
  };

  // Large ASCII character set
  final Map<double, String> _brightnessCharacterMax = {
    250: " ",
    247.3: "`",
    244.6: ".",
    241.9: "-",
    239.2: "'",
    236.5: ":",
    233.8: "_",
    231.1: ",",
    228.4: "^",
    225.7: "=",
    223: ";",
    220.3: ">",
    217.6: "<",
    214.9: "+",
    212.2: "!",
    209.5: "r",
    206.8: "c",
    204.1: "*",
    201.4: "/",
    198.7: "z",
    196: "?",
    193.3: "s",
    190.6: "L",
    187.9: "T",
    185.2: "v",
    182.5: ")",
    179.8: "J",
    177.1: "7",
    174.4: "(",
    171.7: "|",
    169: "F",
    166.3: "i",
    163.6: "{",
    160.9: "C",
    158.2: "}",
    155.5: "f",
    152.8: "I",
    150.1: "3",
    147.4: "1",
    144.7: "t",
    142: "l",
    139.3: "u",
    136.6: "[",
    133.9: "n",
    131.2: "e",
    128.5: "o",
    125.8: "Z",
    123.1: "5",
    120.4: "Y",
    117.7: "x",
    115: "j",
    112.3: "y",
    109.6: "a",
    106.9: "]",
    104.2: "2",
    101.5: "E",
    98.8: "S",
    96.1: "w",
    93.4: "q",
    90.7: "k",
    88: "P",
    85.3: "6",
    82.6: "h",
    79.9: "9",
    77.2: "d",
    74.5: "4",
    71.8: "V",
    69.1: "p",
    66.4: "O",
    63.7: "G",
    61: "b",
    58.3: "U",
    55.6: "A",
    52.9: "K",
    50.2: "X",
    47.5: "H",
    44.8: "m",
    42.1: "8",
    39.4: "R",
    36.7: "D",
    34: "#",
    31.3: "\$",
    28.6: "B",
    25.9: "g",
    23.2: "0",
    20.5: "M",
    17.8: "N",
    15.1: "W",
    12.4: "Q",
    9.7: "%",
    7: "&",
    4.3: "@",
  };

  // Get the ASCII character for the given brightness value
  String brightnessToChar(double input) {
    var output = _treeMap[input];
    return output ?? " ";
  }
}
