import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/constants/app_color.dart';
import '../../../logic/blocs/chat/chat_bloc.dart';
import '../../../logic/blocs/api/api_bloc.dart';
import 'widgets/message.dart';
import '../search/widgets/my_search_bar.dart';
import 'widgets/typing_animation.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late AnimationController _aniController;
  final TextEditingController newQueryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _aniController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _aniController.dispose();
    newQueryController.dispose();
    super.dispose();
  }

  void _onSendButtonPressed() {
    HapticFeedback.heavyImpact();
    _aniController.forward().then((_) => _aniController.reset());

    final query = newQueryController.text;
    if (query.isNotEmpty) {
      context.read<ChatBloc>().add(SendUsrMsgEvent(msg: query));
      context.read<APIBloc>().add(APIRequestEvent(query: query));
      newQueryController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return BlocListener<APIBloc, APIState>(
      listener: (context, state) {
        if (state is APISuccessState) {
          BlocProvider.of<ChatBloc>(context).add(GetAIMsgEvent(msg: state.response));
        }
        if (state is APIFailedState) {
          BlocProvider.of<ChatBloc>(context).add(GetAIMsgEvent(msg: state.error));
        }
      },
      child: Scaffold(
        backgroundColor: colors.kTertiaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: colors.kTextColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ChatBot',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              context.watch<APIBloc>().state is APIRequestState
                  ? const TypingAnimation()
                  : Container(),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline_outlined),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: colors.kSecondaryColor,
                  title: const Text('Clear this chat?'),
                  content: const Text('This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.read<ChatBloc>().add(ChatClearEvent());
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state.status == ChatStatus.loaded || state.status == ChatStatus.cleared) {
                    return ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      itemCount: state.msgs?.length,
                      itemBuilder: (context, index) => Message(
                        sender: state.msgs![index].sender,
                        text: state.msgs![index].text,
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            MySearchBar(
              onEditingComplete: () {},
              onChanged: (val) {},
              textInputAction: TextInputAction.newline,
              hintText: 'Ask Anything...',
              chatController: newQueryController,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: _onSendButtonPressed,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: colors.kTextColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.5).animate(_aniController),
                        child: SvgPicture.asset(
                          'assets/svgs/openai.svg',
                          width: 40,
                          colorFilter: ColorFilter.mode(
                            colors.kTertiaryColor!,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
