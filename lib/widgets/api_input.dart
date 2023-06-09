import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/frosted_glass.dart';

class ApiInput extends StatefulWidget {
  const ApiInput({Key? key}) : super(key: key);

  @override
  State<ApiInput> createState() => _ApiInputState();
}

class _ApiInputState extends State<ApiInput> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController apiController = TextEditingController(text: apiKey);
  bool _isLoading = false;

  addAPIKeyToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("apiKey", apiKey!);
    prefs.setBool("isAPIValidated", isAPIValidated);
  }

  @override
  Widget build(BuildContext context) {
    return FrostedGlass(
      widget: AlertDialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.black54,
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 250,
                  child: TextFormField(
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    controller: apiController,
                    decoration: InputDecoration(
                      labelText: 'Enter an API Key',
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600, color: kWhite),
                      prefixIcon: const Icon(
                        Icons.key,
                        color: kWhite,
                      ),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      focusColor: kWhite,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(width: 2, color: kRadiumGreen),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(width: 2, color: kRadiumGreen),
                      ),
                      filled: true,
                      fillColor: kRadiumGreen.withOpacity(0.5),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a key';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              MaterialButton(
                color: kRadiumGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Icon(
                          Icons.check,
                          size: 36,
                        ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    if (!await ApiService.validateApiKey(apiController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Enter a valid API Key',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: kRed,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'API Key validated!!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: kGreen,
                        ),
                      );
                      setState(() {
                        _isLoading = false;
                        isAPIValidated = true;
                        apiKey = apiController.text;
                      });
                      addAPIKeyToStorage();
                    }
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
