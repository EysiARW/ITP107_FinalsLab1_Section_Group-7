import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(const CampusPortalApp());

// ---------------------------------------------------------------------------
// Palette & shared tokens — the original five accent colors are untouched.
// Everything else here is a soft tint of one of them, so new elements read
// as part of the same system instead of being bolted on.
// ---------------------------------------------------------------------------

const portalBackground = Color(0xFF004225);
const fieldBackground = Color(0xFFF4F8F3);
const cardBackground = Color(0xFFFFFFFF);
const textPrimary = Color(0xFF173C2D);
const textSecondary = Color(0xFF5D7568);
const borderColor = Color(0xFFD4E0D7);
const accentGreen = Color(0xFF008B4B);
const accentGreenDark = Color(0xFF006F3C);
const infoBlue = Color(0xFF168CC5);
const highlightGold = Color(0xFFE5B817);
const errorRed = Color(0xFFB42318);

const accentGreenTint = Color(0xFFE4F2EA);
const highlightGoldTint = Color(0xFFFBF1D4);
const infoBlueTint = Color(0xFFE5F2F9);
const heroSubtleText = Color(0xFFBFD3C4); // muted text on the dark hero areas

const controlRadius = 8.0; // controls: fields, buttons, chips
const cardRadius = 22.0; // containers: panels, sheets, tiles
const fieldHeight = 52.0;

class CampusPortalApp extends StatelessWidget {
  const CampusPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final urbanist = GoogleFonts.urbanistTextTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PNC Connect',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: portalBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: accentGreen),
        textTheme: urbanist.apply(bodyColor: textPrimary, displayColor: textPrimary),
        splashFactory: InkRipple.splashFactory,
        // All text fields share this look, so it's set once here instead of
        // repeating the same border/fill styling on every TextField.
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: fieldBackground,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          prefixIconColor: textSecondary,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(controlRadius),
              borderSide: const BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(controlRadius),
              borderSide: const BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(controlRadius),
              borderSide: const BorderSide(color: infoBlue, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(controlRadius),
              borderSide: const BorderSide(color: errorRed)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(controlRadius),
              borderSide: const BorderSide(color: errorRed, width: 1.5)),
          errorStyle:
              GoogleFonts.urbanist(color: errorRed, fontSize: 13, height: 1.35),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Shared widgets — imported by every file under screens/ so the look stays
// consistent without copy-pasting the same code three times.
// ---------------------------------------------------------------------------

// Logo lockup shown at the top of every screen. Every screen in this app
// places it over the dark green backdrop, so the styling below is fixed
// for that context rather than exposing an unused light/dark toggle.
class PortalBrandMark extends StatelessWidget {
  const PortalBrandMark({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            ),
            child: Image.asset('src/logo.png', fit: BoxFit.contain),
          ),
          const SizedBox(width: 14),
          Container(
            width: 1.5,
            height: 34,
            color: highlightGold.withValues(alpha: 0.55),
          ),
          const SizedBox(width: 14),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UNIVERSITY OF',
                style: GoogleFonts.urbanist(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: heroSubtleText,
                  letterSpacing: 2.6,
                ),
              ),
              Text(
                'Cabuyao',
                style: GoogleFonts.urbanist(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.1,
                  height: 1.05,
                ),
              ),
            ],
          ),
        ],
      );
}

// Backdrop painted behind every dark-green surface — a soft directional
// glow plus two layers of fine diagonal hairlines, so the green never reads
// as a flat, single fill.
class CampusBackdrop extends CustomPainter {
  const CampusBackdrop();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = portalBackground);

    final glow = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.7, -0.9),
        radius: 1.3,
        colors: const [Color(0x2E12A05C), Color(0x00102E20)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, glow);

    final vignette = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.6, 1.1),
        radius: 1.4,
        colors: const [Color(0x33001A10), Color(0x00001A10)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, vignette);

    final bands = Paint()
      ..color = const Color(0x140B6A43)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 26;
    for (var offset = -size.height; offset < size.width; offset += 160) {
      canvas.drawLine(
        Offset(offset, size.height),
        Offset(offset + size.height * 0.95, 0),
        bands,
      );
    }

    final texture = Paint()
      ..color = const Color(0x12FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var offset = -size.height; offset < size.width; offset += 40) {
      canvas.drawLine(
        Offset(offset, size.height),
        Offset(offset + size.height * 0.95, 0),
        texture,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// White card that wraps the login and sign-up forms so both screens share
// the same centered, boxed layout over the green backdrop.
class AuthCard extends StatelessWidget {
  final Widget child;
  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: CustomPaint(painter: CampusBackdrop())),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(child: PortalBrandMark()),
                      const SizedBox(height: 44),
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: cardBackground,
                          borderRadius: BorderRadius.circular(cardRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.22),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Thin brand-gradient hairline along the top edge
                            // of the card — a quiet signature rather than a
                            // loud banner.
                            Container(
                              height: 4,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [accentGreen, highlightGold, infoBlue],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(36, 34, 36, 36),
                              child: child,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      Center(
                        child: Text(
                          'University of Cabuyao student portal',
                          style: GoogleFonts.urbanist(
                            fontSize: 13,
                            color: heroSubtleText,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Small rounded label used above a screen title, e.g. "WELCOME BACK",
// with a colored dot so it reads as a tag rather than plain caps text.
// Only used inside PageHeader below, so it stays file-private.
class _SectionTag extends StatelessWidget {
  final String text;
  final bool light;
  const _SectionTag(this.text, {this.light = false});

  @override
  Widget build(BuildContext context) {
    final dotColor = light ? highlightGold : accentGreen;
    final bg = light ? Colors.white.withValues(alpha: 0.10) : accentGreenTint;
    final fg = light ? Colors.white.withValues(alpha: 0.88) : accentGreen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: fg,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// Eyebrow tag + big title + subtitle, used at the top of every screen.
class PageHeader extends StatelessWidget {
  final String eyebrow, title, subtitle;
  final bool light;
  const PageHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTag(eyebrow, light: light),
          const SizedBox(height: 16),
          Text(title,
              style: GoogleFonts.urbanist(
                  fontSize: 30,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  color: light ? Colors.white : textPrimary,
                  letterSpacing: -0.6)),
          const SizedBox(height: 10),
          Text(subtitle,
              style: GoogleFonts.urbanist(
                  fontSize: 15.5,
                  height: 1.5,
                  color: light ? heroSubtleText : textSecondary)),
        ],
      );
}

// Only used inside PortalTextField / PortalPasswordField below, so it stays
// file-private.
class _InputLabel extends StatelessWidget {
  final String text;
  const _InputLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: GoogleFonts.urbanist(
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: 0.1));
}

// Plain text input with a label on top, an icon, and an optional error
// message underneath. Used for the name/email fields.
class PortalTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? error;
  final TextInputType? keyboardType;
  final IconData icon;
  const PortalTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.error,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InputLabel(label),
        const SizedBox(height: 8),
        SizedBox(
          height: fieldHeight,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.urbanist(color: textPrimary, fontSize: 15),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 19),
              // Only swap the border color when there's an error — the
              // default theme border is fine otherwise.
              enabledBorder: error != null
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(controlRadius),
                      borderSide: const BorderSide(color: errorRed))
                  : null,
              focusedBorder: error != null
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(controlRadius),
                      borderSide: const BorderSide(color: errorRed, width: 1.5))
                  : null,
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 14, color: errorRed),
                const SizedBox(width: 6),
                Text(error!,
                    style: GoogleFonts.urbanist(
                        fontSize: 13, height: 1.35, color: errorRed)),
              ],
            ),
          ),
      ],
    );
  }
}

// Same as PortalTextField but obscures the input and has a show/hide toggle.
// Needs to be a StatefulWidget just to track whether the password is
// currently visible.
class PortalPasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? error;
  const PortalPasswordField(
      {super.key, required this.label, required this.controller, this.error});

  @override
  State<PortalPasswordField> createState() => _PortalPasswordFieldState();
}

class _PortalPasswordFieldState extends State<PortalPasswordField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InputLabel(widget.label),
        const SizedBox(height: 8),
        SizedBox(
          height: fieldHeight,
          child: TextField(
            controller: widget.controller,
            obscureText: !visible,
            style: GoogleFonts.urbanist(color: textPrimary, fontSize: 15),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline_rounded, size: 19),
              suffixIcon: IconButton(
                tooltip: visible
                    ? 'Hide ${widget.label.toLowerCase()}'
                    : 'Show ${widget.label.toLowerCase()}',
                icon: Icon(
                    visible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: textSecondary,
                    size: 19),
                onPressed: () => setState(() => visible = !visible),
              ),
              enabledBorder: widget.error != null
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(controlRadius),
                      borderSide: const BorderSide(color: errorRed))
                  : null,
              focusedBorder: widget.error != null
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(controlRadius),
                      borderSide: const BorderSide(color: errorRed, width: 1.5))
                  : null,
            ),
          ),
        ),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 14, color: errorRed),
                const SizedBox(width: 6),
                Text(widget.error!,
                    style: GoogleFonts.urbanist(
                        fontSize: 13, height: 1.35, color: errorRed)),
              ],
            ),
          ),
      ],
    );
  }
}

// Full-width button used for both "Sign in" and "Create account". It's a
// fully custom widget (rather than a themed ElevatedButton) so it can carry
// a soft gradient, a proper drop shadow, and a gentle press animation.
class PrimaryActionButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const PrimaryActionButton(
      {super.key, required this.label, required this.onPressed});

  @override
  State<PrimaryActionButton> createState() => _PrimaryActionButtonState();
}

class _PrimaryActionButtonState extends State<PrimaryActionButton> {
  bool hover = false;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => pressed = true),
        onTapCancel: () => setState(() => pressed = false),
        onTapUp: (_) => setState(() => pressed = false),
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: pressed ? 0.98 : 1,
          duration: const Duration(milliseconds: 90),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: double.infinity,
            height: fieldHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(controlRadius),
              gradient: LinearGradient(
                colors: hover
                    ? const [accentGreenDark, Color(0xFF00552F)]
                    : const [accentGreen, accentGreenDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: accentGreen.withValues(alpha: hover ? 0.38 : 0.28),
                  blurRadius: hover ? 22 : 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(controlRadius),
              child: InkWell(
                borderRadius: BorderRadius.circular(controlRadius),
                onTap: widget.onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.label,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 0.1)),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_rounded,
                        size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// The "Need an account? Create an account" line at the bottom of each
// auth screen — same widget, just different text depending on which
// screen it's on.
class AuthSwitchLink extends StatelessWidget {
  final String text, linkText;
  final VoidCallback onTap;
  const AuthSwitchLink(
      {super.key, required this.text, required this.linkText, required this.onTap});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 26),
        child: Column(
          children: [
            Container(height: 1, color: borderColor),
            const SizedBox(height: 22),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text('$text ',
                    style: GoogleFonts.urbanist(fontSize: 14, color: textSecondary)),
                GestureDetector(
                  onTap: onTap,
                  child: Text(linkText,
                      style: GoogleFonts.urbanist(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: infoBlue,
                          decoration: TextDecoration.underline,
                          decorationColor: infoBlue.withValues(alpha: 0.4))),
                ),
              ],
            ),
          ],
        ),
      );
}