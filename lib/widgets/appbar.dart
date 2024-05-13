import 'dart:developer';
import 'package:flutter/material.dart';
import '../constant/colors/app_colors.dart';
import '../constant/strgins/app_strings.dart';
import '../data/model/post_response.dart';
import '../data/services/post_service.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.itemColor,
      foregroundColor: Colors.white,
      title: const Text(
        AppStrings.appBarTitle,
      ),
      actions: [
        FutureBuilder<List<PostResponse>>(
          future: _postData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data');
            } else {
              final postData = snapshot.data!;
              return SizedBox(
                width: 120.0,
                child: DropdownButton<PostResponse>(
                  hint: const Text("Choose"),
                  value: _selectedValue,
                  items: postData.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: SizedBox(
                        width: 100.0,
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
