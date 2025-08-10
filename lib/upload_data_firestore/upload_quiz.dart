import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../utils/quizes/italian/advanced_italian_quiz.dart';
import '../utils/quizes/italian/intermediate_italian_quiz.dart';
class UploadQuiz extends StatefulWidget {
  const UploadQuiz({super.key});

  @override
  State<UploadQuiz> createState() => _UploadQuizState();
}

class _UploadQuizState extends State<UploadQuiz> {

  // Future<void> uploadBeginnerQuizzes() async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   try {
  //     // Reference to the beginner level document
  //     final DocumentReference beginnerLevelRef = firestore
  //         .collection('quizzes')
  //         .doc('italian')
  //         .collection('levels')
  //         .doc('beginner');
  //
  //     // Create or overwrite the beginner level document
  //     await beginnerLevelRef.set({
  //       'name': 'Beginner',
  //       'order': 1,
  //     });
  //
  //     // Reference to the chapters subcollection
  //     final CollectionReference chaptersCollection =
  //     beginnerLevelRef.collection('chapters');
  //
  //     // Upload each chapter from the data
  //     for (var chapter in beginnerItalianQuizzes['quizzes']) {
  //       final chapterDocRef = chaptersCollection.doc(chapter['chapterId']);
  //
  //       await chapterDocRef.set({
  //         'title': chapter['title'],
  //         'order': chapter['order'],
  //       });
  //
  //       // Upload questions for each chapter
  //       final CollectionReference questionsCollection =
  //       chapterDocRef.collection('questions');
  //
  //       for (var question in chapter['quiz']) {
  //         await questionsCollection.add({
  //           'type': question['type'],
  //           'question': question['question'],
  //           'options': question['options'] ?? [],
  //           'pairs': question['pairs'] ?? {},
  //           'correctAnswer': question['correctAnswer'],
  //         });
  //       }
  //     }
  //
  //     print('✅ Italian beginner quizzes uploaded successfully!');
  //   } catch (e) {
  //     print('❌ Error uploading quizzes: $e');
  //     rethrow;
  //   }
  // }
  Future<void> uploadAdvancedQuizzes() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Reference to the advanced level document
      final DocumentReference advancedLevelRef = firestore
          .collection('quizzes')
          .doc('italian')
          .collection('levels')
          .doc('advanced');

      // Create or overwrite the advanced level document
      await advancedLevelRef.set({
        'name': 'Advanced',
        'order': 3, // Next level after intermediate
      });

      // Reference to the chapters subcollection
      final CollectionReference chaptersCollection =
      advancedLevelRef.collection('chapters');

      // Upload each chapter from the advanced data
      for (var chapter in advancedItalianQuizzes['quizzes']) {
        final chapterDocRef = chaptersCollection.doc(chapter['chapterId']);

        await chapterDocRef.set({
          'title': chapter['title'],
          'order': chapter['order'],
        });

        // Upload questions for each chapter
        final CollectionReference questionsCollection =
        chapterDocRef.collection('questions');

        for (var question in chapter['quiz']) {
          await questionsCollection.add({
            'type': question['type'],
            'question': question['question'],
            'options': question['options'] ?? [],
            'pairs': question['pairs'] ?? {},
            'correctAnswer': question['correctAnswer'],
            'createdAt': FieldValue.serverTimestamp(), // Add timestamp
          });
        }
      }

      print('✅ Italian advanced quizzes uploaded successfully!');
    } catch (e) {
      print('❌ Error uploading advanced quizzes: $e');
      rethrow;
    }
  }

  // Future<void> uploadIntermediateQuizzes() async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   try {
  //     // Reference to the intermediate level document
  //     final DocumentReference intermediateLevelRef = firestore
  //         .collection('quizzes')
  //         .doc('italian')
  //         .collection('levels')
  //         .doc('intermediate');
  //
  //     // Create or overwrite the intermediate level document
  //     await intermediateLevelRef.set({
  //       'name': 'Intermediate',
  //       'order': 2, // Next level after beginner
  //     });
  //
  //     // Reference to the chapters subcollection
  //     final CollectionReference chaptersCollection =
  //     intermediateLevelRef.collection('chapters');
  //
  //     // Upload each chapter from the intermediate data
  //     for (var chapter in intermediateItalianQuizzes['quizzes']) {
  //       final chapterDocRef = chaptersCollection.doc(chapter['chapterId']);
  //
  //       await chapterDocRef.set({
  //         'title': chapter['title'],
  //         'order': chapter['order'],
  //       });
  //
  //       // Upload questions for each chapter
  //       final CollectionReference questionsCollection =
  //       chapterDocRef.collection('questions');
  //
  //       for (var question in chapter['quiz']) {
  //         await questionsCollection.add({
  //           'type': question['type'],
  //           'question': question['question'],
  //           'options': question['options'] ?? [],
  //           'pairs': question['pairs'] ?? {},
  //           'correctAnswer': question['correctAnswer'],
  //           'createdAt': FieldValue.serverTimestamp(), // Add timestamp
  //         });
  //       }
  //     }
  //
  //     print('✅ Italian intermediate quizzes uploaded successfully!');
  //   } catch (e) {
  //     print('❌ Error uploading intermediate quizzes: $e');
  //     rethrow;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Text("Upload Quiz",style: TextStyle(
            color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Press the following button to upload quiz"),
          TextButton(onPressed: (){
            uploadAdvancedQuizzes();
          }, child: Text("Upolad Quiz"))

        ],
      ),
    );
  }
}
