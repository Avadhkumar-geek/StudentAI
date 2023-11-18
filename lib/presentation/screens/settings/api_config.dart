import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/logic/blocs/validator/validator_bloc.dart';
import 'package:student_ai/widgets/show_snackbar.dart';

class ApiConfig extends StatefulWidget {
  const ApiConfig({super.key});

  @override
  State<ApiConfig> createState() => _ApiConfigState();
}

class _ApiConfigState extends State<ApiConfig> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController apiController = TextEditingController(text: apiKey);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.kTertiaryColor,
      appBar: AppBar(
        backgroundColor: colors.kTertiaryColor,
        foregroundColor: colors.kTextColor,
        title: Text(
          "API Configuration",
          style: TextStyle(color: colors.kTextColor),
        ),
      ),
      body: BlocListener<ValidatorBloc, ValidatorState>(
        listener: (context, state) {
          if (state is ValidatorSuccess) {
            apiController.text = apiKey!;
            showSnackBar(
              context: context,
              message: state.successMessage,
              backgroundColor: kGreen,
            );
          }
          if (state is ValidatorFailure) {
            showSnackBar(
              context: context,
              message: state.error,
              backgroundColor: kGreen,
            );
          }
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.kSecondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text.rich(
                      style: TextStyle(fontSize: 18, color: colors.kTextColor),
                      TextSpan(
                        text: 'Enter your PaLM API key, or get one from ',
                        children: [
                          WidgetSpan(
                            child: InkWell(
                              onTap: () => launchURL('https://makersuite.google.com/app/apikey'),
                              child: const Text(
                                'here',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: kPrimaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: kPrimaryColor),
                              ),
                            ),
                          ),
                          const TextSpan(text: ' for free')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Image.asset(
                            'assets/pngs/palm.png',
                            width: 50,
                          ),
                        ),
                        TextFormField(
                          cursorColor: kPrimaryColor,
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          controller: apiController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            labelText: 'Your PaLM API Key',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: colors.kTextColor!.withOpacity(0.5)),
                            prefixIcon: Icon(
                              Icons.key,
                              color: colors.kTextColor!.withOpacity(0.5),
                            ),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            focusColor: kWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: kPrimaryColor,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(width: 2, color: kPrimaryColor),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: kRed,
                                width: 2,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: kGrey,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: kRed.shade900,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: kPrimaryColor.withOpacity(0.3),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a key';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              splashFactory: InkRipple.splashFactory,
                              foregroundColor: kRed,
                            ),
                            onPressed: () => context.read<ValidatorBloc>().add(ResetAPIKey()),
                            child: const Text(
                              'Reset Key',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        MaterialButton(
                          color: kPrimaryColor,
                          disabledColor: kGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<ValidatorBloc>()
                                  .add(ValidateAPIKey(apiKey: apiController.text));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: context.watch<ValidatorBloc>().state is ValidatorLoading
                                ? CircularProgressIndicator(
                                    color: colors.kTextColor,
                                  )
                                : const Icon(
                                    Icons.check,
                                    size: 36,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.info_outline,
                  color: kGrey,
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    "We do not store your API key on our servers; it is securely stored on your device.",
                    style: TextStyle(
                      color: kGrey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    apiController.dispose();
    super.dispose();
  }
}
