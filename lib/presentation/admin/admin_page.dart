import 'package:flutter/material.dart';

import 'package:autobridge/app/service_locator.dart';
import 'package:autobridge/domain/entities/car.dart';
import 'package:autobridge/domain/repositories/car_repository.dart';
import 'package:autobridge/services/http_client.dart';
import 'package:autobridge/presentation/widgets/car_card.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final carRepository = getIt<CarRepository>();
    return Scaffold(
      appBar: AppBar(title: const Text('Админка')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const CarFormDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Car>>(
        stream: carRepository.watchCars(),
        builder: (context, snapshot) {
          final cars = snapshot.data ?? [];
          if (cars.isEmpty) {
            return const Center(child: Text('Добавьте первое авто'));
          }
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return Column(
                children: [
                  CarCard(
                    car: car,
                    isFavorite: false,
                    onFavoriteToggle: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => CarFormDialog(existing: car),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('Редактировать'),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              carRepository.deleteCar(car.id);
                            },
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Удалить'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class CarFormDialog extends StatefulWidget {
  const CarFormDialog({super.key, this.existing});

  final Car? existing;

  @override
  State<CarFormDialog> createState() => _CarFormDialogState();
}

class _CarFormDialogState extends State<CarFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _mileageController = TextEditingController();
  final _priceUsdController = TextEditingController();
  final _priceKgsController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String _status = 'inStock';

  @override
  void initState() {
    super.initState();
    final car = widget.existing;
    if (car != null) {
      _brandController.text = car.brand;
      _modelController.text = car.model;
      _yearController.text = car.year.toString();
      _mileageController.text = car.mileage.toString();
      _priceUsdController.text = car.priceUsd.toStringAsFixed(0);
      _priceKgsController.text = car.priceKgs.toStringAsFixed(0);
      _imageUrlController.text = car.imageUrl;
      _status = car.status;
    }
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _mileageController.dispose();
    _priceUsdController.dispose();
    _priceKgsController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final carRepository = getIt<CarRepository>();
    final httpClient = getIt<AppHttpClient>();

    final car = Car(
      id: widget.existing?.id ?? '',
      brand: _brandController.text.trim(),
      model: _modelController.text.trim(),
      year: int.tryParse(_yearController.text) ?? 0,
      mileage: int.tryParse(_mileageController.text) ?? 0,
      priceUsd: double.tryParse(_priceUsdController.text) ?? 0,
      priceKgs: double.tryParse(_priceKgsController.text) ?? 0,
      imageUrl: _imageUrlController.text.trim(),
      status: _status,
    );
    if (car.imageUrl.isNotEmpty) {
      await httpClient.preflightUrl(car.imageUrl);
    }
    if (widget.existing == null) {
      await carRepository.addCar(car);
    } else {
      await carRepository.updateCar(car);
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing == null ? 'Добавить авто' : 'Редактировать авто'),
      content: SizedBox(
        width: 360,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(
                    labelText: 'Марка',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Введите марку' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(
                    labelText: 'Модель',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Введите модель' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(
                    labelText: 'Год',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _mileageController,
                  decoration: const InputDecoration(
                    labelText: 'Пробег',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceUsdController,
                  decoration: const InputDecoration(
                    labelText: 'Цена (USD)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceKgsController,
                  decoration: const InputDecoration(
                    labelText: 'Цена (KGS)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Ссылка на фото',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(
                    labelText: 'Статус',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'inStock', child: Text('В наличии')),
                    DropdownMenuItem(value: 'customOrder', child: Text('Под заказ')),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _status = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
