

class CalculatorLogic {
  String currentInput = "";
  double? firstOperand;
  String? operator;

  void clearCalculator() {
    currentInput = "";
    firstOperand = null;
    operator = null;
  }

  void backspace() {
    if (currentInput.isNotEmpty) {
      currentInput = currentInput.substring(0, currentInput.length - 1);
    }
  }

  String calculateResult() {
    if (currentInput.isNotEmpty) {
      final secondOperand = double.tryParse(currentInput);
      if (secondOperand != null) {
        if (firstOperand != null && operator != null) {
          double result;
          switch (operator) {
            case "+":
              result = firstOperand! + secondOperand;
              break;
            case "-":
              result = firstOperand! - secondOperand;
              break;
            case "×":
              result = firstOperand! * secondOperand;
              break;
            case "÷":
              if (secondOperand != 0) {
                result = firstOperand! / secondOperand;
              } else {
                return "Error";
              }
              break;
            default:
              return "Error";
          }
          firstOperand = result;
          currentInput = result.toString();
          operator = null;
          return currentInput;
        } else {
          firstOperand = secondOperand;
          return currentInput;
        }
      }
    }
    return "Error";
  }
}