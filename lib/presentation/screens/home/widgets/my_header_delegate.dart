import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_ai/data/constants/app_color.dart';
import 'package:student_ai/data/constants/constants.dart';
import 'package:student_ai/data/constants/globals.dart';
import 'package:student_ai/logic/blocs/api/api_bloc.dart';
import 'package:student_ai/logic/blocs/chat/chat_bloc.dart';
import 'package:student_ai/logic/blocs/user/user_bloc.dart';
import 'package:student_ai/presentation/screens/chat/chat_screen.dart';
import 'package:student_ai/presentation/screens/search/widgets/my_search_bar.dart';
import 'package:student_ai/widgets/show_snackbar.dart';

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController chatController;
  late AnimationController _animationController;

  MyHeaderDelegate(AnimationController animationController, this.chatController) {
    _animationController = animationController;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final state = context.watch<UserBloc>().state;

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [kWhite, kWhite.withOpacity(0.05)],
          stops: const [0.85, 1],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: Container(
        color: colors.kTertiaryColor,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text.rich(
                TextSpan(
                  text: 'Hello, \n',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: colors.kTextColor,
                  ),
                  children: [
                    state is UserSuccessState
                        ? WidgetSpan(
                            child: Text(
                              state.userData.displayName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                          )
                        : WidgetSpan(
                            child: Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kPrimaryColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: colors.kTextColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            MySearchBar(
              hintText: 'Ask Anything...',
              chatController: chatController,
              onChanged: (val) {},
              onEditingComplete: () {},
              textInputAction: TextInputAction.newline,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    _animationController.forward().then((value) => _animationController.reset());
                    if (!isAPIValidated) {
                      showSnackBar(
                        context: context,
                        message: 'Enter a valid API Key',
                        backgroundColor: kErrorColor,
                      );
                    } else if (chatController.text.isNotEmpty) {
                      BlocProvider.of<ChatBloc>(context)
                          .add(SendUsrMsgEvent(msg: chatController.text));
                      BlocProvider.of<APIBloc>(context)
                          .add(APIRequestEvent(query: chatController.text));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(),
                        ),
                      ).then((value) => chatController.clear());
                    }
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: colors.kTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.5).animate(_animationController),
                      child: SvgPicture.asset(
                        'assets/svgs/g_ai.svg',
                        width: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 200.0; // Height of the second widget

  @override
  double get minExtent => 200.0; // Height of the second widget

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
