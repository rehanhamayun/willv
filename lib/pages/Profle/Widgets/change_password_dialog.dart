import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:http/http.dart' as http;

class PasswordDialog extends StatefulWidget {
  final String? token;

  const PasswordDialog({Key? key, this.token}) : super(key: key);

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  TextEditingController password = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirmation = TextEditingController();
  bool isSecure = true;
  bool notCompatiblePasswords = false;
  bool isEmptyFields = false;
  bool apiCircleProgess = false;
  bool apiFetchingDone = false;
  String responseMessage = "";
  late http.Response response;

  @override
  void initState() {
    password.text = "";
    newPassword.text = "";
    newPasswordConfirmation.text = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    password.dispose();
    newPassword.dispose();
    newPasswordConfirmation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change password'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: rightFloatingButton),
              ),
              labelText: 'Old password',
              labelStyle: const TextStyle(color: Colors.black, fontSize: 12),
              hintText: 'Enter Your Old Password',
              hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isSecure = !isSecure;
                  });
                },
                icon: Icon(
                    isSecure
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: rightFloatingButton,
                    size: 14),
              ),
            ),
            controller: password,
            obscureText: isSecure,
            autofocus: false,
            cursorColor: Colors.green.shade900,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: rightFloatingButton),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isSecure = !isSecure;
                  });
                },
                icon: Icon(
                    isSecure
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: rightFloatingButton,
                    size: 14),
              ),
              labelText: 'New password',
              labelStyle: const TextStyle(color: Colors.black87, fontSize: 12),
              hintText: 'Enter Your Last Name',
              hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            controller: newPassword,
            obscureText: isSecure,
            autofocus: false,
            cursorColor: Colors.green.shade900,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: rightFloatingButton),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isSecure = !isSecure;
                  });
                },
                icon: Icon(
                    isSecure
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: rightFloatingButton,
                    size: 14),
              ),
              labelText: 'Confirmation password',
              labelStyle: const TextStyle(color: Colors.black, fontSize: 12),
              hintText: 'Enter Your Last Name',
              hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            controller: newPasswordConfirmation,
            obscureText: isSecure,
            autofocus: false,
            cursorColor: Colors.green.shade900,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          isEmptyFields
              ? const Text(
                  "All fields are required!",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                )
              : const SizedBox(),
          notCompatiblePasswords
              ? const Text(
                  "New password and confirmation should be the same!",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                )
              : const SizedBox(),
          apiFetchingDone
              ? Text(
                  responseMessage,
                  style: const TextStyle(
                      color: rightFloatingButton,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                )
              : const SizedBox(),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(primary: rightFloatingButton),
          onPressed: () {
            password.text = "";
            newPassword.text = "";
            newPasswordConfirmation.text = "";
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        apiCircleProgess
            ? CircularProgressIndicator(
                color: Colors.green.shade700,
                strokeWidth: 2,
              )
            : TextButton(
                style: TextButton.styleFrom(primary: rightFloatingButton),
                onPressed: () async {
                  setState(() {
                    apiFetchingDone = false;
                  });
                  if (password.text.isEmpty ||
                      newPassword.text.isEmpty ||
                      newPasswordConfirmation.text.isEmpty) {
                    setState(() {
                      isEmptyFields = true;
                    });
                  } else {
                    setState(() {
                      isEmptyFields = false;
                    });
                    if (newPassword.text != newPasswordConfirmation.text) {
                      setState(() {
                        notCompatiblePasswords = true;
                      });
                    } else {
                      setState(() {
                        notCompatiblePasswords = false;
                        apiCircleProgess = true;
                      });
                      await updatePassword(
                          password: password.text,
                          newPassword: newPassword.text);
                    }
                  }
                },
                child: const Text('SAVE'),
              ),
      ],
    );
  }

  Future<void> updatePassword({
    required String password,
    required String newPassword,
  }) async {
    String token = widget.token!;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {
      'oldPassword': password,
      'newPassword': newPassword
    };
    response = await http.post(
        Uri.parse(
            ApiService.apiUrl + ApiService.user + ApiService.updatePassword),
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        apiCircleProgess = false;
        apiFetchingDone = true;
        responseMessage = "Password updated";
      });
      print("response.statusCode == 200");
      print(response.body);
    } else if (response.statusCode == 404) {
      setState(() {
        apiCircleProgess = false;
        apiFetchingDone = true;
        responseMessage = "Please check your old password!";
      });
      print("response.statusCode == 404");
      print(response.body);
    } else {
      setState(() {
        apiCircleProgess = false;
        apiFetchingDone = true;
        responseMessage = "Something went wrong!";
      });
      print("Exception");
      print(response.body);
      throw Exception('Failed to load Card');
    }
  }
}
