import 'package:flutter/material.dart';

/// A screen that displays a list of items for selection.
///
/// This screen provides a search functionality to filter the list of items based on a query.
/// It displays an app bar with a title and optional actions, including a search icon to enable filtering.
/// The items are displayed in a scrollable list view, and a custom item builder is used to render each item.
///
/// The `T` type parameter represents the type of items in the list.
class SearchableSelectionScreen<T> extends StatefulWidget {
  /// Creates a selection screen.
  const SearchableSelectionScreen({
    Key? key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.actions = const [],
  }) : super(key: key);

  /// The title to be displayed in the app bar.
  final String title;

  /// The list of items to be displayed for selection.
  final List<T> items;

  /// A callback function that takes a [BuildContext] and an item of type [T],
  /// and returns a widget that represents the item in the list.
  final Widget Function(BuildContext context, T index) itemBuilder;

  /// The additional actions to be displayed in the app bar.
  final List<Widget> actions;

  @override
  State<SearchableSelectionScreen<T>> createState() => _SearchableSelectionScreenState<T>();
}

class _SearchableSelectionScreenState<T> extends State<SearchableSelectionScreen<T>> {
  late List<T> filteredItems;

  final FocusNode searchNode = FocusNode();

  bool typing = false;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
  }

  /// Filters the list of items based on the provided query.
  void filterList(String query) {
    setState(() {
      filteredItems = widget.items.where((item) => item.toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: typing
            ? TextField(
                focusNode: searchNode,
                onChanged: filterList,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              )
            : Text(
                widget.title,
              ),
        actions: [
          typing
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      searchNode.unfocus();
                      filterList('');
                      typing = false;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      searchNode.requestFocus();
                      typing = true;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
          ...widget.actions,
        ],
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return widget.itemBuilder(context, item);
        },
      ),
    );
  }
}