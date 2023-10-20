import 'package:flutter/material.dart';
import 'package:mobile_laundy_apps/utils/get_screen_size.dart';

class LaundryDetailChooser extends StatefulWidget {
  String _laundryLabel = "Label";
  double _laundryPrice = 0;

  LaundryDetailChooser setLaundryLabel(String label) {
    _laundryLabel = label;
    return this;
  }

  LaundryDetailChooser setLaundryPrice(double price) {
    _laundryPrice = price;
    return this;
  }

  @override
  _LaundryDetailChooserState createState() => _LaundryDetailChooserState();
}

class _LaundryDetailChooserState extends State<LaundryDetailChooser> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        height: 55,
        width: GetScreenSize.getScreenWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            width: 1.5,
          ),
          color: _isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget._laundryLabel,
                  style: TextStyle(
                    color: _isSelected
                        ? Colors.white
                        : Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontFamily: "Lato",
                  )),
              Text("Rp.${widget._laundryPrice}/kg",
                  style: TextStyle(
                    color: _isSelected
                        ? Colors.white
                        : Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontFamily: "Lato",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
