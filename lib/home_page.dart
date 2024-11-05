import 'package:flutter/material.dart';
import 'item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> items = [
    Item(
        name: 'Laptop',
        price: 25000000,
        controller: TextEditingController(text: '0')),
    Item(
        name: 'Mouse',
        price: 1250000,
        controller: TextEditingController(text: '0')),
    Item(
        name: 'Keyboard',
        price: 1500000,
        controller: TextEditingController(text: '0')),
    Item(
        name: 'Monitor',
        price: 5000000,
        controller: TextEditingController(text: '0')),
    Item(
        name: 'Printer',
        price: 2200000,
        controller: TextEditingController(text: '0')),
  ];

  int total = 0;
  List<String> receiptItems = [];
  bool isReceiptVisible = false;

  void calculateTotal({bool isCetak = false}) {
    int sum = 0;
    List<String> receipt = [];

    for (var item in items) {
      int quantity = int.tryParse(item.controller.text) ?? 0;
      int subtotal = item.price * quantity;

      if (quantity > 0) {
        receipt.add('${item.name} x $quantity = Rp $subtotal');
      }

      sum += subtotal;
    }

    setState(() {
      total = sum;
      receiptItems = receipt;
      if (isCetak) {
        isReceiptVisible = true;
      }
    });
  }

  void reset() {
    for (var item in items) {
      item.controller.text = '0';
    }
    setState(() {
      total = 0;
      receiptItems.clear();
      isReceiptVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Komputer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: items.map((item) {
                  return ListTile(
                    title: Text(item.name, style: TextStyle(fontSize: 18)),
                    subtitle: Text('Rp ${item.price}'),
                    trailing: SizedBox(
                      width: 60,
                      child: TextField(
                        controller: item.controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '0',
                        ),
                        onChanged: (value) => calculateTotal(),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: reset,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () => calculateTotal(isCetak: true),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Cetak Struk'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isReceiptVisible) ...[
              Expanded(
                child: ListView(
                  children: receiptItems.map((strukItem) {
                    return ListTile(
                      title: Text(strukItem),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: Colors.lightBlue,
                child: Text(
                  'Total Bayar: Rp $total',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
