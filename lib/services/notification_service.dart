import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quizflutter/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );
    await _notificationsPlugin.initialize(initializationSettings);

    // Schedule daily notification
    await scheduleDailyNotification();

    // Check for new categories
    await checkForNewCategories();
  }

  Future<void> scheduleDailyNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'daily_quiz_reminder',
      'Daily Quiz Reminder',
      channelDescription: 'Reminds users to play a quiz daily',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.periodicallyShow(
      0,
      'Time to Quiz!',
      'Come back and test your knowledge!',
      RepeatInterval.daily,
      notificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> checkForNewCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final apiService = ApiService();
    final categories = await apiService.fetchCategories();
    final storedCategories = prefs.getStringList('categories') ?? [];

    if (categories.length > storedCategories.length) {
      const androidDetails = AndroidNotificationDetails(
        'new_category',
        'New Category',
        channelDescription: 'Notifies users about new quiz categories',
        importance: Importance.max,
        priority: Priority.high,
      );
      const notificationDetails = NotificationDetails(android: androidDetails);

      await _notificationsPlugin.show(
        1,
        'New Categories Available!',
        'Check out the new quiz categories!',
        notificationDetails,
      );

      await prefs.setStringList('categories', categories);
    }
  }
}