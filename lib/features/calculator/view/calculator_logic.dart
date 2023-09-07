class CalculatorLogic {
  String currentInput = "";
  double? firstOperand;
  double? result;
  String? operator;

  void clearCalculator() {
    currentInput = "";
    firstOperand = null;
    result = null;
    operator = null;
  }

  void backspace() {
    if (currentInput.isNotEmpty) {
      currentInput = currentInput.substring(0, currentInput.length - 1);
    }
  }

  void setInput(String input) {
    if (input == "+" || input == "-" || input == "×" || input == "÷") {
      if (result != null) {
        firstOperand = result;
        currentInput = "";
        operator = input;
      } else if (firstOperand == null) {
        firstOperand = double.tryParse(currentInput);
        currentInput = "";
        operator = input;
      } else {
        calculateResult(input);
      }
    } else if (input == "=") {
      calculateResult(input);
    } else {
      currentInput += input;
    }
  }

  void calculateResult(String nextOperator) {
    if (firstOperand != null && currentInput.isNotEmpty) {
      double? secondOperand = double.tryParse(currentInput);
      if (secondOperand != null) {
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
              currentInput = "Error";
              return;
            }
            break;
        }
        if (nextOperator == "=") {
          operator = null;
          currentInput = result?.toStringAsFixed(2) ?? "Error";
        } else {
          operator = nextOperator;
          firstOperand = result;
          currentInput = "";
        }
      } else {
        currentInput = "Error";
      }
    } else if (nextOperator == "=" && firstOperand == null) {
      // if user just enters a number and hits equals
      result = double.tryParse(currentInput);
      currentInput = result?.toStringAsFixed(2) ?? "Error";
    }
  }
}