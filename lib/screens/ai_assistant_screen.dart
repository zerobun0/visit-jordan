import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/gemini_service.dart';
import 'api_key_screen.dart';

class _Message {
  final String text;
  final bool isUser;
  final bool isError;
  _Message({required this.text, required this.isUser, this.isError = false});
}

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_Message> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messages.add(_Message(
      text: '👋 **Marhaba! Welcome to Jordan!**\n\nI\'m your AI Travel Assistant powered by Google Gemini 🤖\n\nAsk me anything about Jordan — attractions, routes, food, visa info and more!',
      isUser: false,
    ));
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isTyping) return;

    setState(() {
      _messages.add(_Message(text: text, isUser: true));
      _isTyping = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final response = await geminiService.sendMessage(text);
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(_Message(text: response, isUser: false));
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(_Message(
          text: '⚠️ Something went wrong. Please check your connection and try again.',
          isUser: false,
          isError: true,
        ));
      });
    }
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendSuggestion(String query) {
    _controller.text = query;
    _sendMessage();
  }

  void _changeApiKey() {
    geminiService.reset();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ApiKeyScreen()),
    );
  }

  void _clearChat() {
    geminiService.reset();
    setState(() {
      _messages.clear();
      _messages.add(_Message(
        text: '🔄 Chat cleared! Ask me anything about **Jordan tourism** 🇯🇴',
        isUser: false,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('🤖', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Travel Assistant',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                Text('Powered by Gemini 2.5',
                    style: GoogleFonts.poppins(fontSize: 11, color: Colors.white70)),
              ],
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1A6B3C),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) {
              if (value == 'clear') _clearChat();
              if (value == 'change_key') _changeApiKey();
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    const Icon(Icons.refresh, size: 18, color: Color(0xFF1A6B3C)),
                    const SizedBox(width: 10),
                    Text('Clear chat', style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'change_key',
                child: Row(
                  children: [
                    const Icon(Icons.vpn_key_outlined, size: 18, color: Color(0xFF1A6B3C)),
                    const SizedBox(width: 10),
                    Text('Change API key', style: GoogleFonts.poppins(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Suggestion chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip('🏛️ Petra', 'Tell me about Petra'),
                  _buildChip('🏜️ Wadi Rum', 'Tell me about Wadi Rum'),
                  _buildChip('🌊 Dead Sea', 'Tell me about the Dead Sea'),
                  _buildChip('🏟️ Jerash', 'Tell me about Jerash'),
                  _buildChip('🗺️ Route', 'Suggest a 5-day travel route in Jordan'),
                  _buildChip('🍽️ Food', 'What food should I try in Jordan?'),
                  _buildChip('✈️ Visa', 'How do I get a visa for Jordan?'),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          // Messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          // Input bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    textInputAction: TextInputAction.send,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Ask about Jordan...',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
                      filled: true,
                      fillColor: const Color(0xFFF0F4F8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    ),
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A6B3C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String query) {
    return GestureDetector(
      onTap: () => _sendSuggestion(query),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1A6B3C), width: 1),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF1A6B3C),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(_Message msg) {
    final isUser = msg.isUser;
    final isError = msg.isError;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // AI avatar
          if (!isUser) ...[
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(right: 6, bottom: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF1A6B3C),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🤖', style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
          // Bubble
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isError
                  ? const Color(0xFFFFEBEE)
                  : isUser
                      ? const Color(0xFF1A6B3C)
                      : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: isUser
                // User bubble — plain text, no markdown needed
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Text(
                      msg.text,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  )
                // AI bubble — render markdown
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: MarkdownBody(
                      data: msg.text,
                      shrinkWrap: true,
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isError ? Colors.red[700] : Colors.grey[850],
                          height: 1.55,
                        ),
                        strong: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isError ? Colors.red[700] : const Color(0xFF1A6B3C),
                        ),
                        em: GoogleFonts.poppins(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[800],
                        ),
                        h1: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A6B3C),
                        ),
                        h2: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A6B3C),
                        ),
                        h3: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A6B3C),
                        ),
                        listBullet: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[850],
                          height: 1.55,
                        ),
                        blockquote: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        code: GoogleFonts.poppins(
                          fontSize: 13,
                          backgroundColor: const Color(0xFFF0F4F8),
                        ),
                        blockSpacing: 6,
                        listIndent: 16,
                      ),
                    ),
                  ),
          ),
          // User avatar
          if (isUser) ...[
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(left: 6, bottom: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF8B4513),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.person, color: Colors.white, size: 16),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(right: 6, bottom: 4),
            decoration: const BoxDecoration(
              color: Color(0xFF1A6B3C),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('🤖', style: TextStyle(fontSize: 14)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 6),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _AnimatedDot(delay: 0),
                const SizedBox(width: 5),
                _AnimatedDot(delay: 200),
                const SizedBox(width: 5),
                _AnimatedDot(delay: 400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _AnimatedDot extends StatefulWidget {
  final int delay;
  const _AnimatedDot({required this.delay});

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFF1A6B3C),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
