import 'package:flutter/material.dart';

class AnalogLimitCard extends StatefulWidget{
  final String? title;
  final IconData? icon;
  final Color? titleColor;
  final bool isExpended;
  final Function(bool)? onExpansionChanged;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onUpdatePressedMaxMin;
  final VoidCallback? onUpdatePressedMulti;
  final TextEditingController minController;
  final TextEditingController maxController;
  final TextEditingController multiController;

  const AnalogLimitCard({
    Key? key,
    this.title,
    this.icon,
    this.titleColor,
    required this.isExpended,
    this.onExpansionChanged,
    required this.switchValue,
    this.onSwitchChanged,
    required this.onUpdatePressedMaxMin,
    required this.onUpdatePressedMulti,
    required this.minController,
    required this.maxController,
    required this.multiController
}) : super(key: key);

  @override
  State<AnalogLimitCard> createState() => _AnalogLimitCardState();
}

class _AnalogLimitCardState extends State<AnalogLimitCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.grey.shade100,
      child: Padding(padding: EdgeInsets.all(8.0),
      child: ExpansionTile(
          key: UniqueKey(),
          initiallyExpanded: widget.isExpended,
          onExpansionChanged: widget.onExpansionChanged,
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shape: RoundedRectangleBorder(side: BorderSide.none),
          iconColor: Colors.grey.shade600,
          title: Text(widget.title! , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: widget.titleColor),),
          leading: Icon(widget.icon),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "Status",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),),
                Switch(
                  value: widget.switchValue,
                  onChanged: (value) async{
                    bool confirm = await _showConfirmationDialog(context, "Are you sure you want turn ${value ? 'On' : 'Off'}");
                        if(confirm && widget.onSwitchChanged != null){
                          widget.onSwitchChanged!(value);
                        }
                  },
                  thumbColor: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xff024a06);
                      }
                      return Colors.grey.shade400;
                    },
                  ),
                  trackColor: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xff024a06).withOpacity(0.4);
                      }
                      return Colors.grey.shade300;
                    },
                  ),
                ),

              ],
            ),
            const Divider(height: 4,),
            _buildTextField("Minimum", widget.minController, (value){} ),
            _buildTextField("Maximum", widget.maxController, (value){}),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff024a06),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: widget.onUpdatePressedMaxMin,
                child: Text("Update"),
              ),
            ),
            _buildTextField("Multiplier", widget.multiController, (value){}),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff024a06),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: widget.onUpdatePressedMulti,
                child: Text("Update"),
              ),
            ),
          ],

      ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Change"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Cancel", style: TextStyle(color: Colors.black),),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff024a06), foregroundColor: Colors.white),
              child: const Text("Confirm"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    ) ??
        false;
  }

  ///text-field helper
  Widget _buildTextField(String label, TextEditingController? textController, onFieldSubmitted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        TextFormField(
          controller: textController,
          keyboardType: TextInputType.number,
          onFieldSubmitted: (value) async {
            bool confirm = await _showConfirmationDialog(
              context,
              "Are you sure you want to change $label value to $value?",
            );
            if (confirm) onFieldSubmitted(value);
          },
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    );
  }

}