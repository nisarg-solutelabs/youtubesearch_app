import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_flutter/ui/search/search.dart';
import 'package:my_flutter/ui/search/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchBloc = kiwi.Container().resolve<SearchBloc>();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _searchBloc,
      child: _buildScaffold(),
    );
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
      ),
      body: Container(),
    );
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }
}
