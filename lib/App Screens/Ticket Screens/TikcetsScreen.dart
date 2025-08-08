// import 'package:avtoskola_varketilshi/App%20Screens/Home%20Screens/HomeScreen.dart';
// import 'package:avtoskola_varketilshi/App%20Widegts/exam_option_tile.dart';
// import 'package:avtoskola_varketilshi/App%20Widegts/showTestPassedDialog.dart';
// import 'package:avtoskola_varketilshi/Controllers/Exams%20Controllers/exam_controller.dart';
// import 'package:avtoskola_varketilshi/Controllers/Tickets%20Controllers/TicketsController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TikcetsScreen extends StatelessWidget {
//   const TikcetsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //final controller = Get.put(ExamController());
//     final controller = Get.put(TicketsController(), tag: Get.arguments);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Obx(() {
//           if (controller.questions.isEmpty) {
//             return const Center(
//               child: CircularProgressIndicator(color: Colors.red),
//             );
//           }
//           final question = controller.questions[controller.currentIndex.value];

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),

//               /// Top bar
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () => Get.offAll(() => HomeScreen()),
//                       child: Image.asset('assets/images/menu.png', height: 24),
//                     ),
//                     Image.asset('assets/images/slogo.png', height: 30),
//                     Image.asset('assets/images/drawer.png', height: 24),
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                   ),
//                   child: Column(
//                     children: [
//                       question.imageUrl != null
//                           ? Image.asset(question.imageUrl!)
//                           : SizedBox.shrink(),
//                       Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Text(
//                           question.question,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               /// Options
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: List.generate(question.options.length, (i) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 6),
//                         child: ExamOptionTile(
//                           index: i,
//                           text: question.options[i],
//                           selected: controller.selectedAnswers[
//                                   controller.currentIndex.value] ==
//                               i,
//                           onTap: () => controller.selectOption(i),
//                           isCorrect: true,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),

//               // Bottom navigation bar
//               Container(
//                 color: Colors.white,
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 child: Row(
//                   children: [
//                     // Prev arrow
//                     IconButton(
//                       onPressed: () {
//                         controller.prevQuestion();
//                       },
//                       icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
//                     ),

//                     // Question number buttons (mid expandable)
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children:
//                               List.generate(controller.questions.length, (i) {
//                             final isSel = i == controller.currentIndex.value;
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 4),
//                               child: GestureDetector(
//                                 onTap: () => controller.goToQuestion(i),
//                                 child: Container(
//                                   width: 36,
//                                   height: 36,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.red),
//                                     color: isSel ? Colors.red : Colors.white,
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     '${i + 1}',
//                                     style: TextStyle(
//                                       color: isSel ? Colors.white : Colors.red,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     ),

//                     // Next arrow
//                     IconButton(
//                       onPressed: () {
//                         controller.nextQuestion();
//                         if (controller.currentIndex.value ==
//                             controller.questions.length - 1) {
//                           showTestPassedDialog(
//                             context,
//                             totalQuestions: controller.questions.length,
//                             answeredQuestions:
//                                 controller.selectedAnswers.length,
//                             correctAnswers:
//                                 controller.correctAnswersCount.value,
//                           );
//                         }
//                       },
//                       icon: const Icon(Icons.arrow_forward_ios,
//                           color: Colors.red),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avtoskola_varketilshi/Controllers/Tickets%20Controllers/TicketsController.dart';
import 'package:avtoskola_varketilshi/App%20Widegts/exam_option_tile.dart';
import 'package:avtoskola_varketilshi/App%20Widegts/showTestPassedDialog.dart';
import 'package:avtoskola_varketilshi/App%20Screens/Home%20Screens/HomeScreen.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TicketsController(), tag: Get.arguments);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (controller.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }
          final q = controller.questions[controller.currentIndex.value];

          return Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.offAll(() => HomeScreen()),
                      child: Image.asset('assets/images/menu.png', height: 24),
                    ),
                    Image.asset('assets/images/slogo.png', height: 30),
                    Image.asset('assets/images/drawer.png', height: 24),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Column(
                    children: [
                      if (q.imageUrl != null) Image.asset(q.imageUrl!),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(q.question, style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(q.options.length > 4 ? 4 : q.options.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: ExamOptionTile(
                          index: i,
                          text: q.options[i],
                          selected: controller.selectedAnswers[controller.currentIndex.value] == i,
                          onTap: () => controller.selectOption(i),
                          isCorrect: controller.isCorrect(i),
                          isWrong: controller.isWrong(i),
                          disableTap: controller.selectedAnswers.containsKey(controller.currentIndex.value),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
