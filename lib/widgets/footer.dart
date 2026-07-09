import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive_layout.dart';
import '../data/portfolio_data.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      color: AppColors.primary,
      child: Center(
        child: SizedBox(
          width: ResponsiveLayout.contentWidth(context),
          child: FutureBuilder<FooterData>(
            future: PortfolioData.getFooterData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const SizedBox();
              }
              
              final footer = snapshot.data!;
              return Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    footer.copyright,
                    style: const TextStyle(color: AppColors.textMain, fontSize: 14),
                  ),
                  if (isMobile) const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: footer.links.asMap().entries.map((entry) {
                      final isLast = entry.key == footer.links.length - 1;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _FooterLink(label: entry.value.label, url: entry.value.url),
                          if (!isLast) const SizedBox(width: 14),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final String url;
  const _FooterLink({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textMain,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
