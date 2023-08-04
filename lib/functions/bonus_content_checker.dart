//------------------------ bonus task ----------------------------------------------
// content password checker will return true if and only if the password contains :
// Minimum 1 letter
// Minimum 1 Numeric Number
// Minimum 1 Special Character: ex---> Common Allow Character ( ! @ # $ & * ~ )
bool checkPasswordContent(String value) {
  RegExp regExp =
      RegExp(r"(?=.*?[0-9])(?=.*[A-Za-z])(?=.*?[!@)#-$=.%؟,-;:'&%>^+<~])(?=.*)(?=.*\W+)");
  return regExp.hasMatch(value);
}
//------------------------  Here is an explanation: --------------------------------
// r'^
//   (?=.*[A-Za-z])       // should contain at least one letter
//   (?=.*?[0-9])      // should contain at least one digit
//   (?=.*?[!@#\$&*~]) // should contain at least one Special character
//-----------------------    assert that---------------------
// (?=^.{8,}$)    # there are at least 8 characters
// (              # and
//   (?=.*\d)       # there is at least a digit
//   |              # or
//   (?=.*\W+)      # there is one or more "non word" characters (\W is equivalent to [^a-zA-Z0-9_])
// )              # and
// (?![.\n])      # there is no . or newline and
// (?=.*[A-Z])    # there is at least an upper case letter and
// (?=.*[a-z]).*$ # there is at least a lower case letter
// .*$            # in a string of any characters
// $
