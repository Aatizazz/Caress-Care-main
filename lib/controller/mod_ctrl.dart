import 'package:caress_care/model/mod_model.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:flutter/material.dart';

class ChecklistController extends ChangeNotifier {
  int currentStep = 0;
  bool showMore = false;

  late final List<MentalHealthQuestion> anxietyList;
  late final List<MentalHealthQuestion> depressionList;
  late final List<MentalHealthQuestion> stressList;

  ChecklistController() {
    anxietyList = [
      MentalHealthQuestion(text: 'Increased heart rate (palpitations)'),
      MentalHealthQuestion(text: 'Shortness of breath'),
      MentalHealthQuestion(text: 'Muscle tension or aches'),
      MentalHealthQuestion(text: 'Sweating'),
      MentalHealthQuestion(text: 'Shaking or trembling'),
      MentalHealthQuestion(text: 'Dizziness or light-headedness'),
      MentalHealthQuestion(text: 'Fatigue or low energy'),
      MentalHealthQuestion(text: 'Stomach issues'),
      MentalHealthQuestion(text: 'Headaches'),
      MentalHealthQuestion(text: 'Insomnia or trouble staying asleep'),
      MentalHealthQuestion(text: 'Restlessness or feeling “on edge”'),
      MentalHealthQuestion(text: 'Excessive worry or fear'),
      MentalHealthQuestion(text: 'Difficulty concentrating'),
      MentalHealthQuestion(text: 'Irritability'),
      MentalHealthQuestion(text: 'Sense of impending doom'),
    ];

    depressionList = [
      MentalHealthQuestion(text: 'Persistent sadness or low mood'),
      MentalHealthQuestion(text: 'Loss of interest in activities'),
      MentalHealthQuestion(text: 'Feelings of hopelessness'),
      MentalHealthQuestion(text: 'Worthlessness or guilt'),
      MentalHealthQuestion(text: 'Crying spells'),
      MentalHealthQuestion(text: 'Difficulty concentrating'),
      MentalHealthQuestion(text: 'Indecisiveness'),
      MentalHealthQuestion(text: 'Negative thoughts'),
      MentalHealthQuestion(text: 'Memory problems'),
      MentalHealthQuestion(text: 'Thoughts of death'),
      MentalHealthQuestion(text: 'Fatigue or low energy'),
      MentalHealthQuestion(text: 'Changes in appetite'),
    ];

    stressList = [
      MentalHealthQuestion(text: 'Headaches'),
      MentalHealthQuestion(text: 'Muscle tension or pain'),
      MentalHealthQuestion(text: 'Chest pain or rapid heartbeat'),
      MentalHealthQuestion(text: 'Fatigue'),
      MentalHealthQuestion(text: 'Stomach problems'),
      MentalHealthQuestion(text: 'Frequent colds or infections'),
      MentalHealthQuestion(text: 'Sleep disturbances'),
      MentalHealthQuestion(text: 'Sweating or cold hands and feet'),
      MentalHealthQuestion(text: 'Changes in appetite'),
      MentalHealthQuestion(text: 'Grinding teeth or jaw clenching'),
      MentalHealthQuestion(text: 'Irritability or short temper'),
      MentalHealthQuestion(text: 'Feeling overwhelmed'),
    ];
  }

  // 🔄 Step-based titles
  String getTitleByStep(int step) {
    switch (step) {
      case 0:
        return 'Anxiety Symptoms';
      case 1:
        return 'Depression Symptoms';
      case 2:
        return 'Stress Symptoms';
      default:
        return '';
    }
  }

  // 🔄 Step-based list
  List<MentalHealthQuestion> getListByStep(int step) {
    switch (step) {
      case 0:
        return anxietyList;
      case 1:
        return depressionList;
      case 2:
        return stressList;
      default:
        return [];
    }
  }

  Color getStepColor(int step) {
    List<Color> stepColors = [
      AppColors.gradientTop,
      AppColors.gradientMid,
      AppColors.gradientBottom,
    ];
    return stepColors[step];
  }

  // 📦 Current step title (for app bar)
  String getCurrentTitle() => getTitleByStep(currentStep);

  // 📦 Current list (based on currentStep)
  List<MentalHealthQuestion> getCurrentList() => getListByStep(currentStep);

  // ✅ Toggle show more / less
  void toggleShowMore() {
    showMore = !showMore;
    notifyListeners();
  }

  // ☑️ Toggle question selection
  void toggleQuestion(MentalHealthQuestion question, bool? value) {
    question.isSelected = value ?? false;
    notifyListeners();
  }

  // 🔄 Move to next step or finish
  void nextStep(VoidCallback onFinish) {
    if (currentStep < 2) {
      currentStep++;
      showMore = false;
      notifyListeners();
    } else {
      onFinish();
    }
  }

  // 🔢 Total selected across all lists
  int get totalSelected =>
      [
        ...anxietyList,
        ...depressionList,
        ...stressList,
      ].where((q) => q.isSelected).length;
}
