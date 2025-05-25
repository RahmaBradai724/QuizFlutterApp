import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/utils/localization.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);
    final isDarkMode = settings.isDarkMode;

    // Couleurs adaptées au thème (non-nullable)
    final primaryColor = isDarkMode ? Colors.purpleAccent[400]! : Colors.purple[700]!;
    final backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.grey[50]!;
    final cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.grey[900]!;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.grey[600]!;
    final dividerColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Section Apparence
            _buildSectionHeader(
              context,
              icon: Icons.palette,
              title: 'Appearance', // Replace with localizations.appearance when available
              isDarkMode: isDarkMode,
              textColor: textColor,
            ),
            _buildSettingTile(
              context,
              icon: Icons.dark_mode,
              title: localizations.darkMode,
              trailing: Switch(
                value: settings.isDarkMode,
                onChanged: (value) => settings.toggleDarkMode(value),
                activeColor: primaryColor,
              ),
              isDarkMode: isDarkMode,
              cardColor: cardColor,
              textColor: textColor,
            ),

            // Section Sons et vibrations
            _buildSectionHeader(
              context,
              icon: Icons.volume_up,
              title: 'Sounds & Vibration', // Replace with localizations.soundsAndVibration when available
              isDarkMode: isDarkMode,
              textColor: textColor,
            ),
            _buildSettingTile(
              context,
              icon: Icons.music_note,
              title: localizations.enableSounds,
              trailing: Switch(
                value: settings.soundsEnabled,
                onChanged: (value) => settings.setSoundEnabled(value),
                activeColor: primaryColor,
              ),
              isDarkMode: isDarkMode,
              cardColor: cardColor,
              textColor: textColor,
            ),
            _buildSettingTile(
              context,
              icon: Icons.vibration,
              title: localizations.enableVibrations,
              trailing: Switch(
                value: settings.vibrationsEnabled,
                onChanged: (value) => settings.setVibrationEnabled(value),
                activeColor: primaryColor,
              ),
              isDarkMode: isDarkMode,
              cardColor: cardColor,
              textColor: textColor,
            ),

            // Section Notifications
            _buildSectionHeader(
              context,
              icon: Icons.notifications,
              title: 'Notifications', // Replace with localizations.notifications when available
              isDarkMode: isDarkMode,
              textColor: textColor,
            ),
            _buildSettingTile(
              context,
              icon: Icons.notifications_active,
              title: localizations.enableNotifications,
              trailing: Switch(
                value: settings.notificationsEnabled,
                onChanged: (value) => settings.setNotificationsEnabled(value),
                activeColor: primaryColor,
              ),
              isDarkMode: isDarkMode,
              cardColor: cardColor,
              textColor: textColor,
            ),

            // Section Langue
            _buildSectionHeader(
              context,
              icon: Icons.language,
              title: localizations.language,
              isDarkMode: isDarkMode,
              textColor: textColor,
            ),
            Card(
              elevation: 2,
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  _buildLanguageOption(
                    context,
                    icon: Icons.favorite,
                    title: localizations.french,
                    locale: const Locale('fr'),
                    currentLocale: settings.currentLocale,
                    onChanged: (value) => settings.setLocale(value!),
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                  ),
                  Divider(height: 1, color: dividerColor),
                  _buildLanguageOption(
                    context,
                    icon: Icons.language,
                    title: localizations.english,
                    locale: const Locale('en'),
                    currentLocale: settings.currentLocale,
                    onChanged: (value) => settings.setLocale(value!),
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                  ),
                  Divider(height: 1, color: dividerColor),
                  _buildLanguageOption(
                    context,
                    icon: Icons.translate,
                    title: localizations.arabic,
                    locale: const Locale('ar'),
                    currentLocale: settings.currentLocale,
                    onChanged: (value) => settings.setLocale(value!),
                    isDarkMode: isDarkMode,
                    textColor: textColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, {
        required IconData icon,
        required String title,
        required bool isDarkMode,
        required Color textColor,
      }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: textColor.withOpacity(0.8)),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor.withOpacity(0.8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Widget trailing,
        required bool isDarkMode,
        required Color cardColor,
        required Color textColor,
      }) {
    return Card(
      elevation: 2,
      color: cardColor,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: textColor.withOpacity(0.8)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
        trailing: trailing,
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Locale locale,
        required Locale currentLocale,
        required ValueChanged<Locale?> onChanged,
        required bool isDarkMode,
        required Color textColor,
      }) {
    return ListTile(
      leading: Icon(icon, color: textColor.withOpacity(0.8)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
        ),
      ),
      trailing: Radio<Locale>(
        value: locale,
        groupValue: currentLocale,
        onChanged: onChanged,
        activeColor: isDarkMode ? Colors.purpleAccent[400] : Colors.purple[700],
      ),
      onTap: () => onChanged(locale),
    );
  }
}