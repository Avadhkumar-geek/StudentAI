import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/card_skeleton.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/models/custom_app_model.dart';
import 'package:student_ai/logic/blocs/custom_app/custom_app_bloc.dart';
import 'package:student_ai/widgets/my_text_field.dart';

class CreateAppForm extends StatefulWidget {
  const CreateAppForm({Key? key, this.customAppData}) : super(key: key);
  final CustomAppModel? customAppData;

  @override
  State<CreateAppForm> createState() => _CreateAppFormState();
}

class _CreateAppFormState extends State<CreateAppForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> appFields = jsonDecode(appFormJSON);
  late Map<String, TextEditingController> formFieldControllers = {};

  @override
  void initState() {
    super.initState();
    appFields.forEach((key, value) {
      log(key);
      final texts = widget.customAppData;
      formFieldControllers[key] = TextEditingController(text: texts?.toJson()[key]);
    });
    log(appFields.toString());
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
                widget.customAppData != null ? 'Update Your App' : 'Create Your App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.kTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              for (var field in appFields.entries)
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
                            style: TextStyle(
                              color: colors.kTextColor,
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            CustomAppModel customApp = createApp();
            widget.customAppData == null
                ? BlocProvider.of<CustomAppsBloc>(context).add(
                    CustomAppAddEvent(
                      appId: customApp.appId,
                      title: customApp.title,
                      desc: customApp.desc,
                      prompt: customApp.prompt,
                    ),
                  )
                : BlocProvider.of<CustomAppsBloc>(context).add(
                    CustomAppEditEvent(
                      appId: widget.customAppData!.appId,
                      title: customApp.title,
                      desc: customApp.desc,
                      prompt: customApp.prompt,
                    ),
                  );
            Navigator.pop(context);
          }
        },
        backgroundColor: kPrimaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        label: Text(
          widget.customAppData != null ? 'Update' : 'Create',
          style: const TextStyle(fontSize: 16),
        ),
        icon: Icon(
          widget.customAppData != null ? Icons.done : Icons.add,
        ),
      ),
    );
  }

  @override
  void dispose() {
    formFieldControllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  CustomAppModel createApp() {
    String title = formFieldControllers['title']!.text;
    String desc = formFieldControllers['desc']!.text;
    String prompt = formFieldControllers['prompt']!.text;
    String appId = title.toLowerCase().replaceAll(' ', '_');

    return CustomAppModel(appId: appId, title: title, desc: desc, prompt: prompt);
  }
}
