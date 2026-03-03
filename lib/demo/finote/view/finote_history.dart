import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/demo/finote/controller/finote_provider.dart';
import 'package:shihad_portfolio/core/constants/text_constants.dart';

class FinoteHistoryScreen extends StatelessWidget {
  const FinoteHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinoteProvider>(
      builder: (context, provider, _) {
        final transactions = provider.finoteData['transactions'] as List;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F3),
          body: Column(
            children: [
              const SizedBox(height: 50),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppText.finoteHistoryTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        _buildHeaderIcon(Icons.smart_toy_outlined, context),
                        const SizedBox(width: 12),
                        _buildHeaderIcon(Icons.person_outline, context),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Dropdowns
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(child: _buildDropdown('Month', 'March')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDropdown('Year', '2026')),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    return _HistoryItemTile(tx: tx);
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const Icon(Icons.download, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildHeaderIcon(IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: icon == Icons.smart_toy_outlined
          ? () => context.read<FinoteProvider>().setShowAiAssistant(true)
          : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black, size: 22),
      ),
    );
  }

  Widget _buildDropdown(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '  $label',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3), // Background color
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            ],
          ),
        ),
      ],
    );
  }
}

class _HistoryItemTile extends StatelessWidget {
  final Map<String, dynamic> tx;
  const _HistoryItemTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isIncome = tx['amount'] > 0;
    final color = isIncome ? Colors.green : Colors.red;
    final bgColor = color.withValues(alpha: 0.05);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isIncome ? Icons.north_east : Icons.south_east,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  '02-03-2026', // Mock date from screenshot
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '${isIncome ? '+' : '-'}₹${tx['amount'].abs().toStringAsFixed(0)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.more_vert, color: Colors.black54),
            ],
          ),
        ],
      ),
    );
  }
}
