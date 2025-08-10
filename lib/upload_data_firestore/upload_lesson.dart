import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/lessons/Italian/advanced_italian_lessons.dart';
import 'package:flutter_project/utils/lessons/Italian/intermediate_italian_lessons.dart';
import '../core/constants.dart';
import '../utils/lessons/Italian/beginner_italian_lessons.dart';
class UploadLesson extends StatefulWidget {
  const UploadLesson({super.key});

  @override
  State<UploadLesson> createState() => _UploadLessonState();
}
class _UploadLessonState extends State<UploadLesson> {
  // Future<void> uploadCourse() async {
  //   final firestore = FirebaseFirestore.instance;
  //   final batch = firestore.batch();
  //
  //   // 1. Create or update language document
  //   final languageRef = firestore.collection('courses').doc('italian');
  //   batch.set(languageRef, {
  //     'name': 'Italian',
  //     'flag': '🇮🇹',
  //     'proficiencyLevels': ['intermediate'], // Can add more levels later
  //     'lastUpdated': FieldValue.serverTimestamp(),
  //     'createdAt': FieldValue.serverTimestamp()
  //   });
  //
  //   // 2. Create proficiency level document
  //   final courseRef = languageRef.collection('levels').doc('intermediate');
  //   batch.set(courseRef, {
  //     'name': 'Intermediate Italian',
  //     'description': 'Basic Italian phrases for complete beginners',
  //     'totalLessons': 50,
  //     'totalChapters': 5,
  //     'estimatedCompletionTime': '4 weeks',
  //     'lastUpdated': FieldValue.serverTimestamp(),
  //     'createdAt': FieldValue.serverTimestamp()
  //   });
  //
  //   // 3. Create chapters collection with documents
  //   final chapters = [
  //     {'id': 'greetings', 'name': 'Greetings', 'order': 1, 'totalLessons': 10},
  //     {'id': 'basics', 'name': 'Basic Phrases', 'order': 2, 'totalLessons': 10},
  //     {'id': 'food', 'name': 'Food & Dining', 'order': 3, 'totalLessons': 10},
  //     {'id': 'travel', 'name': 'Travel', 'order': 4, 'totalLessons': 10},
  //     {'id': 'shopping', 'name': 'Shopping', 'order': 5, 'totalLessons': 10},
  //   ];
  //
  //   for (final chapter in chapters) {
  //     final chapterRef = courseRef.collection('chapters').doc(chapter['id'] as String);
  //     batch.set(chapterRef, {
  //       'name': chapter['name'],
  //       'order': chapter['order'],
  //       'totalLessons': chapter['totalLessons'],
  //       'lastUpdated': FieldValue.serverTimestamp(),
  //       'createdAt': FieldValue.serverTimestamp()
  //     });
  //   }
  //
  //   // 4. Add all lessons to their respective chapters
  //   for (final lesson in beginnerItalianCourse['lessons']) {
  //     final lessonRef = courseRef
  //         .collection('chapters')
  //         .doc(lesson['category'])
  //         .collection('lessons')
  //         .doc(lesson['lessonId']);
  //
  //     final lessonData = {
  //       'order': lesson['order'],
  //       'content': lesson['content'],
  //       'translation': lesson['translation'], // Fixed typo from 'translation'
  //       'pronunciation': lesson['pronunciation'],
  //       'category': lesson['category'],
  //       'lastUpdated': FieldValue.serverTimestamp(),
  //       'createdAt': FieldValue.serverTimestamp()
  //     };
  //
  //     batch.set(lessonRef, lessonData);
  //   }
  //
  //   try {
  //     await batch.commit();
  //     print('Successfully uploaded Italian beginner course with:');
  //     print('- 1 language document');
  //     print('- 1 proficiency level document');
  //     print('- ${chapters.length} chapter documents');
  //     print('- ${beginnerItalianCourse['lessons'].length} lesson documents');
  //   } catch (e) {
  //     print('Error uploading course: $e');
  //     // Consider adding retry logic or partial upload handling
  //   }
  // }

  // Future<void> uploadIntermediateCourse() async {
  //   final firestore = FirebaseFirestore.instance;
  //   final batch = firestore.batch();
  //
  //   // 1. Update language document to include intermediate level
  //   final languageRef = firestore.collection('courses').doc('italian');
  //   batch.update(languageRef, {
  //     'proficiencyLevels': FieldValue.arrayUnion(['intermediate']),
  //     'lastUpdated': FieldValue.serverTimestamp()
  //   });
  //
  //   // 2. Create intermediate proficiency level document
  //   final courseRef = languageRef.collection('levels').doc('intermediate');
  //   batch.set(courseRef, {
  //     'name': 'Intermediate Italian',
  //     'description': 'Intermediate Italian phrases for everyday situations',
  //     'totalLessons': 36, // 6 chapters x 6 lessons
  //     'totalChapters': 6,
  //     'estimatedCompletionTime': '6 weeks',
  //     'lastUpdated': FieldValue.serverTimestamp(),
  //     'createdAt': FieldValue.serverTimestamp()
  //   });
  //
  //   // 3. Create chapters collection with documents
  //   final chapters = [
  //     {'id': 'politeness', 'name': 'Polite Communication', 'order': 1, 'totalLessons': 6},
  //     {'id': 'dining', 'name': 'Dining & Food', 'order': 2, 'totalLessons': 6},
  //     {'id': 'shopping', 'name': 'Shopping & Transactions', 'order': 3, 'totalLessons': 6},
  //     {'id': 'transport', 'name': 'Transportation', 'order': 4, 'totalLessons': 6},
  //     {'id': 'accommodation', 'name': 'Accommodation', 'order': 5, 'totalLessons': 6},
  //     {'id': 'problems', 'name': 'Problem Solving', 'order': 6, 'totalLessons': 6},
  //   ];
  //
  //   for (final chapter in chapters) {
  //     final chapterRef = courseRef.collection('chapters').doc(chapter['id'] as String);
  //     batch.set(chapterRef, {
  //       'name': chapter['name'],
  //       'order': chapter['order'],
  //       'totalLessons': chapter['totalLessons'],
  //       'lastUpdated': FieldValue.serverTimestamp(),
  //       'createdAt': FieldValue.serverTimestamp()
  //     });
  //   }
  //
  //   // 4. Add all intermediate lessons to their respective chapters
  //   for (final lesson in intermediateItalianLessons['lessons']) {
  //     final lessonRef = courseRef
  //         .collection('chapters')
  //         .doc(lesson['category'])
  //         .collection('lessons')
  //         .doc(lesson['lessonId']);
  //
  //     batch.set(lessonRef, {
  //       'order': lesson['order'],
  //       'content': lesson['content'],
  //       'translation': lesson['translation'],
  //       'pronunciation': lesson['pronunciation'],
  //       'category': lesson['category'],
  //       'notes': lesson['notes'], // Added notes field
  //       'lastUpdated': FieldValue.serverTimestamp(),
  //       'createdAt': FieldValue.serverTimestamp()
  //     });
  //   }
  //
  //   try {
  //     await batch.commit();
  //     print('Successfully uploaded Italian intermediate course with:');
  //     print('- Updated language document');
  //     print('- 1 proficiency level document (intermediate)');
  //     print('- ${chapters.length} chapter documents');
  //     print('- ${intermediateItalianLessons['lessons'].length} lesson documents');
  //   } catch (e) {
  //     print('Error uploading intermediate course: $e');
  //     // Consider adding retry logic or error reporting
  //   }
  // }
  Future<void> uploadAdvancedCourse() async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    // 1. Update language document to include advanced level
    final languageRef = firestore.collection('courses').doc('italian');
    batch.update(languageRef, {
      'proficiencyLevels': FieldValue.arrayUnion(['advanced']),
      'lastUpdated': FieldValue.serverTimestamp()
    });

    // 2. Create advanced proficiency level document
    final courseRef = languageRef.collection('levels').doc('advanced');
    batch.set(courseRef, {
      'name': 'Advanced Italian',
      'description': 'Advanced Italian for professional and academic contexts',
      'totalLessons': 42, // 7 chapters x 6 lessons
      'totalChapters': 7,
      'estimatedCompletionTime': '8 weeks',
      'lastUpdated': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp()
    });

    // 3. Create chapters collection with documents
    final chapters = [
      {'id': 'business', 'name': 'Business Communication', 'order': 1, 'totalLessons': 6},
      {'id': 'politics', 'name': 'Politics & Current Affairs', 'order': 2, 'totalLessons': 6},
      {'id': 'arts', 'name': 'Literature & Arts', 'order': 3, 'totalLessons': 6},
      {'id': 'technology', 'name': 'Science & Technology', 'order': 4, 'totalLessons': 6},
      {'id': 'legal', 'name': 'Legal Matters', 'order': 5, 'totalLessons': 6},
      {'id': 'philosophy', 'name': 'Philosophy', 'order': 6, 'totalLessons': 6},
      {'id': 'idioms', 'name': 'Nuances & Idioms', 'order': 7, 'totalLessons': 6},
    ];

    for (final chapter in chapters) {
      final chapterRef = courseRef.collection('chapters').doc(chapter['id'] as String);
      batch.set(chapterRef, {
        'name': chapter['name'],
        'order': chapter['order'],
        'totalLessons': chapter['totalLessons'],
        'lastUpdated': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp()
      });
    }

    // 4. Add all advanced lessons to their respective chapters
    for (final lesson in advancedItalianLessons['lessons']) {
      final lessonRef = courseRef
          .collection('chapters')
          .doc(lesson['category'])
          .collection('lessons')
          .doc(lesson['lessonId']);

      batch.set(lessonRef, {
        'order': lesson['order'],
        'content': lesson['content'],
        'translation': lesson['translation'],
        'pronunciation': lesson['pronunciation'],
        'category': lesson['category'],
        'notes': lesson['notes'],
        'lastUpdated': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp()
      });
    }

    try {
      await batch.commit();
      print('Successfully uploaded Italian advanced course with:');
      print('- Updated language document');
      print('- 1 proficiency level document (advanced)');
      print('- ${chapters.length} chapter documents');
      print('- ${advancedItalianLessons['lessons'].length} lesson documents');
    } catch (e) {
      print('Error uploading advanced course: $e');
      // Consider adding retry logic or error reporting
    }
  }

  Future<void> updateLessonOrders({
    required String language,
    required String proficiency,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final chaptersRef = firestore
        .collection('courses')
        .doc(language)
        .collection('levels')
        .doc(proficiency)
        .collection('chapters');

    final chapters = await chaptersRef.get();
    print('Found ${chapters.docs.length} chapters');

    for (final chapter in chapters.docs) {
      final chapterId = chapter.id;
      final lessonsRef = chaptersRef.doc(chapterId).collection('lessons');

      final lessonsSnapshot = await lessonsRef
          .orderBy('order') // fallback: use .orderBy('name') if needed
          .get();

      print('Updating ${lessonsSnapshot.docs.length} lessons in chapter "$chapterId"...');

      int newOrder = 1;

      final batch = firestore.batch();

      for (final lesson in lessonsSnapshot.docs) {
        final lessonRef = lesson.reference;
        batch.update(lessonRef, {'order': newOrder});
        print('  → ${lesson.id} → order: $newOrder');
        newOrder++;
      }

      await batch.commit();
      print('✅ Chapter "$chapterId" updated.');
    }

    print('🎉 All chapters updated.');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Text("Upload Lesson",style: TextStyle(
            color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Press the following button to upload quiz")),
          Center(
            child: TextButton(onPressed: (){
              uploadAdvancedCourse();
            }, child: Text("Upolad Lesson")),
          ),
          SizedBox(height: 30,),
          Center(
            child: TextButton(onPressed: (){
              updateLessonOrders(language: "italian", proficiency: "advanced");
            }, child: Text("Update Lesson")),
          )

        ],
      ),
    );
  }
}
