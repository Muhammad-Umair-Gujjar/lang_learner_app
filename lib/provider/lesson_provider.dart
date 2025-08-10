
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LessonProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? _lessonData;
  int? _currentLessonOrder;
  int? _totalLessonsInChapter;
  bool _isLoading = true;
  String? _error;
  bool _showTranslation = false;

  Map<String, dynamic>? get lessonData => _lessonData;
  bool get showTranslation => _showTranslation;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int? get currentLessonOrder => _currentLessonOrder;
  int? get totalLessonsInChapter => _totalLessonsInChapter;


  Stream<QuerySnapshot> getProficiencies(String language) {
    return _firestore
        .collection('courses/$language/levels')
        .snapshots();
  }

  Stream<QuerySnapshot> getChapters(String language, String proficiency) {
    return _firestore
        .collection('courses/$language/levels/$proficiency/chapters')
        .orderBy('order')
        .snapshots();
  }


  Future<void> loadLesson({
    required String language,
    required String proficiency,
    required String chapterId,
    required String lessonId,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final lessonRef = _firestore
          .collection(
          'courses/$language/levels/$proficiency/chapters/$chapterId/lessons')
          .doc(lessonId);

      final lessonSnapshot = await lessonRef.get();
      if (!lessonSnapshot.exists) throw Exception("Lesson not found");

      final chapterLessons = await _firestore
          .collection(
          'courses/$language/levels/$proficiency/chapters/$chapterId/lessons')
          .orderBy('order')
          .get();

      _lessonData = lessonSnapshot.data() as Map<String, dynamic>;
      _currentLessonOrder = lessonData!['order'];
      _totalLessonsInChapter = chapterLessons.docs.length;
    }
    catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleTranslation() {
    _showTranslation = !showTranslation;
    notifyListeners();
  }

  Future<String?> getLessonIdByOrder({
    required String language,
    required String proficiency,
    required String chapterId,
    required int order,
  }) async {
    final query = await _firestore
        .collection(
        'courses/$language/levels/$proficiency/chapters/$chapterId/lessons')
        .where('order', isEqualTo: order)
        .limit(1)
        .get();
    return query.docs.isNotEmpty ? query.docs.first.id : null;
  }

  Future<int?> getAdjacentChapterOrder({
    required String language,
    required String proficiency,
    required String chapterId,
  }) async {
    final doc = await _firestore
        .collection('courses/$language/levels/$proficiency/chapters')
        .doc(chapterId)
        .get();
    return doc['order'];
  }

  Future<String?> getAdjacentChapterId({
    required String language,
    required String proficiency,
    required int order,
  }) async {
    final query = await _firestore
        .collection('courses/$language/levels/$proficiency/chapters')
        .where('order', isEqualTo: order)
        .limit(1)
        .get();
    return query.docs.isNotEmpty ? query.docs.first.id : null;
  }

  Future<int> getLastLessonIdInChapter({
    required String language,
    required String proficiency,
    required String chapterId,
  }) async {
    final query = await _firestore
        .collection(
        'courses/$language/levels/$proficiency/chapters/$chapterId/lessons')
        .orderBy('order', descending: true)
        .limit(1)
        .get();
    return query.docs.first['order'];
  }


  Future<String?> getFirstLessonId({
    required String language,
    required String proficiency,
    required String chapterId,
  }) async {
    final lessonsSnapshot = await _firestore
        .collection(
        'courses/$language/levels/$proficiency/chapters/$chapterId/lessons')
        .orderBy('order')
        .limit(1)
        .get();

    if (lessonsSnapshot.docs.isNotEmpty) {
      return lessonsSnapshot.docs.first.id;
    }
    return null;
  }

}