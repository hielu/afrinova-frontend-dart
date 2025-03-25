import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'package:afrinova/features/wallet/home/widgets/transparent_app_bar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _chats = [
    {
      'id': 'c1',
      'name': 'Thomas Haile',
      'avatar': 'https://randomuser.me/api/portraits/women/12.jpg',
      'lastMessage': 'Hey, did you receive the payment?',
      'time': '10:45 AM',
      'unread': 2,
      'isOnline': true,
    },
    {
      'id': 'c2',
      'name': 'RObel Solomon',
      'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
      'lastMessage': 'The package has been delivered',
      'time': '9:30 AM',
      'unread': 0,
      'isOnline': false,
    },
    {
      'id': 'c3',
      'name': 'Habtom Elias',
      'avatar': 'https://randomuser.me/api/portraits/women/22.jpg',
      'lastMessage': 'Thanks for your help with the order!',
      'time': 'Yesterday',
      'unread': 0,
      'isOnline': true,
    },
    {
      'id': 'c4',
      'name': 'Luwam Haile',
      'avatar': 'https://randomuser.me/api/portraits/men/42.jpg',
      'lastMessage': 'Can you send me the invoice?',
      'time': 'Yesterday',
      'unread': 3,
      'isOnline': false,
    },
    {
      'id': 'c5',
      'name': 'Rahel Ghirmay',
      'avatar': 'https://randomuser.me/api/portraits/women/32.jpg',
      'lastMessage': 'I need to reschedule our meeting',
      'time': 'Jun 12',
      'unread': 0,
      'isOnline': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TransparentAppBar(
        username: "Helen Ghirmay",
        hasNotification: true,
      ),
      body: Container(
        color: TColors.primary,
        child: Column(
          children: [
            // Top section with search and tabs
            _buildTopSection(),

            // Chat list section
            _buildChatListSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Start new chat
        },
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.message_add, color: Colors.white),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 120, 20, 30),
      decoration: const BoxDecoration(
        color: TColors.primary,
      ),
      child: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Search messages...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Iconsax.search_normal, color: Colors.white70),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Tabs
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              labelColor: TColors.primary,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(text: 'Chats'),
                Tab(text: 'Calls'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatListSection() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            // Chats tab
            _buildChatList(),

            // Calls tab (placeholder)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.call,
                    size: 64,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No recent calls',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        final chat = _chats[index];

        return InkWell(
          onTap: () {
            // Navigate to chat detail
            _navigateToChatDetail(chat);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: index < _chats.length - 1
                  ? Border(
                      bottom: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    )
                  : null,
            ),
            child: Row(
              children: [
                // Avatar with online indicator
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(chat['avatar']),
                      onBackgroundImageError: (_, __) {
                        // Handle image loading error
                      },
                      child: null,
                    ),
                    if (chat['isOnline'])
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                // Chat details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chat['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: TColors.textPrimary,
                            ),
                          ),
                          Text(
                            chat['time'],
                            style: TextStyle(
                              color: chat['unread'] > 0
                                  ? TColors.primary
                                  : Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat['lastMessage'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: chat['unread'] > 0
                                    ? TColors.textPrimary
                                    : Colors.grey[600],
                                fontWeight: chat['unread'] > 0
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (chat['unread'] > 0)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: TColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                chat['unread'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToChatDetail(Map<String, dynamic> chat) {
    Get.to(() => ChatDetailScreen(chat: chat));
  }
}

class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> chat;

  const ChatDetailScreen({
    super.key,
    required this.chat,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'id': 'm1',
      'text': 'Hey, did you receive the payment?',
      'time': '10:45 AM',
      'isMe': false,
    },
    {
      'id': 'm2',
      'text': 'Yes, I got it. Thank you!',
      'time': '10:47 AM',
      'isMe': true,
    },
    {
      'id': 'm3',
      'text': 'Great! How is the order coming along?',
      'time': '10:50 AM',
      'isMe': false,
    },
    {
      'id': 'm4',
      'text': 'It\'s almost ready. I\'ll ship it tomorrow.',
      'time': '10:52 AM',
      'isMe': true,
    },
    {
      'id': 'm5',
      'text': 'Perfect! Looking forward to receiving it.',
      'time': '10:55 AM',
      'isMe': false,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.chat['avatar']),
              onBackgroundImageError: (_, __) {
                // Handle image loading error
              },
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.chat['isOnline'] ? 'Online' : 'Offline',
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.chat['isOnline']
                        ? Colors.green[200]
                        : Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.call, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.more, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isMe = message['isMe'] as bool;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? TColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(
                              color: isMe ? Colors.white : TColors.textPrimary,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            message['time'],
                            style: TextStyle(
                              color: isMe
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.attach_circle, color: Colors.grey),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: TColors.primary,
                    child: IconButton(
                      icon: const Icon(Iconsax.send_1, color: Colors.white),
                      onPressed: () {
                        // Send message
                        if (_messageController.text.trim().isNotEmpty) {
                          // In a real app, you would send the message to a backend
                          _messageController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
