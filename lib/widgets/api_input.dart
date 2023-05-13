import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/services/api_service.dart';

class ApiInput extends StatefulWidget {
  const ApiInput({Key? key}) : super(key: key);

  @override
  State<ApiInput> createState() => _ApiInputState();
}

class _ApiInputState extends State<ApiInput> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController apiController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: apiController,
                decoration: InputDecoration(
                  hintText: apiKey ?? 'API Key',
                  labelText: 'Enter you API Key',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
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
            MaterialButton(
              color: kPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: kWhite,
                        )
                      : const Icon(
                          Icons.check,
                          size: 36,
                          color: kWhite,
                        )),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  if (!await ApiService.validateApiKey(apiController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enter a valid API Key'),
                        backgroundColor: kRed,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('API Key validated!!'),
                        backgroundColor: kGreen,
                      ),
                    );
                    setState(() {
                      _isLoading = false;
                      apiKey = apiController.text;
                    });
                  }
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
