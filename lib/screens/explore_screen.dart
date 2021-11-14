import 'package:flutter/material.dart';

import '../components/components.dart';
import '../api/mock_fooderlich_service.dart';
import '../models/models.dart';
class ExploreScreen  extends StatefulWidget {

  ExploreScreen ({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final mockService = MockFooderlichService();
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(_onScrollEvent);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollEvent);
    super.dispose();
  }

  void _onScrollEvent() {
    final extentBefore = _controller.position.extentBefore;
    print('Extent Before: $extentBefore');
  }
  @override
  @override
  Widget build(BuildContext context) {
    // 1
    return FutureBuilder(
      // 2
      future: mockService.getExploreData(),
      // 3
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        // 4
        if (snapshot.connectionState == ConnectionState.done) {
          // 5
          return ListView(
            controller: _controller,
            // 6
            scrollDirection: Axis.vertical,
            children: [
              // 7
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              // 8
              const SizedBox(height: 16),
              // 9


              FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? []),

            ],
          );
        } else {
          // 10
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
