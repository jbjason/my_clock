import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_scr/alarm_listitem.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_scr/selected_circle_icon.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_scr/top_text_button.dart';
import 'package:provider/provider.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);
  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _isMultiSelect = false, _isAllSelected = false;
  List<MyAlarm> _selectedItem = [];

  void enabledMultiSel() => setState(() {
        _isMultiSelect = !_isMultiSelect;
        _selectedItem = [];
      });

  void addToSelectedItem(MyAlarm myAlarm) {
    if (_isMultiSelect) {
      setState(() {
        if (_selectedItem.contains(myAlarm)) {
          _selectedItem.remove(myAlarm);
        } else {
          _selectedItem.add(myAlarm);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _myAlarms = Provider.of<MyAlarms>(context).items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        TopTextAndAddAlarmButton(
          isMultiSel: _isMultiSelect,
          cancelMultiSel: enabledMultiSel,
          mulSelectedItems: _selectedItem,
        ),
        _isMultiSelect
            ? InkWell(
                onTap: () {
                  setState(() {
                    _isAllSelected = !_isAllSelected;
                    if (_isAllSelected) {
                      _selectedItem = [];
                      _selectedItem = [..._myAlarms];
                    } else {
                      _selectedItem = [];
                    }
                  });
                },
                child: Container(
                  height: 30,
                  padding:const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    children: [
                      SelectedCirleIcon(
                          isMultiSel: _isMultiSelect,
                          isSelected: _isAllSelected),
                      const SizedBox(width: 15),
                      const Text('All',style: TextStyle(fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: ListView.builder(
            itemCount: _myAlarms.length,
            itemBuilder: (context, index) {
              final _isSelected = _selectedItem.contains(_myAlarms[index]);
              return AlarmListItem(
                myAlarm: _myAlarms[index],
                enabledMultiSel: enabledMultiSel,
                addToSelectedItem: addToSelectedItem,
                isSelected: _isSelected,
                isMultiSel: _isMultiSelect,
              );
            },
          ),
        ),
      ],
    );
  }
}
