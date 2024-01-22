import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/episodes_cubit.dart';
import '../../business_logic/cubit/episodes_state.dart';
import '../../config/theme/colors.dart';
import '../../data/model/character.dart';
import '../../data/model/episode.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  late List<Episode> charEpisodes;

  @override
  void initState() {
    BlocProvider.of<EpisodesCubit>(context)
        .getCharacterEpisodes(widget.character);
    super.initState();
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myWhite,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Hero(
          tag: widget.character.id,
          child: Text(
            widget.character.name,
            style: const TextStyle(
              color: MyColors.myBlack,
            ),
          ),
        ),
        background: (widget.character.image).isNotEmpty
            ? Image.network(
                widget.character.image,
                fit: BoxFit.cover,
              )
            : Image.asset(
                "assets/animation/not_found.gif",
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _characterInfo(String title, String value, {int maxLines = 1}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: MyColors.myWhite),
        children: [
          TextSpan(
            text: "$title ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
          ),
        ],
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDivider({double width = 10}) {
    return Divider(
      color: MyColors.myGreen,
      height: 30,
      endIndent: width,
      thickness: 4,
    );
  }

  List<Widget> _buildSliverList() {
    return [
      Container(
        margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _characterInfo("Species:", widget.character.species),
            _buildDivider(width: 50),
            _characterInfo("Gender:", widget.character.gender),
            _buildDivider(width: 100),
            _characterInfo("Status:", widget.character.status),
            _buildDivider(width: 75),
            _characterInfo("Type:", widget.character.type),
            _buildDivider(width: 250),
            _buildBlocWidget(),
          ],
        ),
      ),
    ];
  }

  Widget _buildBlocWidget() {
    return BlocBuilder<EpisodesCubit, EpisodesState>(
      builder: (context, state) {
        if (state is EpisodesLoaded) {
          charEpisodes = state.episodes;
          // print(charEpisodes);
          return _buildEpisodesList();
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.myGreen,
            ),
          );
        }
      },
    );
  }

  Widget _buildEpisodesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Episodes: (${charEpisodes.length})",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.myWhite,
              fontSize: 20,
            ),
          ),
        ),
        for (var ep in charEpisodes)
          Text(
            "- ${ep.name}",
            maxLines: 1,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myBlue,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(_buildSliverList()),
          )
        ],
      ),
    );
  }
}
