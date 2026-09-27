import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

// ---------------------------------------------------------------------------
// Home screen — route: '/home'
//
// Laid out as a dark hero strip (matching the auth screens' backdrop) that
// gives way to a light, rounded "sheet" holding the actual dashboard — so
// the greeting text always sits on a background it has real contrast with,
// and the whole thing reads as one designed flow rather than three
// disconnected screens.
// ---------------------------------------------------------------------------

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The display name is passed in as a route argument from whichever
    // screen sent the user here (login or sign-up).
    final args = ModalRoute.of(context)?.settings.arguments;
    final name = (args is String && args.isNotEmpty) ? args : 'there';

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: CustomPaint(painter: CampusBackdrop())),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const PortalBrandMark(),
                          _OutlineButton(
                            icon: Icons.logout_rounded,
                            label: 'Sign out',
                            // Replace back to login — this clears Home off
                            // the stack so "back" can't return into a
                            // signed-out page.
                            onTap: () =>
                                Navigator.pushReplacementNamed(context, '/'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      PageHeader(
                        eyebrow: 'STUDENT DASHBOARD',
                        title: 'Welcome, $name.',
                        subtitle: 'Here\'s what\'s waiting for you today.',
                        light: true,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: cardBackground,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(cardRadius + 6)),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 720),
                          child: const _DashboardContent(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Outlined, semi-transparent button used for "Sign out" over the dark hero.
// Only used on this screen, so it stays file-private.
class _OutlineButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _OutlineButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: Colors.white.withValues(alpha: 0.85)),
              const SizedBox(width: 8),
              Text(label,
                  style: GoogleFonts.urbanist(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.9))),
            ],
          ),
        ),
      ),
    );
  }
}

// The content of the light sheet on the home screen: a quick-stats row,
// a set of quick-action tiles, and a status card.
class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Expanded(
              child: _StatCard(
                icon: Icons.menu_book_rounded,
                label: 'Enrolled units',
                value: '18',
                tint: accentGreenTint,
                iconColor: accentGreen,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.grade_rounded,
                label: 'Current GWA',
                value: '1.75',
                tint: highlightGoldTint,
                iconColor: Color(0xFF9C7A0A),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.account_balance_wallet_rounded,
                label: 'Balance due',
                value: '₱0.00',
                tint: infoBlueTint,
                iconColor: infoBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text('Quick actions',
            style: GoogleFonts.urbanist(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: textPrimary,
                letterSpacing: 0.1)),
        const SizedBox(height: 14),
        const _QuickActionCard(
          icon: Icons.calendar_month_rounded,
          title: 'Class schedule',
          subtitle: 'View this term\'s enrolled sections and room assignments',
          tint: accentGreenTint,
          iconColor: accentGreen,
        ),
        const SizedBox(height: 10),
        const _QuickActionCard(
          icon: Icons.fact_check_rounded,
          title: 'Grades & records',
          subtitle: 'Check posted grades and request official documents',
          tint: highlightGoldTint,
          iconColor: Color(0xFF9C7A0A),
        ),
        const SizedBox(height: 10),
        const _QuickActionCard(
          icon: Icons.campaign_rounded,
          title: 'Announcements',
          subtitle: 'Campus notices, deadlines, and academic calendar updates',
          tint: infoBlueTint,
          iconColor: infoBlue,
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: textPrimary,
            borderRadius: BorderRadius.circular(cardRadius),
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 14),
                decoration: const BoxDecoration(
                    color: highlightGold, shape: BoxShape.circle),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Campus portal',
                        style: GoogleFonts.urbanist(
                            fontSize: 12.5,
                            color: heroSubtleText,
                            letterSpacing: 0.2)),
                    const SizedBox(height: 4),
                    Text('Student services and campus updates',
                        style: GoogleFonts.urbanist(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.white54),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color tint, iconColor;
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.tint,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fieldBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 17, color: iconColor),
          ),
          const SizedBox(height: 14),
          Text(value,
              style: GoogleFonts.urbanist(
                  fontSize: 19, fontWeight: FontWeight.w800, color: textPrimary)),
          const SizedBox(height: 2),
          Text(label,
              style: GoogleFonts.urbanist(fontSize: 11.5, color: textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatefulWidget {
  final IconData icon;
  final String title, subtitle;
  final Color tint, iconColor;
  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.iconColor,
  });

  @override
  State<_QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<_QuickActionCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      cursor: SystemMouseCursors.click,
      child: Material(
        color: hover ? fieldBackground : cardBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: widget.tint,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(widget.icon, size: 20, color: widget.iconColor),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: GoogleFonts.urbanist(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: textPrimary)),
                      const SizedBox(height: 3),
                      Text(widget.subtitle,
                          style: GoogleFonts.urbanist(
                              fontSize: 12.5, height: 1.35, color: textSecondary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right_rounded,
                    size: 20, color: textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
