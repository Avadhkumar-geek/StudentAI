import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/form_data.dart';
import 'package:student_ai/screen/answer.dart';

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
  Map<String, dynamic> formData1 = {};
  Map<String, dynamic> submittedVal = {};

  late Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    var cardData = formDataMain.firstWhere((data) => data['id'] == widget.id);
    submittedVal['prompt'] = cardData['prompt'];
    cardData['schema']['properties'].forEach((key, value) {
      formData1[key] = value;
      controllers[key] =
          TextEditingController(text: value['default'].toString());
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Do something with the form data
      controllers.forEach((key, controller) {
        submittedVal[key] = controller.text;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Answer(text: submittedVal.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
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
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: formData1.length,
                      itemBuilder: (context, index) {
                        var entry = formData1.entries.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  entry.value['title'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextFormField(
                                keyboardType: typeMap[entry.value['type']],
                                controller: controllers[entry.key],
                                decoration: InputDecoration(
                                  hintText: entry.value['placeholder'],
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: kBlack),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: kDeepOrange),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: kWhite,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field can't be empty";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              onPressed: _submitForm,
              color: kDeepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: kWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
