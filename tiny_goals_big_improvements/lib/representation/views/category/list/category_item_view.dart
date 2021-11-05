import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';

class CategoryItemView extends StatelessWidget {
  final Category category;
  final Function selectCallback;
  final Function editCallback;
  final Function deleteCallback;

  CategoryItemView({
    Key? key,
    required this.category,
    required this.selectCallback,
    required this.editCallback,
    required this.deleteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: () => selectCallback(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildIcon(),
                _buildText(),
                const Spacer(),
                ..._buildActionButtons(),
              ],
            ),
          ),
        ),
      );

  Widget _buildIcon() => Container(
        margin: const EdgeInsets.fromLTRB(0, 4.0, 16.0, 4.0),
        child: CircleAvatar(
          backgroundColor: Color(category.color),
          foregroundColor: Color(category.color).computeLuminance() > 0.5
              ? Colors.black
              : Colors.white,
          child: Icon(
            IconData(int.parse(category.icon), fontFamily: 'MaterialIcons'),
          ),
        ),
      );

  Widget _buildText() => Column(
        children: [
          Text(
            category.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text(category.description ?? ''),
        ],
      );

  List<Widget> _buildActionButtons() => [
        IconButton(
          onPressed: () => editCallback(),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () => deleteCallback(),
          icon: const Icon(Icons.delete),
        ),
      ];
}
