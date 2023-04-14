// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_builder/responsive_builder.dart';
//
// import '../percent_stepper.dart';
//
// class FormPercentProgressStatus extends StatelessWidget {
//
//   const FormPercentProgressStatus({ Key? key }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     // PiProgressController controller = Provider.of<PiProgressController>(context);
//
//     double maxWidth = 820.0;
//
//     Size screenSize = MediaQuery.of(context).size;
//     DeviceScreenType deviceScreenType = getDeviceType(screenSize);
//     bool isDesktop = deviceScreenType == DeviceScreenType.desktop;
//     double padding = isDesktop ? 111.0 : 19.0;
//
//     double cardWidth = isDesktop ? 400 : deviceScreenType == DeviceScreenType.tablet ? 120.0 : 82.0;
//
//     /// TODO: тут надо поставить так
//     /// double cardMaxWidth = (cardWidth + (12 * 2)) * controller.items.length;
//     double cardMaxWidth = (cardWidth + (12 * 2)) * 4;
//
//     double mediaQueryWidth = screenSize.width - (padding * 2);
//
//     if (mediaQueryWidth >= cardMaxWidth) maxWidth = mediaQueryWidth;
//     else maxWidth = cardMaxWidth;
//
//     if (maxWidth > 820.0 && !isDesktop) maxWidth = 820.0;
//     if (maxWidth > 2150.0 && isDesktop) maxWidth = 2150.0;
//
//     List<Widget> bottomContent = [];
//
//     if (!isDesktop) {
//       bottomContent =  [
//
//         const SizedBox(height: 12.0),
//
//         ConstrainedBox(
//           constraints: BoxConstraints(maxWidth: maxWidth),
//           child: Row(
//             children: [
//
//               for (int index = 0; index < 4 + 1; ++index) ...[
//                 Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 5.0),
//                       height: 5,
//                       color: const Color.fromRGBO(1, 114, 206, 1),
//                     )
//                 ),
//               ]
//
//             ],
//           ),
//         )
//
//       ];
//     }
//
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: padding),
//       decoration: BoxDecoration(color: isDesktop ? const Color.fromRGBO(1, 114, 206, 1) : null),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             child: Center(
//               child: Container(
//                 constraints: BoxConstraints(maxWidth: maxWidth),
//                 alignment: Alignment.center,
//                 child: PercentStepper(
//                   type: StepperType.horizontal,
//                   steps: [
//
//                     for (int index = 0; index < controller.items.length; ++index)
//                       _buildStep(
//                         title: Text(
//                           controller.items[index],
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           softWrap: true,
//                         ),
//                         isActive: index == controller.currentPage,
//                         state: index == controller.currentPage ? StepState.editing : index < controller.currentPage ? StepState.complete : StepState.indexed,
//                       ),
//
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           ...bottomContent
//
//         ],
//       ),
//     );
//
//   }
//
//   Step _buildStep({required Widget title, StepState state = StepState.indexed, bool isActive = false}) {
//     return Step(
//       title: title,
//       state: state,
//       isActive: isActive,
//       content: LimitedBox(
//         maxWidth: 300,
//         maxHeight: 300,
//         child: Container(color: const Color.fromRGBO(63, 159, 152, 1)),
//       ),
//     );
//   }
//
// }
