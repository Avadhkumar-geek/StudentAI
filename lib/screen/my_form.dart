import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/screen/chat_screen.dart';
import 'package:student_ai/screen/quiz.dart';
import 'package:student_ai/services/api_service.dart';
import 'package:student_ai/widgets/dummy_form.dart';
import 'package:student_ai/widgets/my_text_field.dart';

class MyForm extends StatefulWidget {
  final String id;
  final String title;

  const MyForm({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formFields = {};
  Map<String, dynamic> submittedData = {};
  late Map<String, TextEditingController> formFieldControllers = {};

  Future<Map<String, dynamic>> loadForm() async {
    try {
      var data = await ApiService.getFormData(widget.id);
      if (kDebugMode) {
        print("MyForm: $data");
      }
      return data;
    } catch (err) {
      if (kDebugMode) {
        print("MyForm error : $err");
      }
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    loadForm().then((formJSONbyId) {
      setState(() {});
      submittedData['prompt'] = formJSONbyId['prompt'];
      formJSONbyId['schema']['properties'].forEach((key, value) {
        formFields[key] = value;
        formFieldControllers[key] = TextEditingController(text: value['default'].toString());
      });
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      formFieldControllers.forEach((key, controller) {
        submittedData[key] = controller.text;
      });

      if (isAPIValidated == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter a valid API Key'),
            backgroundColor: kRed,
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => widget.id == 'mcq-type-quiz'
                ? Quiz(queryController: submittedData.toString())
                : ChatScreen(
                    queryController: submittedData.toString(),
                    isFormRoute: true,
                  ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return formFields.isEmpty
        ? DummyForm(title: widget.title)
        : Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(color: kWhite, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                for (var field in formFields.entries)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: FocusTraversalGroup(
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
                            field: field,
                            formFieldControllers: formFieldControllers,
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  onPressed: _submitForm,
                  color: kAiMsgBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
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
