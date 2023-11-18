import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/data/models/custom_app_model.dart';
import 'package:student_ai/logic/blocs/api/api_bloc.dart';
import 'package:student_ai/logic/blocs/validator/validator_bloc.dart';
import 'package:student_ai/presentation/screens/chat/chat_screen.dart';
import 'package:student_ai/presentation/screens/custom_apps/widgets/custom_app_text_field.dart';
import 'package:student_ai/widgets/show_snackbar.dart';

class CustomAppFormPage extends StatefulWidget {
  final CustomAppModel customAppData;

  const CustomAppFormPage({super.key, required this.customAppData});

  @override
  State<CustomAppFormPage> createState() => _CustomAppFormPageState();
}

class _CustomAppFormPageState extends State<CustomAppFormPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> finalPrompt = {};
  late Map<String, TextEditingController> formFieldControllers = {};

  @override
  void initState() {
    super.initState();
    final prompt = widget.customAppData.prompt;
    finalPrompt['prompt'] = prompt;

    formFieldControllers['prompt'] = TextEditingController(text: prompt);
    formFieldControllers['input'] = TextEditingController();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      formFieldControllers.forEach((key, controller) {
        finalPrompt[key] = controller.text;
      });

      if (!isAPIValidated) {
        showSnackBar(
          context: context,
          message: 'Enter a valid API Key',
          backgroundColor: kRed,
        );
      } else {
        log('Final prompt : $finalPrompt');
        BlocProvider.of<APIBloc>(context).add(APIRequestEvent(query: finalPrompt.toString()));
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return const ChatScreen();
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: kTransparent,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                widget.customAppData.title,
                style:
                    TextStyle(color: colors.kTextColor, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: FocusTraversalGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Prompt",
                          style: TextStyle(
                            color: colors.kTextColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomAppTextField(
                        field: MapEntry('prompt', widget.customAppData.prompt),
                        formFieldControllers: formFieldControllers,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: FocusTraversalGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Input",
                          style: TextStyle(
                            color: colors.kTextColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomAppTextField(
                        field: const MapEntry('input', ''),
                        formFieldControllers: formFieldControllers,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        foregroundColor: colors.kTextColor,
        onPressed: _submitForm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        label: const Text(
          'Submit',
          style: TextStyle(
            color: kWhite,
            fontSize: 16,
          ),
        ),
        icon: Icon(
          Icons.done_rounded,
          color: colors.kTextColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    formFieldControllers.forEach((key, value) {
      value.dispose();
    });
  }
}
