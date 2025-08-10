import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> _proficiencyLevels = [];
  List<QueryDocumentSnapshot> _chapters = [];
  List<QueryDocumentSnapshot> _questions = [];
  bool _isLoading = false;
  String? _error;

  int _currentIndex = 0;
  String? _selectedOption;
  String? _fillBlankAnswer;
  Map<String, String?> _selectedMatches = {};
  Map<String, String> _correctMatches = {};

  bool _answerChecked = false;
  bool _isCorrect = false;
  bool _showAnswer = false;


  List<QueryDocumentSnapshot> get chapters => _chapters;
  List<QueryDocumentSnapshot> get proficiencyLevels => _proficiencyLevels;
  List<QueryDocumentSnapshot> get questions => _questions;

  bool get isLoading => _isLoading;
  String? get error => _error;

  int get currentIndex => _currentIndex;
  bool get isLastQuestion => _currentIndex == _questions.length - 1;
  bool get answerChecked => _answerChecked;
  bool get isCorrect => _isCorrect;
  bool get showAnswer => _showAnswer;

  String? get selectedOption => _selectedOption;
  String? get fillBlankAnswer => _fillBlankAnswer;
  Map<String, String?> get selectedMatches => _selectedMatches;
  Map<String, String> get correctMatches => _correctMatches;

  Future<void> fetchProficiencyLevels(String language) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('quizzes')
          .doc(language)
          .collection('levels')
          .orderBy('order')
          .get();

      _proficiencyLevels = snapshot.docs;
    } catch (e) {
      _error = 'Failed to load levels';
    }

    _isLoading = false;
    notifyListeners();
  }
  Future<void> fetchChapters(String language, String proficiency) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('quizzes')
          .doc(language)
          .collection('levels')
          .doc(proficiency)
          .collection('chapters')
          .orderBy('order')
          .get();

      _chapters = snapshot.docs;
    } catch (e) {
      _error = 'Failed to load chapters';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadQuestions({
    required String language,
    required String proficiency,
    required String chapterId,
  }) async {
    final snapshot = await _firestore
        .collection('quizzes')
        .doc(language)
        .collection('levels')
        .doc(proficiency)
        .collection('chapters')
        .doc(chapterId)
        .collection('questions')
        .get();

    _questions = snapshot.docs;
    _currentIndex = 0;
    resetState();
    notifyListeners();
  }

  Future<DocumentSnapshot?> loadNextChapter({
    required String language,
    required String proficiency,
    required int currentChapterOrder,
  }) async {
    try {
      final nextChapterQuery = await _firestore
          .collection('quizzes')
          .doc(language)
          .collection('levels')
          .doc(proficiency)
          .collection('chapters')
          .where('order', isGreaterThan: currentChapterOrder)
          .orderBy('order')
          .limit(1)
          .get();

      if (nextChapterQuery.docs.isNotEmpty) {
        return nextChapterQuery.docs.first;
      }
      return null;
    } catch (e) {
      if (kDebugMode) print('Error loading next chapter: $e');
      return null;
    }
  }

  Future<DocumentSnapshot?> loadPreviousChapter({
    required String language,
    required String proficiency,
    required int currentChapterOrder,
  }) async {
    try {
      final previousChapterQuery = await _firestore
          .collection('quizzes')
          .doc(language)
          .collection('levels')
          .doc(proficiency)
          .collection('chapters')
          .where('order', isLessThan: currentChapterOrder)
          .orderBy('order', descending: true)
          .limit(1)
          .get();

      if (previousChapterQuery.docs.isNotEmpty) {
        return previousChapterQuery.docs.first;
      }
      return null;
    } catch (e) {
      if (kDebugMode) print('Error loading previous chapter: $e');
      return null;
    }
  }


  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      resetState();
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      resetState();
      notifyListeners();
    }
  }

  void resetState() {
    _selectedOption = null;
    _fillBlankAnswer = null;
    _selectedMatches = {};
    _correctMatches = {};
    _answerChecked = false;
    _isCorrect = false;
    _showAnswer = false;
  }

  void updateSelectedOption(String? value) {
    _selectedOption = value;
    notifyListeners();
  }

  void updateFillBlankAnswer(String value) {
    _fillBlankAnswer = value;
    notifyListeners();
  }

  void updateSelectedMatch(String key, String? value) {
    _selectedMatches[key] = value;
    notifyListeners();
  }

  void toggleShowAnswer() {
    _showAnswer = !_showAnswer;
    notifyListeners();
  }

  void setCorrectMatches(Map<String, String> matches) {
    _correctMatches = matches;
  }

  void checkAnswer() {
    final question = _questions[_currentIndex];
    final data = question.data() as Map<String, dynamic>;
    final type = data['type'];
    final correctAnswer = data['correctAnswer'];

    _answerChecked = true;

    if (type == 'mcq') {
      _isCorrect = _selectedOption == correctAnswer;
    } else if (type == 'fill_blank') {
      _isCorrect = _fillBlankAnswer?.trim().toLowerCase() == correctAnswer.toString().toLowerCase();
    } else if (type == 'matching') {
      _isCorrect = _calculateMatchingScore() == _correctMatches.length;
    }

    notifyListeners();
  }

  int _calculateMatchingScore() {
    int score = 0;
    _selectedMatches.forEach((key, value) {
      if (_correctMatches[key] == value) score++;
    });
    return score;
  }

  int calculateScore() {
    final question = _questions[_currentIndex];
    final data = question.data() as Map<String, dynamic>;
    final type = data['type'];

    switch (type) {
      case 'mcq': return 5;
      case 'fill_blank': return 6;
      case 'matching': return _calculateMatchingScore() * 3;
      default: return 5;
    }
  }
}

