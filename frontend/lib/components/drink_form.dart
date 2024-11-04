import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/drink.dart';


class DrinkForm extends StatefulWidget {
  final Drink? drink;
  final Function(Drink) onSubmit;

  const DrinkForm({super.key, this.drink, required this.onSubmit});

  @override
  State<DrinkForm> createState() => _DrinkFormState();
}

class _DrinkFormState extends State<DrinkForm> {
  final _formGlobalKey = GlobalKey<FormState>();
  late TextEditingController _imageController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _compoundController;
  late List<TextEditingController> _priceControllers;

  bool _cold = false;
  bool _hot = false;
  Map<String, int> _prices = {};

  // String _image = '';
  // String _name = '';
  // String _description = '';
  // List<String> _compound = [];
  // bool _cold = false;
  // bool _hot = false;
  // Map<String, int> _prices = {};

  final List<String> _volumes = ['250', '350', '500'];


  @override
  void initState() {
    print("form evaluated");

    super.initState();
    _imageController = TextEditingController(text: widget.drink?.image ?? '');
    _nameController = TextEditingController(text: widget.drink?.name ?? '');
    _descriptionController = TextEditingController(text: widget.drink?.description ?? '');
    _compoundController = TextEditingController(text: widget.drink?.compound.join('\n') ?? '');
    // _image = widget.drink?.image ?? '';
    // _name = widget.drink?.name ?? '';
    // _description = widget.drink?.description ?? '';
    // _compound = widget.drink?.compound ?? [];

    _cold = widget.drink?.cold ?? false;
    _hot = widget.drink?.hot ?? false;
    _prices = widget.drink?.prices ?? {};

    _priceControllers = List.generate(_volumes.length, (index) {
      final price = _prices[_volumes[index]]?.toString() ?? '';
      return TextEditingController(text: price);
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _compoundController.dispose();
    for (var controller in _priceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitForm() {
    if (_formGlobalKey.currentState!.validate()) {
      _formGlobalKey.currentState!.save();

      _prices.clear();
      for (int i = 0; i < _volumes.length; i++) {
        final price = int.tryParse(_priceControllers[i].text);
        if (price != null && price > 0) {
          _prices[_volumes[i]] = price;
        }
      }

      final Drink newDrink = Drink(
        id: widget.drink?.id ?? 0,
        // image: _image,
        // name: _name,
        // description: _description,
        // compound: _compound,
        image: _imageController.text,
        name: _nameController.text,
        description: _descriptionController.text,
        compound: _compoundController.text.split('\n').map((e) => e.trim()).toList(),

        cold: _cold,
        hot: _hot,
        prices: _prices,
        isFavorite: widget.drink?.isFavorite ?? false,
      );

      widget.onSubmit(newDrink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        color: Color.fromRGBO(159, 133, 102, 1.0),
    ),
    child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: SizedBox(
                        width: 260,
                        child: TextFormField(
                          maxLength: 20,
                          controller: _nameController,
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(44, 32, 17, 1.0))),
                          decoration: InputDecoration(
                              counterText: '',
                              isDense: true,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(44, 32, 17, 1.0),
                                      width: 2.0)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(44, 32, 17, 1.0),
                                      width: 2.0)),
                              contentPadding: const EdgeInsets.all(5),
                              labelText: "Название",
                              labelStyle: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18.0,
                                      color:
                                          Color.fromRGBO(217, 217, 217, 1.0)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Введите название";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: SizedBox(
                        width: 260,
                        child: TextFormField(
                          controller: _imageController,
                          keyboardType: TextInputType.url,
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(44, 32, 17, 1.0))),
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(44, 32, 17, 1.0),
                                      width: 2.0)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(44, 32, 17, 1.0),
                                      width: 2.0)),
                              contentPadding: const EdgeInsets.all(5),
                              labelText: "URL картинки",
                              labelStyle: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18.0,
                                      color:
                                          Color.fromRGBO(217, 217, 217, 1.0)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Введите URL";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SwitchListTile(
                        title: Text("Можно сделать холодным?",
                            style: GoogleFonts.sourceSerif4(
                                textStyle: const TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(44, 32, 17, 1.0),
                            ))),
                        contentPadding: const EdgeInsets.all(0),
                        inactiveThumbColor:
                            const Color.fromRGBO(44, 32, 17, 1.0),
                        inactiveTrackColor:
                            const Color.fromRGBO(217, 217, 217, 1),
                        activeColor: const Color.fromRGBO(217, 217, 217, 1),
                        activeTrackColor: const Color.fromRGBO(44, 32, 17, 1.0),
                        value: _cold,
                        onChanged: (value) {
                          setState(() {
                            _cold = value;
                          });
                        }),
                    SwitchListTile(
                        title: Text("Можно сделать горячим?",
                            style: GoogleFonts.sourceSerif4(
                                textStyle: const TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(44, 32, 17, 1.0),
                            ))),
                        contentPadding: const EdgeInsets.all(0),
                        inactiveThumbColor:
                            const Color.fromRGBO(44, 32, 17, 1.0),
                        inactiveTrackColor:
                            const Color.fromRGBO(217, 217, 217, 1),
                        activeColor: const Color.fromRGBO(217, 217, 217, 1),
                        activeTrackColor: const Color.fromRGBO(44, 32, 17, 1.0),
                        value: _hot,
                        onChanged: (value) {
                          setState(() {
                            _hot = value;
                          });
                        }),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    //   child: Text("Состав:", style: GoogleFonts.sourceSerif4(
                    //         textStyle: const TextStyle(
                    //             fontSize: 18.0,
                    //             color:
                    //                 Color.fromRGBO(44, 32, 17, 1.0)))),
                    // ),
                    SizedBox(
                      width: 260,
                      child: TextFormField(
                        controller: _compoundController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        style: GoogleFonts.sourceSerif4(
                            textStyle: const TextStyle(
                                fontSize: 18.0,
                                color: Color.fromRGBO(44, 32, 17, 1.0))),
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 32, 17, 1.0),
                                    width: 2.0)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(44, 32, 17, 1.0),
                                    width: 2.0)),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5
                            ),
                          labelText: "Состав",
                          labelStyle: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.0,
                                  color:
                                  Color.fromRGBO(217, 217, 217, 1.0))),
                            hintText:
                                'Введите каждый ингредиент на новой строке',
                            hintStyle: GoogleFonts.sourceSerif4(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16.0,
                                    color: Color.fromRGBO(217, 217, 217, 1.0))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Введите хотя бы один ингредиент";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Text('Цена:',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(44, 32, 17, 1.0)))),
                    ),
                    Column(
                        children: List.generate(_volumes.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "${_volumes[index]}мл",
                              style: GoogleFonts.sourceSerif4(
                                  textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(44, 32, 17, 1.0))),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 70,
                              child: TextFormField(
                                controller: _priceControllers[index],
                                keyboardType: TextInputType.number,
                                maxLength: 5,
                                style: GoogleFonts.sourceSerif4(
                                    textStyle: const TextStyle(
                                        fontSize: 16.0,
                                        color:
                                            Color.fromRGBO(44, 32, 17, 1.0))),
                                decoration: InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 5.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      style: GoogleFonts.sourceSerif4(
                          textStyle: const TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(44, 32, 17, 1.0))),
                      decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(44, 32, 17, 1.0),
                                  width: 2.0)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(44, 32, 17, 1.0),
                                  width: 2.0)),
                          labelText: "Описание",
                          labelStyle: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(217, 217, 217, 1.0)))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Введите описание";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(44, 32, 17, 1.0),
                        ),
                        onPressed: () => _submitForm(),
                        child: Text('Сохранить',
                          style: GoogleFonts.sourceSerif4(
                              textStyle: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(255, 238, 205, 1.0)))
                        ),
                      ),
                    ),
                  ],

                )),)
    ))
    );
  }
}
