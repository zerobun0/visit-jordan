import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/quiz_data.dart';
import '../models/quiz_question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;
  bool _quizFinished = false;

  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  final List<QuizQuestion> _questions = quizQuestions;

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _feedbackAnimation = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.elasticOut,
    );
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
      if (index == _questions[_currentIndex].correctIndex) {
        _score++;
      }
    });
    _feedbackController.forward(from: 0);
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _answered = false;
      });
      _feedbackController.reset();
    } else {
      setState(() {
        _quizFinished = true;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _selectedIndex = null;
      _answered = false;
      _quizFinished = false;
    });
    _feedbackController.reset();
  }

  Color _getOptionColor(int index) {
    if (!_answered) return Colors.white;
    if (index == _questions[_currentIndex].correctIndex) return const Color(0xFFE8F5E9);
    if (index == _selectedIndex) return const Color(0xFFFFEBEE);
    return Colors.white;
  }

  Color _getOptionBorderColor(int index) {
    if (!_answered) return Colors.grey.shade200;
    if (index == _questions[_currentIndex].correctIndex) return const Color(0xFF4CAF50);
    if (index == _selectedIndex) return const Color(0xFFF44336);
    return Colors.grey.shade200;
  }

  Icon? _getOptionIcon(int index) {
    if (!_answered) return null;
    if (index == _questions[_currentIndex].correctIndex) {
      return const Icon(Icons.check_circle, color: Color(0xFF4CAF50));
    }
    if (index == _selectedIndex) {
      return const Icon(Icons.cancel, color: Color(0xFFF44336));
    }
    return null;
  }

  String _getScoreEmoji() {
    final pct = _score / _questions.length;
    if (pct == 1.0) return '🏆';
    if (pct >= 0.8) return '🌟';
    if (pct >= 0.6) return '👍';
    if (pct >= 0.4) return '📚';
    return '💪';
  }

  String _getScoreMessage() {
    final pct = _score / _questions.length;
    if (pct == 1.0) return 'Perfect Score! You\'re a Jordan Expert!';
    if (pct >= 0.8) return 'Excellent! You know Jordan very well!';
    if (pct >= 0.6) return 'Great job! Keep exploring Jordan!';
    if (pct >= 0.4) return 'Good effort! Visit the attractions to learn more!';
    return 'Keep learning! Jordan has so much to discover!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: Text(
          _quizFinished ? 'Quiz Results' : 'Jordan Quiz',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A3A6B),
        foregroundColor: Colors.white,
        actions: [
          if (!_quizFinished)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${_currentIndex + 1}/${_questions.length}',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
                ),
              ),
            ),
        ],
      ),
      body: _quizFinished ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  Widget _buildQuizScreen() {
    final question = _questions[_currentIndex];
    final bool isCorrect = _answered && _selectedIndex == question.correctIndex;

    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: (_currentIndex + 1) / _questions.length,
          backgroundColor: Colors.grey.shade300,
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1A3A6B)),
          minHeight: 6,
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Score chip
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A3A6B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '⭐ Score: $_score',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Question ${_currentIndex + 1}',
                      style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Question card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A3A6B), Color(0xFF2E6EAD)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1A3A6B).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text('🇯🇴', style: TextStyle(fontSize: 36)),
                      const SizedBox(height: 12),
                      Text(
                        question.question,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Options
                ...List.generate(question.options.length, (i) {
                  final optionLetters = ['A', 'B', 'C', 'D'];
                  return GestureDetector(
                    onTap: () => _selectAnswer(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _getOptionColor(i),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _getOptionBorderColor(i), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: _answered
                                  ? (i == question.correctIndex
                                      ? const Color(0xFF4CAF50)
                                      : i == _selectedIndex
                                          ? const Color(0xFFF44336)
                                          : Colors.grey.shade200)
                                  : const Color(0xFF1A3A6B),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                optionLetters[i],
                                style: GoogleFonts.poppins(
                                  color: _answered && i != question.correctIndex && i != _selectedIndex
                                      ? Colors.grey
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              question.options[i],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          if (_getOptionIcon(i) != null) _getOptionIcon(i)!,
                        ],
                      ),
                    ),
                  );
                }),

                // Feedback
                if (_answered) ...[
                  const SizedBox(height: 8),
                  ScaleTransition(
                    scale: _feedbackAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isCorrect
                            ? const Color(0xFFE8F5E9)
                            : const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isCorrect
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFF44336),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            isCorrect ? '🎉 Correct!' : '❌ Not quite!',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isCorrect
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFC62828),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            question.explanation,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A3A6B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _currentIndex < _questions.length - 1
                            ? 'Next Question →'
                            : 'See Results 🏆',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultScreen() {
    final pct = (_score / _questions.length * 100).round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Trophy/result circle
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A3A6B), Color(0xFF2E6EAD)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1A3A6B).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_getScoreEmoji(), style: const TextStyle(fontSize: 40)),
                Text(
                  '$pct%',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _getScoreMessage(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A3A6B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You answered $_score out of ${_questions.length} questions correctly',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 30),

          // Stats row
          Row(
            children: [
              _buildStatCard('✅', 'Correct', '$_score', const Color(0xFF4CAF50)),
              const SizedBox(width: 12),
              _buildStatCard(
                '❌',
                'Wrong',
                '${_questions.length - _score}',
                const Color(0xFFF44336),
              ),
              const SizedBox(width: 12),
              _buildStatCard('📊', 'Score', '$pct%', const Color(0xFF1A3A6B)),
            ],
          ),
          const SizedBox(height: 30),

          // Restart button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _restartQuiz,
              icon: const Icon(Icons.refresh),
              label: Text(
                'Play Again',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A3A6B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.home_outlined),
              label: Text(
                'Back to Home',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1A3A6B),
                side: const BorderSide(color: Color(0xFF1A3A6B), width: 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String emoji, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
