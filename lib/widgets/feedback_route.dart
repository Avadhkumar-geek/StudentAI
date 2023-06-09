import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/widgets/my_text_field.dart';

class FeedBackRoute extends StatelessWidget {
  const FeedBackRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> formFields = {
      "Name": {
        "id": 1,
        "type": "text",
        "title": "Name",
        "placeholder": "John Doe"
      },
      "Email": {
        "id": 2,
        "type": "text",
        "title": "Email",
        "placeholder": "you@email.com"
      },
      "Text": {
        "id": 3,
        "type": "text",
        "title": "Your Views",
        "placeholder": "Write here..."
      }
    };

    final formKey = GlobalKey<FormState>();
    Map<String, dynamic> submittedData = {};
    Map<String, TextEditingController> formFieldControllers = {};
    formFields.forEach((key, value) {
      formFieldControllers[key] = TextEditingController();
    });

    void submitForm() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        formFieldControllers.forEach((key, controller) {
          submittedData[key] = controller.text;
        });
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          for (var field in formFields.entries)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      field.value['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MyTextField(
                      field: field, formFieldControllers: formFieldControllers),
                ],
              ),
            ),
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            onPressed: submitForm,
            color: kAiMsgBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
