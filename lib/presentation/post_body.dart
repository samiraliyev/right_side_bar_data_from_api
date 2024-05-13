import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:test_app/presentation/side_bar.dart';

import '../data/model/post_response.dart';
import '../data/services/post_service.dart';

class PostBody extends StatefulWidget {
  const PostBody({super.key});

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  late Future<List<PostResponse>> _postData;
  PostResponse? _selectedValue;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        _postData = PostService.getPost();
      });
    } catch (error, stackTrace) {
      log('Error fetching data: $error', stackTrace: stackTrace);
    }
  }

  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SideBar(controller: _controller),
        Expanded(
          child: Center(
            child: _selectedValue != null
                ? Text(
                    _selectedValue!.title,
                    style: const TextStyle(color: Colors.white, fontSize: 18.0),
                  )
                : const Text('No value selected'),
          ),
        ),
      ],
    );
  }
}
