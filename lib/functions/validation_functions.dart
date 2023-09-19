class ValidationFunction {
  static mobileNumberValidation(val) {
    if (val == null ||val.length == 0) {
      return "Required*";
    } else if (val.length < 10) {
      return "Enter 10 digit mobile number";
    } else {
      return null;
    }
    // return null;
  }

  static passwordValidation(val) {
    if (val == null ||val.length == 0) {
      return "Required*";
    } else if (val.length < 6) {
      return "Enter at least 6 digit password";
    } else {
      return null;
    }
    // return null;
  }
  static confirmPasswordValidation(val,newpass) {
    if (val == null ||val.length == 0) {
      return "Required*";
    } else if (val.length < 6) {
      return "Enter at least 6 digit password";
    } else if (val != newpass ) {
      return "Confirm password & new password not match";
    }
    else {
      return null;
    }
    // return null;
  }
  static nameValidation(val) {
     RegExp nameRegex = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    if (val == null ||val.length == 0) {
      return "Required*";
    } else if (!nameRegex.hasMatch(val)) {
      return "Enter correct name";
    } else {
      return null;
    }
     
  }
  static emailValidation(val) {
     RegExp emailAddress = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (val == null ||val.length == 0) {
      return "Required*";
    } else if (!emailAddress.hasMatch(val)) {
      return "Enter correct email address";
    } else {
      return null;
    }




  }

  static orderIdValidation(val) {
    if (val == null ||val.length == 0) {
      return "Order ID is required*";
    } else {
      return null;
    }
  }
  static requiredValidation(val,{required String msg}) {
    if (val == null || val=='') {
      return msg;
    } else {
      return null;
    }
  }
}
