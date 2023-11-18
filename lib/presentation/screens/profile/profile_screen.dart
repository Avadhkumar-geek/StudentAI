import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/logic/blocs/user/user_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.kTertiaryColor,
      appBar: AppBar(
        backgroundColor: colors.kTertiaryColor,
        foregroundColor: colors.kTextColor,
        title: Text(
          "Profile",
          style: TextStyle(color: colors.kTextColor),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Profile Updated Successfully!'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserInitial) {
            context.read<UserBloc>().add(GetUserEvent());
          }
          if (state is UserLoadingState) {
            return Container(
              padding: const EdgeInsets.all(40.0),
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Container(
                        height: 25,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                    color: Colors.grey,
                  )
                ],
              ),
            );
          }
          if (state is UserSuccessState) {
            final user = state.userData;
            return Container(
              padding: const EdgeInsets.all(40.0),
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.photoURL),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      isEditing
                          ? SizedBox(
                              width: 150,
                              child: EditableText(
                                  controller: usernameController,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: colors.kTextColor?.withOpacity(0.7),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  cursorColor: Colors.black,
                                  backgroundCursorColor: Colors.black,
                                  focusNode: FocusNode()),
                            )
                          : Text(
                              user.displayName,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                            if (isEditing) {
                              usernameController.text = user.displayName;
                            } else {
                              context.read<UserBloc>().add(
                                    UpdateUserEvent(
                                      displayName: usernameController.text,
                                    ),
                                  );
                            }
                          });
                        },
                        icon: Icon(
                          isEditing ? Icons.save : Icons.edit,
                          color: colors.kTextColor,
                        ),
                      )
                    ],
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
