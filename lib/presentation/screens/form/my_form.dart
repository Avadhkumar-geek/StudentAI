import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/data/repositories/studentai_api_repo.dart';
import 'package:student_ai/logic/blocs/api/api_bloc.dart';
import 'package:student_ai/logic/blocs/app_metadata/app_metadata_bloc.dart';
import 'package:student_ai/presentation/screens/chat/chat_screen.dart';
import 'package:student_ai/presentation/screens/form/widgets/dummy_form.dart';
import 'package:student_ai/presentation/screens/quiz/widgets/mind_map.dart';
import 'package:student_ai/presentation/screens/quiz/quiz.dart';
import 'package:student_ai/widgets/my_text_field.dart';
import 'package:student_ai/widgets/show_snackbar.dart';

class MyFormPage extends StatelessWidget {
  final String id;
  final String title;

  const MyFormPage({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppMetadataBloc(studentAiRepo: StudentAiApiRepo()),
      child: MyFormView(id: id, title: title),
    );
  }
}

class MyFormView extends StatefulWidget {
  final String id;
  final String title;

  const MyFormView({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<MyFormView> createState() => _MyFormViewState();
}

class _MyFormViewState extends State<MyFormView> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> finalPrompt = {};
  late Map<String, TextEditingController> formFieldControllers = {};

  @override
  void initState() {
    super.initState();
    context.read<AppMetadataBloc>().add(GetAppMetadataEvent(id: widget.id));
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
          backgroundColor: kErrorColor,
        );
      } else {
        BlocProvider.of<APIBloc>(context).add(APIRequestEvent(query: finalPrompt.toString()));
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          if (widget.id == 'mcq-type-quiz') {
            return Quiz(
              query: finalPrompt.toString(),
            );
          } else if (widget.id == 'mindmap-generator') {
            return MindMap(data: finalPrompt.toString());
          } else {
            return const ChatScreen();
          }
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
        child: BlocBuilder<AppMetadataBloc, AppMetadataState>(
          builder: (context, state) {
            if (state is AppMetadataLoading) {
              return DummyForm(title: widget.title);
            }

            if (state is AppMetadataLoaded) {
              final data = state.metadata.result;
              final properties = data.schema.properties;

              finalPrompt['prompt'] = data.prompt;

              properties.forEach((key, value) {
                formFieldControllers[key] =
                    TextEditingController(text: value['default'].toString());
              });

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: colors.kTextColor, fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    for (var field in properties.entries)
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
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            }
            return DummyForm(title: widget.title);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        foregroundColor: colors.kTextColor,
        onPressed: _submitForm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        label: Text(
          'Submit',
          style: TextStyle(
            color: colors.kTextColor,
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
