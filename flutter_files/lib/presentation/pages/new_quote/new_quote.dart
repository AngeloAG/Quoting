import 'package:flutter/material.dart';
import 'package:flutter_files/presentation/shared/drawer.dart';

class NewQuotePage extends StatelessWidget {
  const NewQuotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Quote'),
      ),
      endDrawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const TextField(
              decoration: InputDecoration(
                label: Text('Quote text'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 40,
              maxLength: 3000,
            ),
            const SizedBox(height: 20),
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Author',
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.closeView('Selected');
                  },
                  onSubmitted: (selected) {
                    controller.closeView(selected);
                  },
                  leading: const Icon(Icons.add),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(
                  5,
                  (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        controller.closeView(item);
                        FocusManager.instance.primaryFocus?.unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Label',
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.closeView('Selected');
                  },
                  leading: const Icon(Icons.add),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(
                  5,
                  (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Source',
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.closeView('Selected');
                  },
                  leading: const Icon(Icons.add),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(
                  5,
                  (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                label: Text('Page, Paragraph, etc'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
              minLines: 1,
              maxLines: 1,
              maxLength: 300,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
