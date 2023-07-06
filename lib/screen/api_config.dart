import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_ai/data/app_color.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/data/globals.dart';
import 'package:student_ai/services/api_service.dart';

class ApiConfig extends StatefulWidget {
  const ApiConfig({super.key});

  @override
  State<ApiConfig> createState() => _ApiConfigState();
}

class _ApiConfigState extends State<ApiConfig> {
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.kSecondaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Text(
                  'Default: Free API\n'
                  'To enhance the quality of your responses, kindly provide your OpenAI API key.',
                  style: TextStyle(
                    color: colors.kTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Switch(
                      value: openai,
                      activeColor: kRed,
                      onChanged: (bool value) {
                        setState(() {
                          openai = value;
                        });
                      },
                    ),
                    SvgPicture.asset(
                      'assets/openai.svg',
                      width: 30,
                      colorFilter: ColorFilter.mode(
                        openai ? const Color(0xFF19C37D) : kGrey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                enabled: openai,
                cursorColor: kPrimaryColor,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                controller: apiController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  labelText: 'Your OpenAI API Key',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600, color: colors.kTextColor!.withOpacity(0.5)),
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
              const SizedBox(
                height: 16,
              ),
              MaterialButton(
                color: kPrimaryColor,
                disabledColor: kGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: !openai
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          await ApiService.validateApiKey(apiController.text).then((value) {
                            if (!value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Enter a valid API Key',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor: kRed,
                                ),
                              );
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
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
                          });
                        }
                      },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: colors.kTextColor,
                        )
                      : const Icon(
                          Icons.check,
                          size: 36,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
