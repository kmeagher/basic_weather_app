
class UtilService {

  static celciusToFahrenheit(int celcius) {
    try {
      double calc = (celcius * 9/5) + 32;
      return calc.round();
    } catch(e) {
      return 0;
    }
  }

  static fahrenheightToCelcius(int fahrenheight) {
    try {
      double calc = (fahrenheight - 32)*5/9;
      return calc.round();
    } catch(e) {
      return 0;
    }
  }

}