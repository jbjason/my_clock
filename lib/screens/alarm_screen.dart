import 'package:flutter/material.dart';
import 'package:my_clock/models/my_alarms.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/alarm_listitem.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/all_selection_text.dart';
import 'package:my_clock/widgets/alarm_widgets/alarm_home/top_text_button.dart';
import 'package:provider/provider.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);
  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _isMultiSelect = false, _isAllSelected = false;
  List<MyAlarm> _selectedItem = [];

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
        _allSelcectionText(_myAlarms),
        _listViewBuilder(_myAlarms),
      ],
    );
  }

  Widget _listViewBuilder(List<MyAlarm> _myAlarms) {
    return Expanded(
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
    );
  }

  Widget _allSelcectionText(List<MyAlarm> _myAlarms) {
    // showing all selected text after MultiSelected activated
    return _isMultiSelect
        ? AllSelectionText(
            isMultiSelect: _isMultiSelect,
            isAllSelected: _isAllSelected,
            onTap: () {
              _isAllSelected = !_isAllSelected;
              if (_isAllSelected) {
                _selectedItem = [];
                _selectedItem = [..._myAlarms];
              } else {
                _selectedItem = [];
              }
              setState(() {});
            },
          )
        : Container();
  }

  void enabledMultiSel() {
    _isMultiSelect = !_isMultiSelect;
    _selectedItem = [];
    setState(() {});
  }

  void addToSelectedItem(MyAlarm myAlarm) {
    if (_isMultiSelect) {
      if (_selectedItem.contains(myAlarm)) {
        _selectedItem.remove(myAlarm);
      } else {
        _selectedItem.add(myAlarm);
      }
      setState(() {});
    }
  }
}
