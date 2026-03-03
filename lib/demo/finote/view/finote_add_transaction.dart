import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shihad_portfolio/demo/finote/controller/finote_provider.dart';

class FinoteAddTransactionScreen extends StatefulWidget {
  const FinoteAddTransactionScreen({super.key});

  @override
  State<FinoteAddTransactionScreen> createState() =>
      _FinoteAddTransactionScreenState();
}

class _FinoteAddTransactionScreenState
    extends State<FinoteAddTransactionScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedCategory = 'Select category';
  bool _isIncome = true;

  final List<String> _categories = [
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
            _buildTextField('₹ 0', controller: _amountController),

            const SizedBox(height: 20),
            _buildSectionLabel('Transaction Type'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildTypeButton(
                    '+ Income',
                    _isIncome,
                    Colors.green.withValues(alpha: 0.2),
                    () => setState(() => _isIncome = true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTypeButton(
                    '- Expense',
                    !_isIncome,
                    Colors.redAccent,
                    () => setState(() => _isIncome = false),
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
            _buildDropdown(),

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
              controller: _noteController,
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_amountController.text.isEmpty) return;
                  final amount = double.tryParse(_amountController.text) ?? 0;
                  context.read<FinoteProvider>().addTransaction({
                    'title': _noteController.text.isNotEmpty
                        ? _noteController.text
                        : (_isIncome ? 'Income' : 'Expense'),
                    'amount': _isIncome ? amount : -amount,
                    'category': _selectedCategory == 'Select category'
                        ? 'General'
                        : _selectedCategory,
                    'date': 'Today',
                  });
                  context.read<FinoteProvider>().setBottomNavIndex(0);
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

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFC4C4C4).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
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
          onChanged: (val) => setState(() => _selectedCategory = val!),
        ),
      ),
    );
  }
}
