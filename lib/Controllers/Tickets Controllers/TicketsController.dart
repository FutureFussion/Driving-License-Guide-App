// import 'dart:async';
// import 'package:avtoskola_varketilshi/Models/exam_question_model.dart';

// import 'package:get/get.dart';

// class TicketsCntroller extends GetxController {
//   final questions = <ExamQuestionModel>[].obs;
//   final currentIndex = 0.obs;
//   final selectedAnswers = <int, int>{}.obs;
//   final RxInt remainingTime = (30 * 60).obs;
//   final RxInt correctAnswersCount = 0.obs;
//   final RxInt wrongAnswersCount = 0.obs;
//   final answeredQuestions = <int>{}.obs; // Track answered questions
//   Timer? _timer;

//   @override
//   void onInit() {
//     super.onInit();
//     selectedAnswers.clear();
//     final category = Get.arguments as String? ?? 'B, B1';
//     loadQuestions(category);
//     startTimer();
//   }

//   void loadQuestions(String category) {
//     final allQuestions = {
//       'B, B1': [
//         ExamQuestionModel(
//           id: 801,
//           question: 'The traffic accident participant driver is obliged to:',
//           options: [
//             'Apply the necessary measures only to ensure traffic safety at the accident scene',
//             'Avoid making some changes or destruction of footprints at the accident scene only, which might be useful for definition of liability',
//             'Write down the surnames of the witnesses',
//             'To perform all actions listed in given test',
//           ],
//           correctAnswer: 3, // Index 3 (0-based) is correct
//         ),
//         ExamQuestionModel(
//           id: 802,
//           question: 'If a vehicle is approaching the children playing on the pavement, a driver shall:',
//           options: [
//             'Proceed without paying attention to children, in order not to create obstacle to the vehicle behind',
//             'Give honk and proceed without stopping only',
//             'Slow down and be ready for braking',
//           ],
//           correctAnswer: 2, // Index 2 is correct
//         ),
//         ExamQuestionModel(
//           id: 803,
//           question: 'What are the advantages of using low viscosity engine oils?',
//           options: [
//             'The vehicle mileage increases before the mandatory oil change',
//             'The amount of fuel consumed is reduced',
//             'They can be disposed of with household waste',
//           ],
//           correctAnswer: 1, // Index 1 is correct
//         ),
//         ExamQuestionModel(
//           id: 804,
//           question: 'Which vehicle driver is obliged to yield to another when driving to the arrow direction?',
//           options: [
//             'Lorry driver',
//             'Motor car driver',
//           ],
//           correctAnswer: 1, // Index 1 is correct
//         ),
//         ExamQuestionModel(
//           id: 805,
//           question: 'According to the Georgian Code of Administrative Offences, delivery of the vehicle to a person to drive, obviously being under alcoholic influence, repeatedly, within the period of one after commitment of the above offence, will result in:',
//           options: [
//             'Penalty in the amount of 1500 GEL',
//             'Penalty in the amount of 2000 GEL',
//             'Penalty in the amount of 1500 GEL and suspension of driving license for the period of 6 months',
//           ],
//           correctAnswer: 2, // Index 2 is correct
//         ),
//         ExamQuestionModel(
//           id: 806,
//           question: 'What position is allowed while transporting a person injured after an accident with brain concussion?',
//           options: [
//             'Supine position, as well as put the pillow under neck and waist area',
//             'Side lying position',
//           ],
//           correctAnswer: 1, // Index 1 is correct
//         ),
//         ExamQuestionModel(
//           id: 807,
//           question: 'Where should we wash the vehicle so as not to damage the environment?',
//           options: [
//             'In the car wash',
//             'At the parking lot of the car',
//             'On the bank of a river or reservoir',
//           ],
//           correctAnswer: 0, // Index 0 is correct
//         ),
//         ExamQuestionModel(
//           id: 808,
//           question: 'Will a motor car driver violate the Highway Code in case of driving to the arrow direction?',
//           options: [
//             'Yes',
//             'No',
//           ],
//           correctAnswer: 0, // Index 0 is correct
//         ),
//       ],
//       'C': [
//         ExamQuestionModel(
//           id: 809,
//           question: 'Which of these traffic signs marks the section of the road, on which edge of the road does not comply with the applicable standards?',
//           options: ['I', 'II', 'III', 'IV'],
//           correctAnswer: 0, // Index 0 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 810,
//           question: 'In which direction is not learning motion prohibited when learner is driving the learning car?',
//           options: ['In direction A only', 'In direction B only', 'In both A and B directions'],
//           correctAnswer: 1, // Index 1 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 811,
//           question: 'For all those expenses and damages, caused due to inaccurate or inadequate submission of the data in the consignment note about the date and place of sending the cargo, as well as about the place of delivery of the cargo, liability shall be imposed to:',
//           options: ['Consignor', 'Carrier', 'Consignee'],
//           correctAnswer: 1, // Index 1 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 812,
//           question: 'If road in inhabited area is sufficiently lighted:',
//           options: [
//             'Sidelights must be switched on',
//             'Low beams must be switched on',
//             'High beams must be switched on',
//           ],
//           correctAnswer: 0, // Index 0 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 813,
//           question: 'In case of absence or failure of the pedestrians’ traffic lights, but when traffic is controlled by the traffic lights, the pedestrian should not go to the driveway:',
//           options: [
//             'Until he/she does not make sure in safety of distance of the approaching vehicle, define its speed and safety of crossing',
//             'Until traffic light or the signal of traffic controller does not allow motion on this driveway',
//           ],
//           correctAnswer: 1, // Index 1 is correct (example)
//         ),
//       ],
//       'D': [
//         ExamQuestionModel(
//           id: 814,
//           question: 'In the present situation, the motor car driver is obliged to:',
//           options: ['Proceed', 'Stop at the “STOP” line', 'Stop at least 10 meters from the nearest rail', 'Stop at the traffic light'],
//           correctAnswer: 3, // Index 3 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 815,
//           question: 'Is red car driver prohibited from fulfillment of overtaking maneuver by moving on reversible traffic lane?',
//           options: ['Yes', 'No'],
//           correctAnswer: 0, // Index 0 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 816,
//           question: 'How should the driver act while braking the vehicle without anti-lock brake system (ABC), in order the vehicle not to lose the steering capacity?',
//           options: [
//             'Brake with engine only',
//             'Brake with active brakes, by using additional parking brake',
//             'Brake by pulsating brake pedalling, besides try not to cause the blocking of the wheels',
//             'Must try to press the brake pedal abruptly, in order to stop the car quickly in this way',
//           ],
//           correctAnswer: 2, // Index 2 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 817,
//           question: 'What reduces fuel consumption?',
//           options: [
//             'Install the appropriate aerodynamic device on the vehicle',
//             'Use less octane gasoline than recommended',
//             'Close the glasses',
//           ],
//           correctAnswer: 0, // Index 0 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 818,
//           question: 'If during overtaking there appears an obstruction of hazard, of which a driver could not be aware before starting to overtake, the driver shall be obliged:',
//           options: [
//             'To increase speed, in order to finish maneuvering in due time',
//             'To give honk and go on overtaking maneuver',
//             'To stop overtaking',
//           ],
//           correctAnswer: 2, // Index 2 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 819,
//           question: 'Is the driver of a light vehicle prohibited to drive according to the arrows?',
//           options: ['Yes', 'No'],
//           correctAnswer: 0, // Index 0 is correct (example, assuming "Nox" was a typo for "No")
//         ),
//       ],
//       'T, S': [
//         ExamQuestionModel(
//           id: 820,
//           question: 'Sign on driveway - “BUS” - points to special lane, designated for:',
//           options: ['Low-speed vehicles', 'Bicycles and mopeds', 'Route vehicles'],
//           correctAnswer: 2, // Index 2 is correct
//         ),
//         ExamQuestionModel(
//           id: 821,
//           question: 'Is a driver of the vehicle to be overtaken prohibited from interfering in overtaking through increase of speed or other actions?',
//           options: ['Yes', 'No'],
//           correctAnswer: 0, // Index 0 is correct
//         ),
//         ExamQuestionModel(
//           id: 822,
//           question: 'Operation of the bulldozer is not allowed, if:',
//           options: [
//             'Operation on the slope during parallel inclination is more than 16°',
//             'Operation on the slope during parallel inclination is more than 20°',
//             'Operation on the slope during parallel inclination is more than 24°',
//           ],
//           correctAnswer: 2, // Index 2 is correct
//         ),
//         ExamQuestionModel(
//           id: 823,
//           question: 'U-turn is prohibited:',
//           options: [
//             'On intersection',
//             'On and under bridge, underpass and trestle bridge',
//             'On railroad crossing',
//             'In tunnel',
//           ],
//           correctAnswer: 0, // Index 0 is correct (example)
//         ),
//         ExamQuestionModel(
//           id: 824,
//           question: 'What operation does the ploughshare perform?',
//           options: [
//             'Cuts the belt in vertical plane',
//             'Cuts the belt in horizontal plane',
//             'Cuts the belt in movement parallel plane',
//             'Based on the traces of the wall and retains the sustainability of the plough',
//           ],
//           correctAnswer: 0, // Index 0 is correct (example)
//         ),
//       ],
//     };
//     questions.assignAll(allQuestions[category] ?? allQuestions['B, B1']!);
//   }



//   void selectOption(int optionIndex) {
//     final currentQuestion = questions[currentIndex.value];
//     selectedAnswers[currentIndex.value] = optionIndex;
//     answeredQuestions.add(currentIndex.value); // Mark as answered

//     if (optionIndex == currentQuestion.correctAnswer) {
//       correctAnswersCount.value++;
//     } else {
//       wrongAnswersCount.value++;
//     }

//     // Move to next question after a short delay for feedback
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (currentIndex.value < questions.length - 1) {
//         nextQuestion();
//       } else if (currentIndex.value == questions.length - 1) {
//         update(); // Force UI update before showing dialog
//       }
//     });
//   }

  // void goToQuestion(int index) {
  //   if (index >= 0 && index < questions.length) {
  //     currentIndex.value = index;
  //     update();
  //   }
  // }

//   void nextQuestion() {
//     if (currentIndex.value < questions.length - 1 && selectedAnswers[currentIndex.value] != null) {
//       goToQuestion(currentIndex.value + 1);
//     }
//   }

//   void prevQuestion() {
//     if (currentIndex.value > 0 && !answeredQuestions.contains(currentIndex.value)) {
//       goToQuestion(currentIndex.value - 1);
//     }
//   }

//   void startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (remainingTime.value > 0) {
//         remainingTime.value--;
//       } else {
//         timer.cancel();
//       }
//     });
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }

//   String get formattedTime {
//     final minutes = remainingTime.value ~/ 60;
//     final seconds = remainingTime.value % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   bool isCorrect(int index) =>
//       selectedAnswers[currentIndex.value] != null &&
//           selectedAnswers[currentIndex.value] == questions[currentIndex.value].correctAnswer &&
//           selectedAnswers[currentIndex.value] == index;

//   bool isWrong(int index) =>
//       selectedAnswers[currentIndex.value] != null &&
//           selectedAnswers[currentIndex.value] != questions[currentIndex.value].correctAnswer &&
//           selectedAnswers[currentIndex.value] == index;

//   bool get canGoNext => selectedAnswers[currentIndex.value] != null;
//   bool get canGoPrev => currentIndex.value > 0 && !answeredQuestions.contains(currentIndex.value);
// }


import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:avtoskola_varketilshi/Models/exam_question_model.dart';
import 'package:avtoskola_varketilshi/App Widegts/showTestPassedDialog.dart';

class TicketsController extends GetxController {
  final questions = <ExamQuestionModel>[].obs;
  final currentIndex = 0.obs;
  final selectedAnswers = <int, int>{}.obs;
  final RxInt correctAnswersCount = 0.obs;
  final RxInt wrongAnswersCount = 0.obs;
  final answeredQuestions = <int>{}.obs;
  late String category;

  @override
  void onInit() {
    super.onInit();
    selectedAnswers.clear();
    category = Get.arguments as String? ?? 'B, B1';
    _loadAllQuestions(category);
  }

  Future<List<ExamQuestionModel>> _loadAll(String path) async {
    final data = await rootBundle.loadString(path);
    final arr = json.decode(data) as List;
    return arr.map((e) => ExamQuestionModel.fromJson(e)).toList();
  }

  Future<void> _loadAllQuestions(String cat) async {
    final path = {
      'B, B1': 'assets/questions/B,B1_exam.json',
      'C': 'assets/questions/c_category.json',
      'D': 'assets/questions/d_category.json',
      'T, S': 'assets/questions/t_s_category.json',
    }[cat] ?? 'assets/questions/B,B1_exam.json';

    final all = await _loadAll(path);
    questions.assignAll(all);
  }

  void selectOption(int idx) {
    if (selectedAnswers.containsKey(currentIndex.value)) return;

    selectedAnswers[currentIndex.value] = idx;
    answeredQuestions.add(currentIndex.value);
    final correct = questions[currentIndex.value].correctAnswer == idx;
    if (correct) {
      correctAnswersCount.value++;
    } else {
      wrongAnswersCount.value++;
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (currentIndex.value < questions.length - 1) {
        currentIndex.value++;
      } else {
        // Last question answered: show results
        if (Get.context != null) {
          showTestPassedDialog(
            Get.context!,
            totalQuestions: questions.length,
            answeredQuestions: selectedAnswers.length,
            correctAnswers: correctAnswersCount.value,
          );
        }
      }
    });
  }

  bool isCorrect(int i) {
    return selectedAnswers[currentIndex.value] == i &&
        questions[currentIndex.value].correctAnswer == i;
  }

  bool isWrong(int i) {
    return selectedAnswers[currentIndex.value] == i &&
        questions[currentIndex.value].correctAnswer != i;
  }

  void prevQuestion() {
    if (currentIndex.value > 0) currentIndex.value--;
  }

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) currentIndex.value++;
  }

  void goToQuestion(int i) {
    if (i >= 0 && i < questions.length) currentIndex.value = i;
  }

  int get total => questions.length;
  int get answered => selectedAnswers.length;
  int get correct => correctAnswersCount.value;
}
