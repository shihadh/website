import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/demo/finote/controller/finote_provider.dart';

class FinoteAddTransactionScreen extends StatelessWidget {
  const FinoteAddTransactionScreen({super.key});

  final List<String> _categories = const [
    'Select category',
    'Food',
    'Shopping',
    'Salary',
    'Rent',
    'Transport',
    'Healthcare',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<FinoteProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildHeaderIcon(Icons.smart_toy_outlined, context),
                    const SizedBox(width: 12),
                    _buildHeaderIcon(Icons.qr_code_scanner, context),
                    const SizedBox(width: 12),
                    _buildHeaderIcon(Icons.person_outline, context),
                  ],
                ),
                const SizedBox(height: 20),

                _buildSectionLabel('Amount'),
                const SizedBox(height: 8),
                _buildTextField('₹ 0', controller: provider.amountController),

                const SizedBox(height: 20),
                _buildSectionLabel('Transaction Type'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildTypeButton(
                        '+ Income',
                        provider.isIncome,
                        Colors.green.withValues(alpha: 0.2),
                        () => provider.setIncome(true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTypeButton(
                        '- Expense',
                        !provider.isIncome,
                        Colors.redAccent,
                        () => provider.setIncome(false),
                        isExpense: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                _buildSectionLabel('Date'),
                const SizedBox(height: 8),
                _buildTextField(
                  'DD-MM-YYYY',
                  suffixIcon: Icons.calendar_today_outlined,
                ),

                const SizedBox(height: 20),
                _buildSectionLabel('Category'),
                const SizedBox(height: 8),
                _buildDropdown(provider),

                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildSectionLabel('Note'),
                    const SizedBox(width: 4),
                    const Text(
                      '(Optional)',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  'Add a note about this transaction...',
                  maxLines: 4,
                  controller: provider.noteController,
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (provider.amountController.text.isEmpty) return;
                      final amount =
                          double.tryParse(provider.amountController.text) ?? 0;
                      provider.addTransaction({
                        'title': provider.noteController.text.isNotEmpty
                            ? provider.noteController.text
                            : (provider.isIncome ? 'Income' : 'Expense'),
                        'amount': provider.isIncome ? amount : -amount,
                        'category':
                            provider.selectedCategory == 'Select category'
                            ? 'General'
                            : provider.selectedCategory,
                        'date': 'Today',
                      });
                      provider.setBottomNavIndex(0);
                      provider.clearForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Save Transaction',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderIcon(IconData icon, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: icon == Icons.smart_toy_outlined
          ? () => context.read<FinoteProvider>().setShowAiAssistant(true)
          : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: 22),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    TextEditingController? controller,
    IconData? suffixIcon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(
          0xFFC4C4C4,
        ).withValues(alpha: 0.8), // Greyish as per screenshot
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.black54)
            : null,
      ),
    );
  }

  Widget _buildTypeButton(
    String label,
    bool isSelected,
    Color activeColor,
    VoidCallback onTap, {
    bool isExpense = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor
              : const Color(0xFFC4C4C4).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
          border: isSelected && !isExpense
              ? Border.all(color: Colors.green)
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? (isExpense ? Colors.white : Colors.black)
                  : Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(FinoteProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFC4C4C4).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: provider.selectedCategory,
          isExpanded: true,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
          items: _categories
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Colors.black87)),
                ),
              )
              .toList(),
          onChanged: (val) => provider.setCategory(val!),
        ),
      ),
    );
  }
}
