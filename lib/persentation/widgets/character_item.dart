import '../../app_router.dart';
import '../../config/theme/colors.dart';
import '../../data/model/character.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character char;

  const CharacterItem({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          MyRoutes.characterDetailsScreen,
          arguments: char,
        ),
        child: GridTile(
          footer: Hero(
            tag: char.id,
            child: Container(
              color: Colors.black45,
              alignment: Alignment.bottomLeft,
              width: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10, vertical: 10),
              child: Text(
                char.name,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: const TextStyle(
                  height: 1.3,
                  color: MyColors.myWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          child: Container(
            child: char.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/animation/loading.gif',
                    image: char.image)
                : Image.asset("assets/animation/not_found.gif"),
          ),
        ),
      ),
    );
  }
}
