import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/footer.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';

class HomeScreen extends StatelessWidget {
  final bool showEducation;

  const HomeScreen({super.key, this.showEducation = false});

  void _scrollToItem(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textMain,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hoverColor: AppColors.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey homeKey = GlobalKey();
    final GlobalKey skillsKey = GlobalKey();
    final GlobalKey projectsKey = GlobalKey();
    final GlobalKey contactKey = GlobalKey();

    bool isMobile = ResponsiveLayout.isMobile(context);

    // We use builder to always get the current scaffold context for the drawer
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            letterSpacing: -0.02,
          ),
        ),
        backgroundColor: AppColors.background.withValues(alpha: 0.9),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: isMobile
            ? null
            : [
                TextButton(
                  onPressed: () => _scrollToItem(homeKey),
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _scrollToItem(skillsKey),
                  child: const Text(
                    'Skills',
                    style: TextStyle(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _scrollToItem(projectsKey),
                  child: const Text(
                    'Projects',
                    style: TextStyle(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _scrollToItem(contactKey),
                  child: const Text(
                    'Contact',
                    style: TextStyle(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
      ),
      drawer: isMobile
          ? Builder(
              builder: (ctx) {
                return Drawer(
                  backgroundColor: AppColors.background,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: AppColors.lightBackground,
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                        ),
                        currentAccountPicture: const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/profile.jpg'),
                        ),
                        accountName: const Text(
                          'JISHNU EK',
                          style: TextStyle(
                            color: AppColors.textMain,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        accountEmail: Text(
                          'Senior Flutter Developer',
                          style: TextStyle(
                            color: AppColors.textMain.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      _buildDrawerItem(
                        icon: Icons.home_outlined,
                        title: 'Home',
                        onTap: () {
                          Navigator.pop(ctx);
                          _scrollToItem(homeKey);
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.code,
                        title: 'Skills',
                        onTap: () {
                          Navigator.pop(ctx);
                          _scrollToItem(skillsKey);
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.work_outline,
                        title: 'Projects',
                        onTap: () {
                          Navigator.pop(ctx);
                          _scrollToItem(projectsKey);
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.mail_outline,
                        title: 'Contact',
                        onTap: () {
                          Navigator.pop(ctx);
                          _scrollToItem(contactKey);
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(key: homeKey, child: const HeroSection()),
            const AboutSection(),
            Container(key: skillsKey, child: const SkillsSection()),
            if (showEducation) const EducationSection(),
            const ExperienceSection(),
            Container(key: projectsKey, child: const ProjectsSection()),
            Container(key: contactKey, child: const ContactSection()),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
