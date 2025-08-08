import 'package:avtoskola_varketilshi/App Screens/Exams Screens/unanswered_review_screen.dart';
import 'package:avtoskola_varketilshi/App Widegts/exam_option_tile.dart';
import 'package:avtoskola_varketilshi/Controllers/Exams Controllers/exam_controller.dart';
import 'package:avtoskola_varketilshi/Models/unanswered_questions_model.dart';
import 'package:avtoskola_varketilshi/Utils & Services/unanswered_questions_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExamController());
    final unansweredController = Get.put(UnansweredQuestionsServices());

    controller.syncAnsweredQuestionsFromReview();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value || controller.questions.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Loading questions...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            );
          }
          final q = controller.questions[controller.currentIndex.value];
          final question = controller.questions[controller.currentIndex.value];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.red,
                        )),
                    const SizedBox(width: 6),
                    GestureDetector(
                        onTap: () {
                          Get.to(UnansweredReviewScreen());
                        },
                        child: _infoBox(controller.formattedTime, color: Colors.red)),
                    const SizedBox(width: 6),
                    _infoBox('#${controller.selectedAnswers.length}'),
                    const SizedBox(width: 6),
                    _infoBox('#${controller.correctAnswersCount}'),
                    const SizedBox(width: 6),
                    _infoBox('#${question.id}'),
                    const Spacer(),
                    Image.asset('assets/images/slogo.png', height: 36),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    children: [
                      question.imageUrl != null
                          ? Image.asset(question.imageUrl!)
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          question.question,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < (q.options.length > 4 ? 4 : q.options.length); i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: ExamOptionTile(
                            index: i,
                            text: q.options[i],
                            selected: controller.selectedAnswers[controller.currentIndex.value] == i,
                            isCorrect: controller.isCorrect(i),
                            isWrong: controller.isWrong(i),
                            onTap: () {
                              controller.selectOption(i);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.prevQuestion();
                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(controller.questions.length, (i) {
                            final isSel = i == controller.currentIndex.value;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  color: isSel ? Colors.red : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${i + 1}',
                                  style: TextStyle(
                                    color: isSel ? Colors.white : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.nextQuestion();
                        final unansweredQstn = UnansweredQuestionsModel(
                            unansweredQuestions: question);
                        controller.isPreviousQuestionAnswered()
                            ? null
                            : unansweredController.addUnansweredQuestion(
                                question: unansweredQstn);
                      },
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _infoBox(String text, {Color color = Colors.red}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
