import 'package:flutter/material.dart';
import 'package:recipes/recipe.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetail({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipe.label),
        ),
        body: SafeArea(
          child: Column(children: <Widget>[
            SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset(widget.recipe.image)),
            const SizedBox(height: 20),
            Text(widget.recipe.label, style: const TextStyle(fontSize: 20)),
            // show ingredients
            const SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
              itemBuilder: _buildItem,
              itemCount: widget.recipe.ingredients.length,
              padding: const EdgeInsets.all(8),
            )),
            // add slider
            const SizedBox(height: 20),
            Slider(
                value: _sliderVal.toDouble(),
                onChanged: onChange,
                divisions: 10,
                label: '${_sliderVal * widget.recipe.servings} servings',
                activeColor: Colors.green,
                inactiveColor: Colors.black,
                min: 1,
                max: 10),
          ]),
        ));
  }

  Widget _buildItem(BuildContext context, int index) {
    final ingredient = widget.recipe.ingredients[index];
    return Text(
        '${ingredient.quantity * _sliderVal} ${ingredient.measure} ${ingredient.name}');
  }

  void onChange(double value) {
    setState(() {
      _sliderVal = value.toInt();
    });
  }
}
