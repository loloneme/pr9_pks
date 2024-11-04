import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/components/cart_item_card.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    required this.items,
    required this.deleteItem,
    required this.decrementAmount,
    required this.incrementAmount,
  });

  final List<CartItem> items;
  final Function deleteItem;
  final Function decrementAmount;
  final Function incrementAmount;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    int totalCost = widget.items.fold(0, (total, item) => total + item.amount * item.priceOfOneItem);

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("Корзина",
                  style: GoogleFonts.sourceSerif4(
                      textStyle: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(255, 238, 205, 1.0),
                  )))),
          backgroundColor: const Color.fromRGBO(71, 58, 42, 1.0),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color.fromRGBO(71, 58, 42, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child:
                  ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartItemCard(
                            item: widget.items[index],
                            index: index,
                            onDelete: () => widget.deleteItem(index),
                            onDecrement: () => widget.decrementAmount(index),
                            onIncrement: () => widget.incrementAmount(index));
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Container(
                    width: double.infinity,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 238, 205, 1.0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Итого:",
                        style: GoogleFonts.sourceSerif4(
                            textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 238, 205, 1.0),
                            ))),
                    Text(
                        "$totalCost₽",
                        style: GoogleFonts.sourceSerif4(
                            textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(255, 238, 205, 1.0),
                            )))
                  ]
                )
              ],
            ),
          ),
        ));
  }
}
