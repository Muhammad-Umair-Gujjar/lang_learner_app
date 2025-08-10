import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StreakProvider with ChangeNotifier {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  int _currentStreak = 0;
  bool _isLoading = false;

  StreakProvider({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance {
    initialize();
  }

  int get currentStreak => _currentStreak;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_auth.currentUser != null) {
        await updateStreak(); // handle streak logic directly
      }
    } catch (e) {
      debugPrint('Initialization error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateStreak() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      _isLoading = true;
      notifyListeners();

      final today = DateTime.now().toUtc();
      final userRef = _firestore.collection('users').doc(user.uid);

      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(userRef);
        final data = doc.data() as Map<String, dynamic>?;

        int newStreak = data?['current_streak'] ?? 0;
        final lastActive = (data?['last_active_date'] as Timestamp?)?.toDate();

        if (newStreak == 0 || lastActive == null) {
          // New user or no streak yet → start with 1
          newStreak = 1;
        } else if (!_isSameDate(lastActive, today)) {
          if (_isSameDate(lastActive, today.subtract(const Duration(days: 1)))) {
            newStreak++;
          } else {
            newStreak = 1;
          }
        }

        transaction.set(userRef, {
          'current_streak': newStreak,
          'last_active_date': today,
          'last_updated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        _currentStreak = newStreak;
      });
    } catch (e) {
      debugPrint('Error updating streak: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
