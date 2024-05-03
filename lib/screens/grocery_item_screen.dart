
import '../components/grocery_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool? isUpdating;
  const GroceryItemScreen({super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
    }):isUpdating=(originalItem!=null);

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  //TODO: Add grocery item screen state properties
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currectColor = Colors.green;
  int _currentSliderValue=0;

  //TODO: Add initState()
  @override
  void initState(){
    super.initState();
    final originalItem = widget.originalItem;
    if(originalItem!=null){
      _nameController.text = originalItem.name;
      _name=originalItem.name;
      _currentSliderValue=originalItem.quantity;
      _importance=originalItem.importance;
      _currectColor=originalItem.color;
      final date = originalItem.date;
      _timeOfDay=TimeOfDay(hour: date.hour, minute: date.minute,);
      _dueDate=date;
    }
    _nameController.addListener(() {
      setState(() {
        _name=_nameController.text;
      });
    });
  }
  //TODO: Add dispose()
  @override
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Add GroceryItemScreenScaffold
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: const Icon(Icons.check))
        ],
        elevation: 0.0,
        title: const Text('Grocery Item'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children:  [
            //TODO: aDD buildNameField()
            buildNameField(),
            //TODO: Add buildImportanceField()
            buildImportanceField(),
            //TODO: Add buildDateField()
            buildDateField( context),
            //TODO: Add buildTimeField()
            buildTimeField(context),
            //TODO:Add buildColorPicker()
            const SizedBox(height: 10.0),
            buildColorPicker(context),
            //TODO: Add buildQuantityField()
            const SizedBox(height: 10.0),
            buildQuantityField(),
            const SizedBox(height: 16),
            GroceryTile(
                item: GroceryItem(
                  name: _name,
                  importance: _importance,
                  color: _currectColor,
                  quantity: _currentSliderValue,
                  date: DateTime(_dueDate.year,_dueDate.month,_dueDate.day,
                      _timeOfDay.hour,_timeOfDay.minute,), id: '',),
            ),
          ],
        ),
      ),
    );
  }
  //TODO: aDD buildNameField()
  Widget buildNameField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'E.g Apples, Banana, 1 Bag of Salt',
            labelText: 'Item Name'
          ),
        ),
        const SizedBox(height: 16)
      ],
    );
  }
  //TODO: Add buildImportanceField()

Widget buildImportanceField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            'Importance',
        style: TextStyle(
          fontSize: 20.0
        ),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
               // selectedColor: Colors.black,
                selected: _importance==Importance.low,

                label: const Text('low',
                    //style: TextStyle(
                    //  color: Colors.white
                    //),
                ),
              onSelected: (selected){
                  setState(() => _importance=Importance.low);
              },
            ),
            ChoiceChip(
              //selectedColor: Colors.black,
              selected: _importance==Importance.medium,

              label: const Text('medium',
                //style: TextStyle(
                 //   color: Colors.white
               // ),
              ),
              onSelected: (selected){
                setState(() => _importance=Importance.medium);
              },
            ),
            ChoiceChip(
              //selectedColor: Colors.black,
              selected: _importance==Importance.high,

              label: const Text(
                'high',
                //style: TextStyle(
                 //   color: Colors.white
                //),
              ),
              onSelected: (selected){
                setState(() => _importance=Importance.high);
              },
            ),
          ],
        )
      ],
    );
}
  //TODO: Add buildDateField()
Widget buildDateField(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Date',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextButton(
              child: const Text('Select'),
                onPressed: () async {
                  final currentDate= DateTime.now();
                  final selectedDate = await showDatePicker(
                      context: context, 
                      initialDate: currentDate,
                      firstDate: currentDate, 
                      lastDate:DateTime(currentDate.year+5) 
                  );
                  setState(() {
                    if(selectedDate!=null){
                      _dueDate=selectedDate;
                    }
                  });
                },
            ),
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(_dueDate))
      ],
    );
}
  //TODO: Add buildTimeField()

Widget buildTimeField(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Time of Day'),
            TextButton(
              child:const Text('Select'),

                onPressed:() async{
              final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now()
              );
              setState(() {
                if(timeOfDay!=null){
                  _timeOfDay=timeOfDay;
                }
              });

            },),
          ]),

        Text(_timeOfDay.format(context)),

      ],);
}

  //TODO:Add buildColorPicker()
Widget buildColorPicker(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,width: 10.0, color: _currectColor,
            ),
            const SizedBox(width: 8.0),
            const Text('Color'),

          ],
        ),
        TextButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      content: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (color){
                          setState(()=> _currectColor=color);
                        },
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Save'))
                      ],
                    );
                  });
            },
            child: const Text('Select'),
        )
      ],
    );
}
  //TODO: Add buildQuantityField()

Widget buildQuantityField(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text('Quantity'),
            const SizedBox(width: 16.0),
            Text(_currentSliderValue.toInt().toString(),
            ),

          ],
        ),
        Slider(
          inactiveColor: _currectColor.withOpacity(0.5),
            activeColor: _currectColor,

            value: _currentSliderValue.toDouble(),
            min: 0.0,
            max: 100.0,
            divisions: 100,
            label: _currentSliderValue.toInt().toString(),

            onChanged: (double value){
            setState(() {
              _currentSliderValue=value.toInt();
            });
            })
      ],
    );
}
}
