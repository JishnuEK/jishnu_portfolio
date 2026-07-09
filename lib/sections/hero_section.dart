import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive_layout.dart';
import '../data/portfolio_data.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 110, bottom: 64),
      decoration: const BoxDecoration(color: AppColors.background),
      child: Center(
        child: SizedBox(
          width: ResponsiveLayout.contentWidth(context),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isMobile) ...[_buildImage(), const SizedBox(height: 48)],
              Expanded(
                flex: isMobile ? 0 : 1,
                child: FutureBuilder<HeroData>(
                  future: PortfolioData.getHeroData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return const SizedBox();
                    }

                    final hero = snapshot.data!;
                    return Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [AppColors.primary, Color(0xFFB388FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            hero.name,
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: isMobile ? 36 : 56,
                                  letterSpacing: -1.0,
                                ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          hero.role,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                letterSpacing: 0.5,
                              ),
                        ),
                        const SizedBox(height: 24),
                        ...hero.description.map(
                          (desc) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              desc,
                              textAlign: isMobile
                                  ? TextAlign.center
                                  : TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: AppColors.textMain.withValues(
                                  alpha: 0.9,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.background,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () async {
                              final url = Uri.parse('assets/resume/ji.pdf');

                              if (!await launchUrl(url)) {
                                debugPrint('Could not launch \$url');
                              }
                            },
                            child: const Text(
                              'Download Resume',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              if (!isMobile) ...[const SizedBox(width: 48), _buildImage()],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 320,
      height: 320,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 80,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: const Color(0xFFB388FF).withValues(alpha: 0.2),
            blurRadius: 100,
            spreadRadius: 15,
            offset: const Offset(-20, 20),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(4), // Gradient border width
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.primary, Color(0xFFB388FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.background,
          ),
          padding: const EdgeInsets.all(8), // Inner spacing
          child: ClipOval(
            child: Image.asset('assets/images/profile.jpg', fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
