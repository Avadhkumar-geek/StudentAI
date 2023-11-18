import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/logic/blocs/apps/apps_bloc.dart';
import 'package:student_ai/presentation/screens/form/my_form.dart';
import 'package:student_ai/presentation/screens/home/widgets/card_widget.dart';
import 'package:student_ai/presentation/screens/home/widgets/dummy_cards.dart';
import 'package:student_ai/presentation/screens/home/widgets/more_button.dart';

class Apps extends StatelessWidget {
  const Apps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Apps for You",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: colors.kTextColor),
          ),
        ),
        BlocBuilder<HomeBloc, AppsState>(
          builder: (context, state) {
            if (state.status == AppStateStatus.initial) {
              context.read<HomeBloc>().add(AppsGetEvent(limit: 5));
            }
            if (state.status == AppStateStatus.loading) {
              return const DummyCards();
            }
            if (state.status == AppStateStatus.loaded) {
              final apps = state.apps;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width * 0.0021,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: apps.length + 1,
                itemBuilder: (context, index) {
                  if (index < apps.length) {
                    final data = apps[index];
                    return CardWidget(
                      id: data.id,
                      data: data,
                      pageRoute: MyFormPage(id: data.id, title: data.title),
                    );
                  } else {
                    return const MoreButton();
                  }
                },
              );
            }
            return const DummyCards();
          },
        ),
      ],
    );
  }
}
