import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../business_logic/cubit/characters_state.dart';
import '../../config/theme/colors.dart';
import '../../data/model/character.dart';
import '../widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacter;
  List<Character> characterSearchList = [];

  bool _isSearching = false;
  final searchTextController = TextEditingController();

  Widget _buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.myWhite, fontSize: 25),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myBlack,
      autofocus: true,
      autocorrect: true,
      decoration: const InputDecoration(
        hintText: "Find a character ...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myWhite, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myWhite, fontSize: 18),
      onChanged: (v) {
        characterSearchList = allCharacter
            .where((element) => element.name.toLowerCase().startsWith(v))
            .toList();

        setState(() {});
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.maybePop(context);
            },
            icon: const Icon(Icons.clear)),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            ModalRoute.of(context)!.addLocalHistoryEntry(
                LocalHistoryEntry(onRemove: _stopSearching));
            setState(() {
              _isSearching = true;
            });
          },
          icon: const Icon(Icons.search),
        ),
      ];
    }
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();

    super.initState();
  }

  Widget _buildBlocWidget() {
    if (searchTextController.text.isNotEmpty && characterSearchList.isEmpty) {
      return _buildNotFoundWidget();
    } else {
      return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (constext, state) {
          if (state is CharactersLoaded) {
            allCharacter = state.characters; //? What is that?
            // print(allCharacter.toString()); // Done
            return _buildLoadedListWidget();
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: MyColors.myBlue,
            ));
          }
        },
      );
    }
  }

  Widget _buildLoadedListWidget() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchTextController.text.isEmpty
          ? allCharacter.length
          : characterSearchList.length,
      itemBuilder: (ctx, ind) {
        var chars = searchTextController.text.isEmpty
            ? allCharacter
            : characterSearchList;
        print("works");
        return CharacterItem(char: chars[ind]);
      },
    );
  }

  Widget _buildNotFoundWidget() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        textBaseline: TextBaseline.ideographic,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 35,
            color: Colors.amber[600],
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Not Found",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.myWhite),
        backgroundColor: MyColors.myGreen,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivityResult, Widget widget) {
          final bool connected = connectivityResult != ConnectivityResult.none;

          if (connected) {
            return _buildBlocWidget();
          } else {
            return const Center(child: Text("no internet"));
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
