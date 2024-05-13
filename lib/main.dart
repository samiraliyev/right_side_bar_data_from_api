import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:test_app/constant/colors/app_colors.dart';
import 'package:test_app/constant/strgins/app_strings.dart';
import 'package:test_app/data/model/post_response.dart';
import 'package:test_app/data/services/post_service.dart';
import 'package:test_app/presentation/post_body.dart';

import 'presentation/side_bar.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatefulWidget {
  const TaskApp({super.key});

  @override
  _TaskAppState createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
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
    return MaterialApp(
      title: 'Sidebar Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primaryColor: AppColors.primaryColor,
        canvasColor: AppColors.itemColor,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      home: Builder(builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 500;
        return Scaffold(
          
          appBar: isSmallScreen
              ? AppBar(
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                                      style:
                                          const TextStyle(color: Colors.white),
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
                )
              : AppBar(
                  backgroundColor: AppColors.accentCanvasColor,
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text(AppStrings.appBarTitle),
                  actions: [
                    FutureBuilder<List<PostResponse>>(
                      future: _postData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                                      style:
                                          const TextStyle(color: Colors.white),
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
                ),
          drawer: SideBar(controller: _controller),
          body: Row(
            children: [
              SideBar(controller: _controller),
              Expanded(
                child: Center(
                  child: _selectedValue != null
                      ? Text(
                          _selectedValue!.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18.0),
                        )
                      : const Text('No value selected'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
