import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/logic/blocs/updater/updater_cubit.dart';

class UpdateListener extends StatelessWidget {
  const UpdateListener({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdaterCubit, UpdaterState>(
          listenWhen: (previous, current) =>
              previous.status == UpdaterStatus.downloadInProgress &&
              current.status == UpdaterStatus.idle &&
              current.isNewPatchReadyToInstall,
          listener: (context, state) {
            ScaffoldMessenger.of(context)
              ..hideCurrentMaterialBanner()
              ..showMaterialBanner(
                const MaterialBanner(
                  content: Text('An update is available!'),
                  actions: [
                    TextButton(
                      onPressed: Restart.restartApp,
                      child: Text(
                        'Restart Now',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
          },
        ),
      ],
      child: child,
    );
  }
}
