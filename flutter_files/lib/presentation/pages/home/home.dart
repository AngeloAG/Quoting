import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_files/presentation/blocs/tabs/tabs_cubit.dart';
import 'package:flutter_files/presentation/pages/authors/authors.dart';
import 'package:flutter_files/presentation/pages/labels/labels.dart';
import 'package:flutter_files/presentation/pages/new_quote/new_quote.dart';
import 'package:flutter_files/presentation/pages/quotes/quotes.dart';
import 'package:flutter_files/presentation/pages/sources/sources.dart';
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
    return Scaffold(
      body: LazyIndexedStack(
        index: context.select((TabsCubit c) => c.state.tabIndex),
        children: const [
          QuotesPage(),
          AuthorsPage(),
          NewQuotePage(),
          LabelsPage(),
          SourcesPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey.shade700,
        selectedItemColor: Colors.grey.shade700,
        backgroundColor: Colors.brown.shade50,
        currentIndex: context.select((TabsCubit c) => c.state.tabIndex),
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
        onTap: (index) {
          Beamer.of(context).update(
              configuration: RouteInformation(
                uri: Uri.parse(
                  switch (index) {
                    0 => '/quotes',
                    1 => '/authors',
                    2 => '/new_quote',
                    3 => '/labels',
                    4 => '/sources',
                    int() => '/quotes',
                  },
                ),
              ),
              rebuild: false);
          context.read<TabsCubit>().setTabIndex(index);
        },
      ),
    );
  }
}
