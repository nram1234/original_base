extension NumbersUtils on double {
  bool get isWholeNumber {
    return this == this.roundToDouble();
  }

  double get toPercentageAccuracy {
    return (this * 100).round() / 100.0;
  }

  double get roundToNearestHalf {
    double result = this * 2;
    result = result.floorToDouble();
    result /= 2;
    return result;
  }
}

extension DateUtils on DateTime {
  String get formattedDate => "$day/$month/$year";
}

extension NumbersListUtils on List<num> {
  String get stringFormat {
    String result = "";
    this.forEach((n) => result += "$n,");
    if (result.endsWith(",")) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }
}

extension DurationUtils on Duration? {
  String get stringFormat {
    if (this == null || this == Duration.zero) return "00.00";

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(this!.inMinutes.remainder(60));
    String seconds = twoDigits(this!.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  int get nearestSecond {
    if (this == null || this == Duration.zero) return 0;

    // note that 1000 is one second in milliseconds.
    int reminder = this!.inMilliseconds % 1000;
    if (reminder != 0) {
      int resultInMilliSeconds = this!.inMilliseconds - reminder + 1000;
      return resultInMilliSeconds ~/ 1000;
    } else {
      return this!.inMilliseconds;
    }
  }
}
