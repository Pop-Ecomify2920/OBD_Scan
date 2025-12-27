import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  // Format date
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }
  
  // Format time
  static String formatTime(DateTime date, {String format = 'HH:mm'}) {
    return DateFormat(format).format(date);
  }
  
  // Format currency
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }
  
  // Format distance
  static String formatDistance(double distance) {
    if (distance >= 1000) {
      return '${(distance / 1000).toStringAsFixed(1)} km';
    }
    return '${distance.toStringAsFixed(0)} m';
  }
  
  // Format speed
  static String formatSpeed(double speed) {
    return '${speed.toStringAsFixed(0)} km/h';
  }
  
  // Show snackbar
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  // Show loading dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  // Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  // Show confirmation dialog
  static Future<bool> showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
  
  // Parse OBD response
  static String parseOBDResponse(String response) {
    // Remove whitespace and convert to uppercase
    return response.replaceAll(RegExp(r'\s+'), '').toUpperCase();
  }
  
  // Calculate checksum for OBD commands
  static String calculateChecksum(String data) {
    int sum = 0;
    for (int i = 0; i < data.length; i += 2) {
      sum += int.parse(data.substring(i, i + 2), radix: 16);
    }
    String checksum = (sum & 0xFF).toRadixString(16).toUpperCase();
    return checksum.length == 1 ? '0$checksum' : checksum;
  }
  
  // Format VIN from OBD response
  static String formatVIN(String response) {
    // Remove OBD-II response headers and format VIN
    String cleaned = response.replaceAll(RegExp(r'[^A-Z0-9]'), '');
    // VIN is typically 17 characters
    if (cleaned.length >= 17) {
      return cleaned.substring(0, 17);
    }
    return cleaned;
  }
}

