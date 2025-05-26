import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizflutter/models/quiz_settings.dart';
import 'package:quizflutter/utils/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          enableJavaScript: true,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorLaunchingUrl),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final settings = Provider.of<QuizSettings>(context);
    final isDarkMode = settings.isDarkMode;

    // Couleurs adaptées au thème (violettes comme dans settings)
    final primaryColor = isDarkMode ? Colors.purpleAccent[400]! : Colors.purple[700]!;
    final backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.grey[50]!;
    final cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.grey[800]!;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.grey[600]!;

    // Dégradé de fond
    final backgroundGradient = isDarkMode
        ? LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.purple[900]!.withOpacity(0.3),
        Colors.grey[900]!,
      ],
    )
        : LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.purple[50]!,
        Colors.grey[50]!,
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.about, style: TextStyle(
            color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 6,
        centerTitle: true,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareApp(context),
            tooltip: localizations.shareApp,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildAppHeader(context, isDarkMode, primaryColor, cardColor, textColor, secondaryTextColor),
                  const SizedBox(height: 32),
                  _buildFeaturesSection(context, isDarkMode, primaryColor, cardColor, textColor, secondaryTextColor),
                  const SizedBox(height: 32),
                  _buildApiInfoSection(context, isDarkMode, primaryColor, cardColor, textColor, secondaryTextColor),
                  const SizedBox(height: 32),
                  _buildDeveloperSection(context, isDarkMode, primaryColor, cardColor, textColor, secondaryTextColor),
                  const SizedBox(height: 32),
                  _buildVersionFooter(context, isDarkMode, textColor, secondaryTextColor),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader(
      BuildContext context,
      bool isDarkMode,
      Color primaryColor,
      Color cardColor,
      Color textColor,
      Color secondaryTextColor,
      ) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: cardColor,
      shadowColor: isDarkMode ? Colors.purple[200]!.withOpacity(0.2) : Colors.purple[100]!,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(0.2),
                    primaryColor.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor.withOpacity(0.8),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.quiz,
                size: 60,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              localizations.appTitle,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              localizations.aboutAppDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(
      BuildContext context,
      bool isDarkMode,
      Color primaryColor,
      Color cardColor,
      Color textColor,
      Color secondaryTextColor,
      ) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            localizations.features,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              context,
              icon: Icons.category,
              title: localizations.multipleCategories,
              description: localizations.categoriesDescription,
              isDarkMode: isDarkMode,
              primaryColor: primaryColor,
              cardColor: cardColor,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.speed,
              title: localizations.variousDifficulties,
              description: localizations.difficultiesDescription,
              isDarkMode: isDarkMode,
              primaryColor: primaryColor,
              cardColor: cardColor,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.translate,
              title: localizations.multiLanguage,
              description: localizations.languageDescription,
              isDarkMode: isDarkMode,
              primaryColor: primaryColor,
              cardColor: cardColor,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            ),
            _buildFeatureCard(
              context,
              icon: Icons.analytics,
              title: localizations.detailedStats,
              description: localizations.statsDescription,
              isDarkMode: isDarkMode,
              primaryColor: primaryColor,
              cardColor: cardColor,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required bool isDarkMode,
        required Color primaryColor,
        required Color cardColor,
        required Color textColor,
        required Color secondaryTextColor,
      }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApiInfoSection(
      BuildContext context,
      bool isDarkMode,
      Color primaryColor,
      Color cardColor,
      Color textColor,
      Color secondaryTextColor,
      ) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.api,
                  size: 28,
                  color: primaryColor,
                ),
                const SizedBox(width: 12),
                Text(
                  localizations.aboutApiTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              localizations.aboutApiDescription,
              style: TextStyle(
                fontSize: 15,
                color: secondaryTextColor,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            _buildLinkButton(
              context,
              label: localizations.visitApiWebsite,
              url: 'https://opentdb.com',
              icon: Icons.open_in_new,
              isDarkMode: isDarkMode,
              primaryColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperSection(
      BuildContext context,
      bool isDarkMode,
      Color primaryColor,
      Color cardColor,
      Color textColor,
      Color secondaryTextColor,
      ) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.code,
                  size: 28,
                  color: primaryColor,
                ),
                const SizedBox(width: 12),
                Text(
                  localizations.developer,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              localizations.developerDescription,
              style: TextStyle(
                fontSize: 15,
                color: secondaryTextColor,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildSocialButton(
                  context,
                  icon: Icons.email,
                  label: localizations.contact,
                  onTap: () => _launchURL(context, 'mailto:contact@example.com'),
                  isDarkMode: isDarkMode,
                  primaryColor: primaryColor,
                ),
                const SizedBox(width: 12),
                _buildSocialButton(
                  context,
                  icon: Icons.public,
                  label: 'GitHub',
                  onTap: () => _launchURL(context, 'https://github.com/RahmaBradai724/QuizFlutterApp'),
                  isDarkMode: isDarkMode,
                  primaryColor: primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionFooter(
      BuildContext context,
      bool isDarkMode,
      Color textColor,
      Color secondaryTextColor,
      ) {
    final localizations = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        children: [
          Text(
            localizations.version,
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© ${DateTime.now().year} OpenTDB Quiz',
            style: TextStyle(
              fontSize: 12,
              color: secondaryTextColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkButton(
      BuildContext context, {
        required String label,
        required String url,
        required IconData icon,
        required bool isDarkMode,
        required Color primaryColor,
      }) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: primaryColor.withOpacity(isDarkMode ? 0.8 : 1),
      child: InkWell(
        onTap: () => _launchURL(context, url),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
        required bool isDarkMode,
        required Color primaryColor,
      }) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: isDarkMode
            ? primaryColor.withOpacity(0.2)
            : primaryColor.withOpacity(0.1),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          highlightColor: primaryColor.withOpacity(0.1),
          splashColor: primaryColor.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _shareApp(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    final box = context.findRenderObject() as RenderBox?;
    // Implémentez votre logique de partage ici
  }
}