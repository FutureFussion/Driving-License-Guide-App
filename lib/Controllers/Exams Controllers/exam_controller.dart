import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:avtoskola_varketilshi/Models/exam_question_model.dart';
import 'package:avtoskola_varketilshi/Utils%20&%20Services/unanswered_questions_services.dart';
import 'package:avtoskola_varketilshi/App%20Widegts/showTestPassedDialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math';

class ExamController extends GetxController {
  final questions = <ExamQuestionModel>[].obs;
  final currentIndex = 0.obs;
  final selectedAnswers = <int, int>{}.obs;
  final RxInt remainingTime = (30 * 60).obs;
  final RxInt correctAnswersCount = 0.obs;
  final RxInt wrongAnswersCount = 0.obs;
  final answeredQuestions = <int>{}.obs;
  Timer? _timer;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    selectedAnswers.clear();
    final category = Get.arguments as String? ?? 'B, B1';
    _loadRandomQuestions(category);
    startTimer();
  }

  Future<List<ExamQuestionModel>> _loadAll(String questionFile) async {
    try {
      final String jsonString = await rootBundle.loadString(questionFile);
      final List<dynamic> jsonData = json.decode(jsonString);

      return jsonData
          .map((questionJson) => ExamQuestionModel.fromJson(questionJson))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> _loadRandomQuestions(String category) async {
    isLoading.value = true;
    final path = {
      'B, B1': 'assets/questions/B,B1_exam.json',
      'C': 'assets/questions/c_category.json',
      'D': 'assets/questions/d_category.json',
      'T, S': 'assets/questions/t_s_category.json',
    }[category] ?? 'assets/questions/B,B1_exam.json';

    final all = await _loadAll(path);
    final rnd = Random();
    final picked = <ExamQuestionModel>[];
    final used = <int>{};

    while (picked.length < 20 && used.length < all.length) {
      final idx = rnd.nextInt(all.length);
      if (used.add(idx)) picked.add(all[idx]);
    }

    questions.assignAll(picked);
    isLoading.value = false;
  }

  void selectOption(int optionIndex) {
    if (selectedAnswers.containsKey(currentIndex.value)) return;
    final currentQuestion = questions[currentIndex.value];
    selectedAnswers[currentIndex.value] = optionIndex;
    answeredQuestions.add(currentIndex.value);

    currentQuestion.selectedIndex = optionIndex;

    if (optionIndex == currentQuestion.correctAnswer) {
      correctAnswersCount.value++;
    } else {
      wrongAnswersCount.value++;
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      currentIndex.value = index;
    }
  }

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
    } else if (currentIndex.value == questions.length - 1) {
      showTestPassedDialog(
        Get.context!,
        totalQuestions: questions.length,
        answeredQuestions: selectedAnswers.length,
        correctAnswers: correctAnswersCount.value,
      );
    }
  }

  void prevQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  String get formattedTime {
    final minutes = remainingTime.value ~/ 60;
    final seconds = remainingTime.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool isCorrect(int index) =>
      selectedAnswers[currentIndex.value] != null &&
      selectedAnswers[currentIndex.value] ==
          questions[currentIndex.value].correctAnswer &&
      selectedAnswers[currentIndex.value] == index;

  bool isWrong(int index) =>
      selectedAnswers[currentIndex.value] != null &&
      selectedAnswers[currentIndex.value] !=
          questions[currentIndex.value].correctAnswer &&
      selectedAnswers[currentIndex.value] == index;

  bool get canGoNext => selectedAnswers[currentIndex.value] != null;
  bool get canGoPrev =>
      currentIndex.value > 0 && !answeredQuestions.contains(currentIndex.value);

  bool isPreviousQuestionAnswered() {
    final previousIndex = currentIndex.value - 1;
    return previousIndex >= 0 && answeredQuestions.contains(previousIndex);
  }

  bool isQuestionAnswered(int questionIndex) {
    return answeredQuestions.contains(questionIndex);
  }

  void syncAnsweredQuestionsFromReview() {
    final unansweredController = Get.find<UnansweredQuestionsServices>();
    final unansweredQuestions = unansweredController.unansweredQuestions;

    for (var unansweredQ in unansweredQuestions) {
      final question = unansweredQ.unansweredQuestions;
      if (question != null && question.selectedIndex != null) {
        final questionIndex =
            questions.indexWhere((q) => q.id == question.id);
        if (questionIndex != -1) {
          selectedAnswers[questionIndex] = question.selectedIndex!;
          answeredQuestions.add(questionIndex);

          questions[questionIndex].selectedIndex = question.selectedIndex;
        }
      }
    }
  }

  bool get isExamCompleted {
    return selectedAnswers.length == questions.length;
  }

  bool get isLastQuestionCompleted {
    final isLastQuestion = currentIndex.value == questions.length - 1;
    final isLastQuestionAnswered =
        selectedAnswers.containsKey(currentIndex.value);
    return isLastQuestion && isLastQuestionAnswered;
  }
}
