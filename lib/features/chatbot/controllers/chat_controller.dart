import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';

class ChatController extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  // Predefined responses for shopping queries
  final Map<String, String> _responses = {
    'default': "I can help you with shopping, products, and orders. What would you like to know?",
    'greeting': "Hello! How can I assist you with your shopping today?",
    'product': "We have a great selection of products. You can browse by category or use the search feature.",
    'price': "Our prices are competitive and we often have special deals and discounts.",
    'shipping': "We offer free shipping on orders over \$50. Standard delivery takes 3-5 business days.",
    'payment': "We accept all major credit cards, PayPal, and digital wallets.",
    'return': "Our return policy allows returns within 30 days of purchase with original packaging.",
    'order': "You can track your order in the profile section under 'My Orders'.",
    'help': "I'm here to help! You can ask about products, prices, shipping, or any shopping related questions.",
  };

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(text: text, isUser: true));
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final response = _getResponse(text.toLowerCase());
      _messages.add(ChatMessage(text: response, isUser: false));
    } catch (e) {
      _messages.add(ChatMessage(
        text: "I'm sorry, I couldn't understand that. How else can I help you with shopping?",
        isUser: false,
      ));
    }

    _isLoading = false;
    notifyListeners();
  }

  String _getResponse(String text) {
    if (text.contains('hi') || text.contains('hello')) {
      return _responses['greeting']!;
    } else if (text.contains('product') || text.contains('item')) {
      return _responses['product']!;
    } else if (text.contains('price') || text.contains('cost')) {
      return _responses['price']!;
    } else if (text.contains('ship') || text.contains('delivery')) {
      return _responses['shipping']!;
    } else if (text.contains('pay')) {
      return _responses['payment']!;
    } else if (text.contains('return') || text.contains('refund')) {
      return _responses['return']!;
    } else if (text.contains('order') || text.contains('track')) {
      return _responses['order']!;
    } else if (text.contains('help')) {
      return _responses['help']!;
    }
    return _responses['default']!;
  }

  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
} 