class TimerCustom {
  static int time = 0;
  static Future<void> run(Function function, {int seconds = 1}) async {
    await Future.delayed(Duration(seconds: seconds));
    function();
  }

  // get time left
  static getTimeLeft() {
    return time;
  }

  // set time
  static setTime(int newTime) {
    time = newTime;
  }

  // reset time
  static resetTime(int resetTime) {
    time = resetTime;
  }

  // pause timer
  static pauseTimer() {
    time = 0;
  }
}
