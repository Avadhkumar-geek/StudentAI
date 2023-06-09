import 'package:flutter/material.dart';
import 'package:student_ai/data/constants.dart';
import 'package:student_ai/widgets/frosted_glass.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.data,
    required this.pageRoute,
    required this.id,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final Widget pageRoute;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageRoute),
      ),
      child: FrostedGlass(
        widget: Container(
          decoration: BoxDecoration(
            color: Color(int.parse(data['color'].toString())).withOpacity(0.6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kBackGroundColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    data['icon'],
                    size: 25,
                    color: kRadiumGreen,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      data['disc'],
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CardWidget extends StatelessWidget {
//   final Map<String, dynamic> data;
//   final Widget pageRoute;
//   final String id;

//   const CardWidget({
//     required this.id,
//     required this.data,
//     required this.pageRoute,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => pageRoute),
//       ),
//       child: Container(
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(                ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
