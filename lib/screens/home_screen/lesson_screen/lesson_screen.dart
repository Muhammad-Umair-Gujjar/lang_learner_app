import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../../provider/lesson_provider.dart';
import '../../../provider/user_progres_provider.dart';

// class LessonScreen extends StatefulWidget {
//   final String language;
//   final String proficiency;
//   final String chapterId;
//   final String lessonId;
//   final VoidCallback? onBackPressed;
//
//   const LessonScreen({
//     required this.language,
//     required this.proficiency,
//     required this.chapterId,
//     required this.lessonId,
//     Key? key, this.onBackPressed,
//   }) : super(key: key);
//
//   @override
//   _LessonScreenState createState() => _LessonScreenState();
// }
//
// class _LessonScreenState extends State<LessonScreen> {
// late FlutterTts flutterTts;
// late DocumentReference _lessonRef;
// Map<String, dynamic>? _lessonData;
// bool _showTranslation = false;
// int? _currentLessonOrder;
// int? _totalLessonsInChapter;
// bool _isLoading = true;
// String? _error;
//
// @override
// void initState() {
// super.initState();
// flutterTts = FlutterTts();
// _initializeLesson();
// }
//
// void _initializeLesson() {
// _lessonRef = FirebaseFirestore.instance
//     .collection('courses')
//     .doc(widget.language)
//     .collection('levels')
//     .doc(widget.proficiency)
//     .collection('chapters')
//     .doc(widget.chapterId)
//     .collection('lessons')
//     .doc(widget.lessonId);
//
// _loadLessonData();
// }
//
// Future<void> _loadLessonData() async {
// try {
// setState(() {
// _isLoading = true;
// _error = null;
// });
//
// final lessonSnapshot = await _lessonRef.get();
// if (!lessonSnapshot.exists) {
// throw Exception('Lesson not found at ${_lessonRef.path}');
// }
//
// final chapterLessonsQuery = await FirebaseFirestore.instance
//     .collection('courses')
//     .doc(widget.language)
//     .collection('levels')
//     .doc(widget.proficiency)
//     .collection('chapters')
//     .doc(widget.chapterId)
//     .collection('lessons')
//     .orderBy('order')
//     .get();
//
// setState(() {
// _lessonData = lessonSnapshot.data() as Map<String, dynamic>;
// _currentLessonOrder = _lessonData!['order'];
// _totalLessonsInChapter = chapterLessonsQuery.docs.length;
// _isLoading = false;
// });
// } catch (e) {
// setState(() {
// _error = 'Failed to load lesson: ${e.toString()}';
// _isLoading = false;
// });
// }
// }
//
// void _toggleTranslation() {
// setState(() {
// _showTranslation = !_showTranslation;
// });
// }
//
// // Future<void> _completeLesson() async {
// //   try {
// //     final userProgress = Provider.of<UserProgress>(context, listen: false);
// //
// //     // Mark lesson as completed
// //     await userProgress.completeLesson(
// //       language: widget.language,
// //       proficiency: widget.proficiency,
// //        chapterId: widget.chapterId,
// //        lessonId: widget.lessonId,
// //     );
// //
// //     // If it's the last lesson in this chapter
// //     if (_currentLessonOrder == _totalLessonsInChapter) {
// //       // Mark chapter as completed
// //       await FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(FirebaseAuth.instance.currentUser!.uid)
// //           .collection('progress')
// //           .doc(widget.language)
// //           .collection('levels')
// //           .doc(widget.proficiency)
// //           .set({
// //         'completedChapters': FieldValue.arrayUnion([widget.chapterId]),
// //         'lastUpdated': FieldValue.serverTimestamp(),
// //       }, SetOptions(merge: true));
// //
// //       // 🔁 Now get next chapter and its first lesson
// //       final chaptersSnapshot = await FirebaseFirestore.instance
// //           .collection('languages/${widget.language}/proficiencies/${widget.proficiency}/chapters')
// //           .orderBy('order')
// //           .get();
// //
// //       int currentIndex = chaptersSnapshot.docs.indexWhere((doc) => doc.id == widget.chapterId);
// //
// //       if (currentIndex != -1 && currentIndex + 1 < chaptersSnapshot.docs.length) {
// //         final nextChapter = chaptersSnapshot.docs[currentIndex + 1];
// //         final nextChapterId = nextChapter.id;
// //
// //         final firstLessonSnapshot = await FirebaseFirestore.instance
// //             .collection('languages/${widget.language}/proficiencies/${widget.proficiency}/chapters/$nextChapterId/lessons')
// //             .orderBy('order')
// //             .limit(1)
// //             .get();
// //
// //         if (firstLessonSnapshot.docs.isNotEmpty) {
// //           final nextLessonId = firstLessonSnapshot.docs.first.id;
// //
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => LessonScreen(
// //                 language: widget.language,
// //                 proficiency: widget.proficiency,
// //                 chapterId: nextChapterId,
// //                 lessonId: nextLessonId,
// //               ),
// //             ),
// //           );
// //
// //           return;
// //         }
// //       }
// //
// //       // ❗No next chapter/lesson found
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('You’ve completed all available chapters!')),
// //       );
// //
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => ChapterListScreen(
// //             language: widget.language,
// //             proficiency: widget.proficiency,
// //           ),
// //         ),
// //             (route) => route.isFirst,
// //       );
// //     } else {
// //       await _navigateToLesson(1);
// //     }
// //   } catch (e) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Failed to complete lesson')),
// //     );
// //   }
// // }
//
// // Replace _completeLesson in LessonScreen
// Future<void> _completeLesson() async {
// try {
// final progress = Provider.of<UserProgress>(context, listen: false);
//
// // Mark lesson complete
// await progress.completeLesson(
// language: widget.language,
// proficiency: widget.proficiency,
// chapterId: widget.chapterId,
// lessonId: widget.lessonId,
// );
//
// // If last lesson in chapter, mark chapter complete
// if (_currentLessonOrder == _totalLessonsInChapter) {
// await progress.completeChapter(
// language: widget.language,
// chapterId: widget.chapterId,
// );
//
// // Show completion message
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text('Chapter completed!')),
// );
// }
//
// // Navigate to next item
// await _navigateToLesson(1);
// } catch (e) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text('Error: ${e.toString()}')),
// );
// }
// }
//
//
// // Future<void> _completeLesson() async {
// //   try {
// //     final userProgress = Provider.of<UserProgress>(context, listen: false);
// //     await userProgress.completeLesson(
// //       language: widget.language,
// //       proficiency: widget.proficiency,
// //       chapterId: widget.chapterId,
// //       lessonId: widget.lessonId,
// //     );
// //   } catch (e) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Failed to mark lesson as completed')),
// //     );
// //   }
// // }
//
// // Future<void> _navigateToLesson(int direction) async {
// //   if (_currentLessonOrder == null) return;
// //
// //   final newOrder = _currentLessonOrder! + direction;
// //
// //   // Try to find next lesson in current chapter first
// //   if (newOrder >= 1 && newOrder <= _totalLessonsInChapter!) {
// //     final nextLessonQuery = await FirebaseFirestore.instance
// //         .collection('courses')
// //         .doc(widget.language)
// //         .collection('levels')
// //         .doc(widget.proficiency)
// //         .collection('chapters')
// //         .doc(widget.chapterId)
// //         .collection('lessons')
// //         .where('order', isEqualTo: newOrder)
// //         .limit(1)
// //         .get();
// //
// //     if (nextLessonQuery.docs.isNotEmpty) {
// //       final nextLessonId = nextLessonQuery.docs.first.id;
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => LessonScreen(
// //             language: widget.language,
// //             proficiency: widget.proficiency,
// //             chapterId: widget.chapterId,
// //             lessonId: nextLessonId,
// //           ),
// //         ),
// //       );
// //       return;
// //     }
// //   }
// //
// //   // If we're moving forward past the last lesson or backward past the first
// //   if ((direction == 1 && newOrder > _totalLessonsInChapter!) ||
// //       (direction == -1 && newOrder < 1)) {
// //     await _navigateToAdjacentChapter(direction);
// //   }
// // }
// //
// // Future<void> _navigateToAdjacentChapter(int direction) async {
// //   try {
// //     // Get current chapter order
// //     final currentChapterDoc = await FirebaseFirestore.instance
// //         .collection('courses')
// //         .doc(widget.language)
// //         .collection('levels')
// //         .doc(widget.proficiency)
// //         .collection('chapters')
// //         .doc(widget.chapterId)
// //         .get();
// //
// //     final currentChapterOrder = currentChapterDoc.data()?['order'] as int?;
// //     if (currentChapterOrder == null) return;
// //
// //     // Find adjacent chapter
// //     final adjacentChapterQuery = await FirebaseFirestore.instance
// //         .collection('courses')
// //         .doc(widget.language)
// //         .collection('levels')
// //         .doc(widget.proficiency)
// //         .collection('chapters')
// //         .where('order', isEqualTo: currentChapterOrder + direction)
// //         .limit(1)
// //         .get();
// //
// //     if (adjacentChapterQuery.docs.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text(direction > 0
// //             ? 'No more chapters available'
// //             : 'This is the first chapter')),
// //       );
// //       return;
// //     }
// //
// //     final adjacentChapter = adjacentChapterQuery.docs.first;
// //     final adjacentChapterId = adjacentChapter.id;
// //
// //     // Find first or last lesson in adjacent chapter based on direction
// //     final lessonOrder = direction > 0 ? 1 : await _getLastLessonOrder(adjacentChapterId);
// //
// //     final lessonQuery = await FirebaseFirestore.instance
// //         .collection('courses')
// //         .doc(widget.language)
// //         .collection('levels')
// //         .doc(widget.proficiency)
// //         .collection('chapters')
// //         .doc(adjacentChapterId)
// //         .collection('lessons')
// //         .where('order', isEqualTo: lessonOrder)
// //         .limit(1)
// //         .get();
// //
// //     if (lessonQuery.docs.isNotEmpty) {
// //       final lessonId = lessonQuery.docs.first.id;
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => LessonScreen(
// //             language: widget.language,
// //             proficiency: widget.proficiency,
// //             chapterId: adjacentChapterId,
// //             lessonId: lessonId,
// //           ),
// //         ),
// //       );
// //     }
// //   } catch (e) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Failed to navigate: ${e.toString()}')),
// //     );
// //   }
// // }
// //
// // Future<int> _getLastLessonOrder(String chapterId) async {
// //   final query = await FirebaseFirestore.instance
// //       .collection('courses')
// //       .doc(widget.language)
// //       .collection('levels')
// //       .doc(widget.proficiency)
// //       .collection('chapters')
// //       .doc(chapterId)
// //       .collection('lessons')
// //       .orderBy('order', descending: true)
// //       .limit(1)
// //       .get();
// //
// //   return query.docs.first.data()['order'] as int;
// // }
//
// // Future<void> _navigateToLesson(int direction) async {
// //   if (_currentLessonOrder == null) return;
// //
// //   final newOrder = _currentLessonOrder! + direction;
// //
// //   if (newOrder < 1) return;
// //
// //   try {
// //     // If within same chapter
// //     if (_totalLessonsInChapter != null && newOrder <= _totalLessonsInChapter!) {
// //       final nextLessonQuery = await FirebaseFirestore.instance
// //           .collection('courses')
// //           .doc(widget.language)
// //           .collection('levels')
// //           .doc(widget.proficiency)
// //           .collection('chapters')
// //           .doc(widget.chapterId)
// //           .collection('lessons')
// //           .where('order', isEqualTo: newOrder)
// //           .limit(1)
// //           .get();
// //
// //       if (nextLessonQuery.docs.isNotEmpty) {
// //         final nextLessonId = nextLessonQuery.docs.first.id;
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(
// //             builder: (_) => LessonScreen(
// //               language: widget.language,
// //               proficiency: widget.proficiency,
// //               chapterId: widget.chapterId,
// //               lessonId: nextLessonId,
// //             ),
// //           ),
// //         );
// //         return;
// //       }
// //     }
// //
// //     // ➕ Try moving to the next chapter
// //     final currentChapterDoc = await FirebaseFirestore.instance
// //         .collection('courses')
// //         .doc(widget.language)
// //         .collection('levels')
// //         .doc(widget.proficiency)
// //         .collection('chapters')
// //         .doc(widget.chapterId)
// //         .get();
// //
// //     final currentChapterOrder = currentChapterDoc.data()?['order'];
// //     if (currentChapterOrder == null) return;
// //
// //     final nextChapterQuery = await FirebaseFirestore.instance
// //         .collection('courses')
// //         .doc(widget.language)
// //         .collection('levels')
// //         .doc(widget.proficiency)
// //         .collection('chapters')
// //         .where('order', isEqualTo: currentChapterOrder + 1)
// //         .limit(1)
// //         .get();
// //
// //     if (nextChapterQuery.docs.isEmpty) return;
// //
// //     final nextChapter = nextChapterQuery.docs.first;
// //     final nextChapterId = nextChapter.id;
// //
// //     final firstLessonQuery = await FirebaseFirestore.instance
// //         .collection('courses')
// //         .doc(widget.language)
// //         .collection('levels')
// //         .doc(widget.proficiency)
// //         .collection('chapters')
// //         .doc(nextChapterId)
// //         .collection('lessons')
// //         .where('order', isEqualTo: 1)
// //         .limit(1)
// //         .get();
// //
// //     if (firstLessonQuery.docs.isNotEmpty) {
// //       final firstLessonId = firstLessonQuery.docs.first.id;
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => LessonScreen(
// //             language: widget.language,
// //             proficiency: widget.proficiency,
// //             chapterId: nextChapterId,
// //             lessonId: firstLessonId,
// //           ),
// //         ),
// //       );
// //     }
// //   } catch (e) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Failed to navigate to next lesson')),
// //     );
// //   }
// // }
//
// Future<void> _navigateToLesson(int direction) async {
// if (_currentLessonOrder == null) {
// print('[ERROR] _currentLessonOrder is null');
// return;
// }
//
// final newOrder = _currentLessonOrder! + direction;
// print('[INFO] Trying to navigate from lesson $_currentLessonOrder to $newOrder in chapter ${widget.chapterId}');
//
// // Try to find next lesson in current chapter first
// if (newOrder >= 1 && newOrder <= _totalLessonsInChapter!) {
// print('[INFO] Searching for lesson with order $newOrder in current chapter');
//
// final nextLessonQuery = await FirebaseFirestore.instance
//     .collection('courses')
//     .doc(widget.language)
//     .collection('levels')
//     .doc(widget.proficiency)
//     .collection('chapters')
//     .doc(widget.chapterId)
//     .collection('lessons')
//     .where('order', isEqualTo: newOrder)
//     .limit(1)
//     .get();
//
// print('[DEBUG] Lesson query found ${nextLessonQuery.docs.length} documents for order $newOrder');
//
// if (nextLessonQuery.docs.isNotEmpty) {
// final nextLessonId = nextLessonQuery.docs.first.id;
// print('[SUCCESS] Navigating to lesson ID: $nextLessonId');
// Navigator.pushReplacement(
// context,
// MaterialPageRoute(
// builder: (_) => LessonScreen(
// language: widget.language,
// proficiency: widget.proficiency,
// chapterId: widget.chapterId,
// lessonId: nextLessonId,
// ),
// ),
// );
// return;
// } else {
// print('[WARN] No lesson found with order $newOrder in current chapter');
// }
// }
//
// // Move to adjacent chapter if at boundary
// if ((direction == 1 && newOrder > _totalLessonsInChapter!) ||
// (direction == -1 && newOrder < 1)) {
// print('[INFO] Reached chapter boundary. Navigating to adjacent chapter...');
// await _navigateToAdjacentChapter(direction);
// }
// }
// Future<void> _navigateToAdjacentChapter(int direction) async {
// try {
// print('[INFO] Attempting to navigate to ${direction > 0 ? 'next' : 'previous'} chapter from ${widget.chapterId}');
//
// final currentChapterDoc = await FirebaseFirestore.instance
//     .collection('courses')
//     .doc(widget.language)
//     .collection('levels')
//     .doc(widget.proficiency)
//     .collection('chapters')
//     .doc(widget.chapterId)
//     .get();
//
// final currentChapterOrder = currentChapterDoc.data()?['order'] as int?;
// print('[DEBUG] Current chapter order: $currentChapterOrder');
//
// if (currentChapterOrder == null) {
// print('[ERROR] Current chapter has no "order" field');
// return;
// }
//
// final targetOrder = currentChapterOrder + direction;
// print('[INFO] Looking for adjacent chapter with order: $targetOrder');
//
// final adjacentChapterQuery = await FirebaseFirestore.instance
//     .collection('courses')
//     .doc(widget.language)
//     .collection('levels')
//     .doc(widget.proficiency)
//     .collection('chapters')
//     .where('order', isEqualTo: targetOrder)
//     .limit(1)
//     .get();
//
// print('[DEBUG] Found ${adjacentChapterQuery.docs.length} chapter(s) with order $targetOrder');
//
// if (adjacentChapterQuery.docs.isEmpty) {
// print('[WARN] No adjacent chapter found with order: $targetOrder');
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text(direction > 0
// ? 'No more chapters available'
//     : 'This is the first chapter')),
// );
// return;
// }
//
// final adjacentChapter = adjacentChapterQuery.docs.first;
// final adjacentChapterId = adjacentChapter.id;
// print('[SUCCESS] Found adjacent chapter ID: $adjacentChapterId');
//
// final lessonOrder = direction > 0 ? 1 : await _getLastLessonOrder(adjacentChapterId);
// print('[INFO] Will try to open lesson with order $lessonOrder in $adjacentChapterId');
//
// final lessonQuery = await FirebaseFirestore.instance
//     .collection('courses')
//     .doc(widget.language)
//     .collection('levels')
//     .doc(widget.proficiency)
//     .collection('chapters')
//     .doc(adjacentChapterId)
//     .collection('lessons')
//     .where('order', isEqualTo: lessonOrder)
//     .limit(1)
//     .get();
//
// print('[DEBUG] Found ${lessonQuery.docs.length} lessons with order $lessonOrder');
//
// if (lessonQuery.docs.isNotEmpty) {
// final lessonId = lessonQuery.docs.first.id;
// print('[SUCCESS] Navigating to lesson ID: $lessonId in chapter $adjacentChapterId');
//
// Navigator.pushReplacement(
// context,
// MaterialPageRoute(
// builder: (_) => LessonScreen(
// language: widget.language,
// proficiency: widget.proficiency,
// chapterId: adjacentChapterId,
// lessonId: lessonId,
// ),
// ),
// );
// } else {
// print('[ERROR] No lesson with order $lessonOrder found in adjacent chapter');
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text('Next chapter found but has no lessons.')),
// );
// }
// } catch (e) {
// print('[EXCEPTION] Error while navigating to adjacent chapter: $e');
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text('Failed to navigate: ${e.toString()}')),
// );
// }
// }
// Future<int> _getLastLessonOrder(String chapterId) async {
// print('[INFO] Getting last lesson order in chapter: $chapterId');
//
// final query = await FirebaseFirestore.instance
//     .collection('courses')
//     .doc(widget.language)
//     .collection('levels')
//     .doc(widget.proficiency)
//     .collection('chapters')
//     .doc(chapterId)
//     .collection('lessons')
//     .orderBy('order', descending: true)
//     .limit(1)
//     .get();
//
// final lastOrder = query.docs.first.data()['order'] as int;
// print('[SUCCESS] Last lesson order in chapter $chapterId is $lastOrder');
// return lastOrder;
// }
//
// @override
// Widget build(BuildContext context) {
// if (_isLoading) {
// return Scaffold(
// body: Center(child: CircularProgressIndicator()),
// );
// }
//
// if (_error != null) {
// return Scaffold(
// appBar: AppBar(title: Text('Error')),
// body: Center(child: Text(_error!)),
// );
// }
//
// if (_lessonData == null) {
// return Scaffold(
// appBar: AppBar(title: Text('Lesson')),
// body: Center(child: Text('Lesson data not available')),
// );
// }
//
// return Scaffold(
// appBar: AppBar(
// centerTitle: true,
// backgroundColor: primaryRed,
// leading: IconButton(
// icon: Icon(Icons.arrow_back,color: white,),
// onPressed: () {
// if (widget.onBackPressed != null) {
// widget.onBackPressed!(); // Custom back navigation
// } else {
// Navigator.pop(context); // Default back behavior
// }
// },
// ),
// title: Text('Lesson ${_lessonData!['order']}', style: TextStyle(color: Colors.white)),
// actions: [
// IconButton(
// icon: Icon(Icons.volume_up,color: white,),
// onPressed: () {
// if (_lessonData != null) {
// flutterTts.speak(_lessonData!['content']);
// }
// },
// ),
// ],
// ),
// body: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// SingleChildScrollView(
// padding: EdgeInsets.all(16),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Card(
// elevation: 4,
// child: Padding(
// padding: EdgeInsets.all(16),
// child: Column(
// children: [
// Text(
// _lessonData!['content'],
// style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
// textAlign: TextAlign.center,
// ),
// SizedBox(height: 10),
// Text(
// _lessonData!['pronunciation'],
// style: TextStyle(fontSize: 18, color: Colors.grey),
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ),
// ),
// SizedBox(height: 20),
// ElevatedButton(
// onPressed: _toggleTranslation,
// style: ElevatedButton.styleFrom(backgroundColor: primaryRed),
// child: Text(
// _showTranslation ? 'Hide Translation' : 'Show Translation',
// style: TextStyle(color: white),
// ),
// ),
// if (_showTranslation) ...[
// SizedBox(height: 20),
// Card(
// color: Colors.blue[50],
// child: Padding(
// padding: EdgeInsets.all(16),
// child: Text(
// _lessonData!['translation'],
// style: TextStyle(fontSize: 20),
// textAlign: TextAlign.center,
// ),
// ),
// ),
// ],
// Padding(
// padding: EdgeInsets.symmetric( vertical: 20),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// TextButton(
// onPressed: () {
// _navigateToLesson(-1);},
// child: Text('Previous',style: TextStyle(color: primaryRed),),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
// onPressed: () {
// _completeLesson();
// Navigator.pop(context);
// },
// child: Text('Complete Lesson',style: TextStyle(color: Colors.white),),
// ),
// TextButton(
// onPressed: () => _navigateToLesson(1),
// child: Text('Next',style: TextStyle(color: primaryRed),),
// ),
// ],
// ),
// ),
// ],
//
// ),
// ),
// ],
// ),
// );
// }
// }

class LessonScreen extends StatefulWidget {
  final String language, proficiency, chapterId, lessonId;
  final VoidCallback? onBackPressed;

  const LessonScreen({
    required this.language,
    required this.proficiency,
    required this.chapterId,
    required this.lessonId,
    this.onBackPressed,
    super.key,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late FlutterTts tts;

  @override
  void initState() {
    super.initState();
    tts = FlutterTts();
    Future.microtask(() {
      final provider = Provider.of<LessonProvider>(context, listen: false);
      provider.loadLesson(
        language: widget.language,
        proficiency: widget.proficiency,
        chapterId: widget.chapterId,
        lessonId: widget.lessonId,
      );
    });
  }

  Future<void> _completeLesson(BuildContext context) async {
    final userProgress = Provider.of<UserProgress>(context, listen: false);

    await userProgress.completeLesson(
      language: widget.language,
      proficiency: widget.proficiency,
      chapterId: widget.chapterId,
      lessonId: widget.lessonId,
    );
    _navigateToNextLesson(context, 1);
  }

  Future<void> _navigateToNextLesson(
    BuildContext context,
    int direction,
  ) async {
    final provider = Provider.of<LessonProvider>(context, listen: false);
    final newOrder = (provider.currentLessonOrder ?? 0) + direction;

    if (newOrder >= 1 && newOrder <= (provider.totalLessonsInChapter ?? 0)) {
      final nextId = await provider.getLessonIdByOrder(
        language: widget.language,
        proficiency: widget.proficiency,
        chapterId: widget.chapterId,
        order: newOrder,
      );

      if (nextId != null) {
        _navigateToLesson(nextId);
      }
    } else {
      final currentChapterOrder = await provider.getAdjacentChapterOrder(
        language: widget.language,
        proficiency: widget.proficiency,
        chapterId: widget.chapterId,
      );

      final adjacentChapterId = await provider.getAdjacentChapterId(
        language: widget.language,
        proficiency: widget.proficiency,
        order: (currentChapterOrder ?? 0) + direction,
      );

      if (adjacentChapterId != null) {
        final nextLessonId = direction > 0
            ? await provider.getLessonIdByOrder(
                language: widget.language,
                proficiency: widget.proficiency,
                chapterId: adjacentChapterId,
                order: 1,
              )
            : await provider.getLastLessonIdInChapter(
                language: widget.language,
                proficiency: widget.proficiency,
                chapterId: adjacentChapterId,
              );

        if (nextLessonId != null) {
          _navigateToLesson(
            nextLessonId as String,
            chapterId: adjacentChapterId,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              direction > 0
                  ? 'No more chapters.'
                  : 'This is the first chapter.',
            ),
          ),
        );
      }
    }
  }

  void _navigateToLesson(String lessonId, {String? chapterId}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          language: widget.language,
          proficiency: widget.proficiency,
          chapterId: chapterId ?? widget.chapterId,
          lessonId: lessonId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LessonProvider>(
      builder: (context, lessonProvider, child) {
        if (lessonProvider.isLoading)
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        if (lessonProvider.error != null)
          return Scaffold(body: Center(child: Text(lessonProvider.error!)));

        final data = lessonProvider.lessonData;
        if (data == null)
          return Scaffold(body: Center(child: Text('No lesson data')));

        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryRed,
            title: Text(
              'Lesson ${data['order']}',
              style: TextStyle(color: white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: white),
              onPressed: widget.onBackPressed ?? () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.volume_up, color: white),
                onPressed: () => tts.speak(data['content']),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                data['content'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                data['pronunciation'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: lessonProvider.toggleTranslation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                        ),
                        child: Text(
                          lessonProvider.showTranslation
                              ? 'Hide Translation'
                              : 'Show Translation',
                          style: TextStyle(color: white),
                        ),
                      ),
                      if (lessonProvider.showTranslation)
                        Card(
                          color: Colors.blue[50],
                          margin: EdgeInsets.only(top: 20),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              data['translation'],
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _navigateToNextLesson(context, -1),
                            child: Text(
                              'Previous',
                              style: TextStyle(color: primaryRed),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () => _completeLesson(context),
                            child: Text(
                              'Complete Lesson',
                              style: TextStyle(color: white),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _navigateToNextLesson(context, 1),
                            child: Text('Next', style: TextStyle(color: primaryRed)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
