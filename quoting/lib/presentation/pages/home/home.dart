import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoting/presentation/blocs/tabs/tabs_cubit.dart';
import 'package:quoting/presentation/pages/authors/authors.dart';
import 'package:quoting/presentation/pages/labels/labels.dart';
import 'package:quoting/presentation/pages/new_quote/new_quote.dart';
import 'package:quoting/presentation/pages/quotes/quotes.dart';
import 'package:quoting/presentation/pages/sources/sources.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<TabsCubit>().setTabIndex(widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Close the keyboard if it's open
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LazyIndexedStack(
          index: context.select((TabsCubit c) => c.state.tabIndex),
          children: const [
            QuotesPage(),
            AuthorsPage(),
            NewQuotePage(),
            LabelsPage(),
            SourcesPage(),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          child: BottomNavigationBar(
            currentIndex: context.select((TabsCubit c) => c.state.tabIndex),
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface,
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Quotes',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.person_2_sharp),
                icon: Icon(Icons.person_2_outlined),
                label: 'Authors',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.add_circle_sharp),
                icon: Icon(Icons.add_circle_outline),
                label: 'New',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.label_sharp),
                icon: Icon(Icons.label_outline),
                label: 'Label',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.auto_stories_sharp),
                icon: Icon(Icons.auto_stories_outlined),
                label: 'Source',
              ),
            ],
            onTap: (index) async {
              // Close the drawer if it's open
              Navigator.of(context).maybePop();
              // Close the keyboard if it's open
              FocusScope.of(context).unfocus();
              // Change the tab
              context.read<TabsCubit>().setTabIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
