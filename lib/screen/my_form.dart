import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/form_json.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/screen/chat_screen.dart';
import 'package:student_ai/widgets/message.dart';
import 'package:student_ai/widgets/my_text_field.dart';

class MyForm extends StatefulWidget {
  final String id;
  final String title;

  const MyForm({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formFields = {};
  Map<String, dynamic> submittedData = {};
  List<Message> msgList = [];
  late Map<String, TextEditingController> formFieldControllers = {};

  @override
  void initState() {
    super.initState();
    var formJSONbyId = formJSON.firstWhere((data) => data['id'] == widget.id);
    submittedData['prompt'] = formJSONbyId['prompt'];
    formJSONbyId['schema']['properties'].forEach((key, value) {
      formFields[key] = value;
      formFieldControllers[key] =
          TextEditingController(text: value['default'].toString());
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
            builder: (BuildContext context) => ChatScreen(
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
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: formFields.length,
                      itemBuilder: (context, index) {
                        var field = formFields.entries.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  field.value['title'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              MyTextField(
                                  field: field,
                                  formFieldControllers: formFieldControllers),
                            ],
                          ),
                        );
                      },
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
              color: kButtonColor,
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
                    color: kWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
