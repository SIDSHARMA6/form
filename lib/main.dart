import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'data/erectile_dysfunction_quiz.dart';
import 'data/weight_loss_quiz.dart';
import 'data/hair_loss_quiz.dart';
import 'data/premature_ejaculation_quiz.dart';
import 'data/testosterone_booster_quiz.dart';

void main() => runApp(const PhoenixApp());

class PhoenixApp extends StatelessWidget {
  const PhoenixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phoenix Quiz',
      theme: ThemeData(
        primaryColor:
            const Color(0xFF1E3A8A), // Softer blue for professionalism
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1E3A8A),
          secondary: Color(0xFF06B6D4), // Teal accent for vibrancy
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(), // Modern, clean font
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          },
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const treatments = [
    {'title': 'Erectile Dysfunction', 'image': 'assets/doctor.png'},
    {'title': 'Weight Loss', 'image': 'assets/doctor.png'},
    {'title': 'Hair Loss', 'image': 'assets/doctor.png'},
    {'title': 'Premature Ejaculation', 'image': 'assets/doctor.png'},
    {'title': 'Testosterone Booster', 'image': 'assets/doctor.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "PHOENIX",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: const Color(0xFF06B6D4), // Teal for consistency
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(24.0), // Increased padding for breathing room
        child: Column(
          children: [
            Text(
              "What treatment are you looking for?",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => GridView.count(
                  crossAxisCount: constraints.maxWidth > 1200
                      ? 5
                      : constraints.maxWidth > 800
                          ? 3
                          : constraints.maxWidth > 500
                              ? 2
                              : 1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85, // Taller cards for better visuals
                  children: treatments
                      .asMap()
                      .entries
                      .map((entry) => TreatmentCard(
                            title: entry.value['title']!,
                            image: entry.value['image']!,
                            index: entry.key,
                            onTap: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, _) =>
                                    QuizPage(
                                  treatment: entry.value['title']!,
                                  heroTag: entry.value['title']!,
                                ),
                                transitionsBuilder:
                                    (context, animation, _, child) =>
                                        ScaleTransition(
                                  scale: animation.drive(
                                    Tween(begin: 0.8, end: 1.0).chain(
                                      CurveTween(curve: Curves.easeInOut),
                                    ),
                                  ),
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ).animate().fadeIn(duration: 600.ms).slideY(
                      begin: 0.2,
                      end: 0.0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TreatmentCard extends StatefulWidget {
  final String title, image;
  final int index;
  final VoidCallback onTap;

  const TreatmentCard({
    super.key,
    required this.title,
    required this.image,
    required this.index,
    required this.onTap,
  });

  @override
  State<TreatmentCard> createState() => _TreatmentCardState();
}

class _TreatmentCardState extends State<TreatmentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse().then((_) => widget.onTap()),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), // Softer corners
              gradient: const LinearGradient(
                colors: [Color(0xFFFFFFFF), Color(0xFFF1F5F9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.title,
                  child: Image.asset(widget.image, height: 100)
                      .animate()
                      .fadeIn(delay: (widget.index * 100).ms, duration: 400.ms),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().slideY(
          begin: 0.3,
          end: 0.0,
          delay: (widget.index * 100).ms,
          duration: 500.ms,
          curve: Curves.easeOutCubic,
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class QuizPage extends StatefulWidget {
  final String treatment;
  final String heroTag;

  const QuizPage({super.key, required this.treatment, required this.heroTag});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _slideController, _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  final _controllers = <TextEditingController>[
    for (int i = 0; i < 5; i++) TextEditingController()
  ];

  static const quizData = {
    "Hair Loss": HairLossQuiz.questions,
    "Erectile Dysfunction": ErectileDysfunctionQuiz.questions,
    "Testosterone Booster": TestosteroneBoosterQuiz.questions,
    "Weight Loss": WeightLossQuiz.questions,
    "Premature Ejaculation": PrematureEjaculationQuiz.questions,
  };

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0.0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _slideController.forward();
    _fadeController.forward();
  }

  bool _validateAge() {
    if (_controllers.length < 3) return false;
    final day = int.tryParse(_controllers[0].text);
    final month = int.tryParse(_controllers[1].text);
    final year = int.tryParse(_controllers[2].text);
    if (day == null || month == null || year == null) return false;
    final age = DateTime.now().year - year;
    return age >= 18;
  }

  void _nextQuestion() async {
    final questions = quizData[widget.treatment]!;
    final current = questions[currentIndex];

    if (current['type'] == 'date_input' && !_validateAge()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You are not eligible. Must be 18 or older.',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    if (currentIndex < questions.length - 1) {
      await _fadeController.reverse();
      setState(() => currentIndex++);
      _slideController.reset();
      _fadeController.reset();
      _slideController.forward();
      _fadeController.forward();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Completed ${widget.treatment} Quiz",
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color(0xFF06B6D4),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _previousQuestion() async {
    if (currentIndex > 0) {
      await _fadeController.reverse();
      setState(() => currentIndex--);
      _slideController.reset();
      _fadeController.reset();
      _slideController.forward();
      _fadeController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = quizData[widget.treatment]!;
    final current = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "PHOENIX",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: const Color(0xFF06B6D4),
          ),
        ),
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (currentIndex + 1) / questions.length,
                  backgroundColor: Colors.grey.shade200,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF06B6D4)),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ).animate().scale(duration: 400.ms, curve: Curves.easeOut),
                const SizedBox(height: 32),
                Text(
                  current['question'],
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E3A8A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Expanded(child: _buildQuestionContent(current)),
                if (currentIndex > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: OutlinedButton(
                      onPressed: _previousQuestion,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        side: const BorderSide(color: Color(0xFF06B6D4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Previous",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFF1E3A8A),
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionContent(Map<String, dynamic> question) {
    switch (question['type']) {
      case 'date_input':
        return _buildDateInput();
      case 'name_input':
        return _buildNameInput();
      default:
        return _buildMultipleChoice(question['options']);
    }
  }

  Widget _buildDateInput() {
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < 3; i++) ...[
              Expanded(
                child: TextField(
                  controller: _controllers[i],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: ['DD', 'MM', 'YYYY'][i],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                ).animate().fadeIn(delay: (100 * i).ms),
              ),
              if (i < 2) const SizedBox(width: 12),
            ],
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _nextQuestion,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
          child: Text(
            'Continue',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ).animate().scale(delay: 300.ms, curve: Curves.easeOut),
      ],
    );
  }

  Widget _buildNameInput() {
    return Column(
      children: [
        for (int i = 3; i < 5; i++) ...[
          TextField(
            controller: _controllers[i],
            decoration: InputDecoration(
              labelText: ['First Name', 'Last Name'][i - 3],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
          ).animate().fadeIn(delay: (100 * (i - 3)).ms),
          if (i == 3) const SizedBox(height: 16),
        ],
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _nextQuestion,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
          child: Text(
            'Continue',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ).animate().scale(delay: 300.ms, curve: Curves.easeOut),
      ],
    );
  }

  Widget _buildMultipleChoice(List<String> options) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1E3A8A),
          side: BorderSide(color: Colors.grey.shade200),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        onPressed: _nextQuestion,
        child: Row(
          children: [
            Expanded(
              child: Text(
                options[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF06B6D4)),
          ],
        ),
      ).animate().slideY(
            begin: 0.2,
            end: 0.0,
            delay: (100 * index).ms,
            duration: 400.ms,
            curve: Curves.easeOut,
          ),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
