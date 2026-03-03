import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/demo/finote/controller/finote_provider.dart';

class FinoteAiAssistantScreen extends StatelessWidget {
  const FinoteAiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F3),
      body: Column(
        children: [
          const SizedBox(height: 50),
          // Custom Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () =>
                      context.read<FinoteProvider>().setShowAiAssistant(false),
                ),
                const SizedBox(width: 8),
                const Text(
                  'AI Assistant',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.more_vert, color: Colors.black54),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Chat Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildMessage(
                  "Hello! I'm your Finote AI. How can I help you today?",
                  false,
                ),
                _buildMessage("Analyze my spending for this month.", true),
                _buildMessage(
                  "You have spent ₹3,000 this month. Your largest expense was 'Rent' at ₹1,500.",
                  false,
                ),
              ],
            ),
          ),
          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessage(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUser ? Colors.black : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
