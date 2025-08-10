
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProgress with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> _completedLessons = [];
  List<String> _completedQuizzes = [];
  Map<String, int> _quizScores = {};
  int _totalXp = 0;

  String? _currentProficiency;
  String? _lastLessonId;
  String? _lastQuizId;
  String? _currentChapterId;

  // Getters
  List<String> get completedLessons => _completedLessons;
  List<String> get completedQuizzes => _completedQuizzes;
  Map<String, int> get quizScores => _quizScores;
  int get totalXp => _totalXp;
  String? get currentProficiency => _currentProficiency;
  String? get lastLessonId => _lastLessonId;
  String? get lastQuizId => _lastQuizId;
  String? get currentChapterId => _currentChapterId;

  String? get nextLessonId => _lastLessonId;
  String? get nextChapterId => _currentChapterId;

  String get nextLessonTitle {
    final nextId = nextLessonId ?? 'lesson_1';
    return "Lesson ${nextId.split('_').last}";
  }

  double get completionPercentage {
    const totalLessons = 128;
    const totalQuizzes = 75;
    final totalCompleted = _completedLessons.length + _completedQuizzes.length;
    final totalItems = totalLessons + totalQuizzes;
    return totalItems > 0 ? totalCompleted / totalItems : 0.0;
  }

  Future<void> initializeProgress(String language) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await loadProgress(language: language);
    _currentProficiency ??= 'beginner';
    notifyListeners();
  }


  Future<void> completeLesson({
    required String language,
    required String proficiency,
    required String chapterId,
    required String lessonId,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final fullLessonId = '${chapterId}_$lessonId';

    await _updateProgress(
      language: language,
      proficiency: proficiency,
      chapterId: chapterId,
      fullLessonId: fullLessonId,
    );

    if (!_completedLessons.contains(fullLessonId)) {
      _completedLessons.add(fullLessonId);
      _lastLessonId = fullLessonId;
      _currentChapterId = chapterId;
      _currentProficiency = proficiency;
      notifyListeners();
    }
  }

  Future<void> completeQuiz({
    required String language,
    required String chapterId,
    required String quizId,
    required int score,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final proficiency = _currentProficiency ?? 'beginner';
    final fullQuizId = '${chapterId}_$quizId';

    await _updateProgress(
      language: language,
      proficiency: proficiency,
      chapterId: chapterId,
      fullQuizId: fullQuizId,
      score: score,
    );

    if (!_completedQuizzes.contains(fullQuizId)) {
      _completedQuizzes.add(fullQuizId);
      _quizScores[fullQuizId] = score;
      _totalXp += score;
      _lastQuizId = fullQuizId;
      notifyListeners();
    }
  }

  Future<void> loadProgress({required String language}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('progress')
          .doc(language)
          .collection('summary')
          .get();

      // Reset
      _completedLessons.clear();
      _completedQuizzes.clear();
      _quizScores.clear();
      _totalXp = 0;

      Timestamp? latestTimestamp;

      for (var doc in querySnapshot.docs) {
        final data = doc.data();

        _completedLessons.addAll(List<String>.from(data['completedLessons'] ?? []));
        _completedQuizzes.addAll(List<String>.from(data['completedQuizzes'] ?? []));
        final scores = Map<String, int>.from(data['quizScores'] ?? {});
        _quizScores.addAll(scores);
        _totalXp = data['totalXp'] ?? 0;

        final lastUpdated = data['lastUpdated'] as Timestamp?;
        if (lastUpdated != null &&
            (latestTimestamp == null || lastUpdated.compareTo(latestTimestamp) > 0)) {
          latestTimestamp = lastUpdated;
          _lastLessonId = data['lastLesson'];
          _lastQuizId = data['lastQuiz'];
          _currentChapterId = data['chapterId'];
          _currentProficiency = data['proficiency'] ?? doc.id;
        }
      }

      notifyListeners();
    } catch (e) {
      print('Error loading progress: $e');
    }
  }

  Future<void> _updateProgress({
    required String language,
    required String proficiency,
    required String chapterId,
    String? fullLessonId,
    String? fullQuizId,
    int? score,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('progress')
        .doc(language)
        .collection('summary')
        .doc(proficiency);

    final data = {
      'language': language,
      'proficiency': proficiency,
      'chapterId': chapterId,
      'lastUpdated': FieldValue.serverTimestamp(),
    };

    if (fullLessonId != null) {
      data['completedLessons'] = FieldValue.arrayUnion([fullLessonId]);
      data['lastLesson'] = fullLessonId;
    }

    if (fullQuizId != null && score != null) {
      data['completedQuizzes'] = FieldValue.arrayUnion([fullQuizId]);
      data['lastQuiz'] = fullQuizId;
      data['quizScores.$fullQuizId'] = score;
      data['totalXp'] = FieldValue.increment(score);
    }

    await docRef.set(data, SetOptions(merge: true));
  }

  bool isLessonCompleted(String fullLessonId) {
    return _completedLessons.contains(fullLessonId);
  }

  bool isQuizCompleted(String fullQuizId) {
    return _completedQuizzes.contains(fullQuizId);
  }

  int? getQuizScore(String fullQuizId) {
    return _quizScores[fullQuizId];
  }
}
