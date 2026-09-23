// Team Name 
// Isaac Owusu 003028540
//  Jeremy Henry jhenryatohengbe1 002737524



import 'package:flutter/material.dart';

void main() {
  runApp(const ViralContentApp());
}

// ============================================================
// 1. ROOT APP - StatefulWidget for Theme Switching
// ============================================================

class ViralContentApp extends StatefulWidget {
  const ViralContentApp({super.key});

  @override
  State<ViralContentApp> createState() => _ViralContentAppState();
}

class _ViralContentAppState extends State<ViralContentApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Viral Content Studio',
      theme: isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: ViralStudioScreen(
        isDark: isDarkMode,
        onToggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

// ============================================================
// 2. STATEFUL MAIN SCREEN
// ============================================================

class ViralStudioScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ViralStudioScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ViralStudioScreen> createState() => _ViralStudioScreenState();
}

class _ViralStudioScreenState extends State<ViralStudioScreen> {
  int likes = 0;
  int comments = 0;
  int shares = 0;
  int saves = 0;
  int streak = 0;
  bool isTrending = false;

  // Calculate total engagement points.
  int get engagementScore {
    return likes + (comments * 2) + (shares * 3) + (saves * 2);
  }

  // Update engagement and check for trending status.
  void _addEngagement(String type) {
    setState(() {
      if (type == "LIKE") {
        likes++;
      } else if (type == "COMMENT") {
        comments++;
      } else if (type == "SHARE") {
        shares++;
      } else if (type == "SAVE") {
        saves++;
      }

      streak++;

      if (engagementScore >= 20) {
        isTrending = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isTrending
        ? (widget.isDark
            ? const Color(0xFF402020)
            : const Color(0xFFFFE4E4))
        : (widget.isDark
            ? const Color(0xFF1E1F29)
            : const Color(0xFFE8ECF3));

    return Scaffold(
      backgroundColor: backgroundColor,

      // ========================================================
      // THEME SWITCHER
      // ========================================================

      appBar: AppBar(
        title: const Text(
          "VIRAL CONTENT STUDIO",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: "Toggle Theme",
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // ==================================================
            // 3. STATELESS TITLE HEADER
            // ==================================================

            const StudioHeader(),

            const SizedBox(height: 20),

            // ==================================================
            // TRENDING BANNER
            // ==================================================

            if (isTrending)
              const TrendingBanner(),

            const SizedBox(height: 20),

            // ==================================================
            // SOCIAL MEDIA POST
            // ==================================================

            const PostCard(),

            const SizedBox(height: 20),

            // ==================================================
            // 4. STATELESS METRICS CARD
            // ==================================================

            MetricsCard(
              likes: likes,
              comments: comments,
              shares: shares,
              saves: saves,
              streak: streak,
              score: engagementScore,
            ),

            const SizedBox(height: 25),

            // ==================================================
            // ENGAGEMENT BUTTONS
            // ==================================================

            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                EngagementButton(
                  icon: Icons.favorite,
                  label: "LIKE",
                  color: Colors.pinkAccent,
                  onAction: () => _addEngagement("LIKE"),
                ),
                EngagementButton(
                  icon: Icons.comment,
                  label: "COMMENT",
                  color: Colors.blueAccent,
                  onAction: () => _addEngagement("COMMENT"),
                ),
                EngagementButton(
                  icon: Icons.share,
                  label: "SHARE",
                  color: Colors.greenAccent,
                  onAction: () => _addEngagement("SHARE"),
                ),
                EngagementButton(
                  icon: Icons.bookmark,
                  label: "SAVE",
                  color: Colors.orangeAccent,
                  onAction: () => _addEngagement("SAVE"),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==================================================
            // DYNAMIC ENGAGEMENT METER
            // ==================================================

            EngagementMeter(
              score: engagementScore,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STATELESS WIDGET #1 - TITLE HEADER
// ============================================================

class StudioHeader extends StatelessWidget {
  const StudioHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          Icons.auto_awesome,
          size: 45,
          color: Colors.purpleAccent,
        ),
        SizedBox(height: 8),
        Text(
          "Create. Engage. Go Viral.",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// STATELESS WIDGET #2 - POST CARD
// ============================================================

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 12),
                Text(
                  "@viral_creator",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.blue,
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 65,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Building something amazing today 🚀",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STATELESS WIDGET #3 - METRICS CARD
// ============================================================

class MetricsCard extends StatelessWidget {
  final int likes;
  final int comments;
  final int shares;
  final int saves;
  final int streak;
  final int score;

  const MetricsCard({
    super.key,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.saves,
    required this.streak,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Text(
              "ENGAGEMENT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Metric(Icons.favorite, "Likes", likes),
                _Metric(Icons.comment, "Comments", comments),
                _Metric(Icons.share, "Shares", shares),
                _Metric(Icons.bookmark, "Saves", saves),
              ],
            ),
            const Divider(height: 30),
            Text(
              "ENGAGEMENT SCORE: $score",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "🔥 Streak: $streak",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;

  const _Metric(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 25),
        const SizedBox(height: 5),
        Text(
          "$value",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }
}

// ============================================================
// STATEFUL WIDGET - TACTILE ENGAGEMENT BUTTON
// ============================================================

class EngagementButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onAction;

  const EngagementButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onAction,
  });

  @override
  State<EngagementButton> createState() => _EngagementButtonState();
}

class _EngagementButtonState extends State<EngagementButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      // Visual feedback starts here.
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },

      // Action happens when the user releases.
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });

        widget.onAction();
      },

      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 135,
        height: 65,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(
            isPressed ? 0.65 : 0.9,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: isPressed
              ? [
                  const BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    offset: const Offset(6, 6),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.25),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STATELESS WIDGET - DYNAMIC ENGAGEMENT METER
// ============================================================

class EngagementMeter extends StatelessWidget {
  final int score;

  const EngagementMeter({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (score / 20).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Text(
              "VIRALITY METER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 10),
            Text(
              score >= 20
                  ? "Target reached! 🔥"
                  : "$score / 20 engagement points",
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STATELESS WIDGET - TRENDING BANNER
// ============================================================

class TrendingBanner extends StatelessWidget {
  const TrendingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Center(
        child: Text(
          "TRENDING 🔥",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}