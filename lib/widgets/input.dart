import 'package:flutter/material.dart';
import 'package:untitled/utils/config.dart';

Container inputPassword(
    BuildContext context, {
      String? label,
      required TextEditingController controller,
      required String hintText,
      required bool isHide,
      required Function changeHide,
    }) {
  return Container(
    child: Column(
      children: [
        label != null
            ? Container(
          margin: EdgeInsets.only(
            left: getWidth(16),
            right: getWidth(16),
          ),
          width: double.infinity,
          child: Text(label,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        )
            : Container(),
        label != null
            ? SizedBox(
          height: getHeight(6),
        )
            : Container(),
        Container(
          height: getWidth(48),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getHeight(6)),
            border: Border.all(
              color: const Color(0xFFE6E6E6),
              width: getHeight(1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                    style: TextStyle(fontSize: getWidth(14)),
                    controller: controller,
                    obscureText: isHide,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: hintText,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(
                          left: getWidth(18), bottom: getHeight(14)),
                      labelStyle: TextStyle(
                          color: const Color(0xFF9E9E9E), fontSize: getWidth(14)),
                    )),
              ),
              IconButton(
                  onPressed: () {
                    changeHide();
                  },
                  icon: Icon(
                    isHide ? Icons.visibility_off : Icons.visibility,
                    size: 16,
                  ))
            ],
          ),
        )
      ],
    ),
  );
}

Container inputRegular(BuildContext context,
    {String? label,
      required String hintText,
      required TextEditingController textEditingController,
      bool? enabled = true,
      double height = 48,
      double width = 0,
      int maxLines = 1}) {
  return Container(
    width: width == 0 ? null : getWidth(width),
    child: Column(
      children: [
        label != null
            ? Container(
          margin: EdgeInsets.only(
            left: getWidth(16),
            right: getWidth(16),
          ),
          width: double.infinity,
          child: Text(label,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        )
            : Container(),
        label != null
            ? SizedBox(
          height: getHeight(6),
        )
            : Container(),
        Container(
          height: getHeight(height),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              getHeight(6),
            ),
            border: Border.all(
              color: const Color(0xFFe6e6e6),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: maxLines,
                  enabled: enabled,
                  controller: textEditingController,
                  style: TextStyle(fontSize: getWidth(14)),
                  style: TextStyle(
                    fontSize: getWidth(16),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    labelText: hintText,
                    contentPadding: EdgeInsets.only(
                      left: getWidth(18),
                      bottom: getHeight(14),
                    ),
                    labelStyle: TextStyle(
                        color: const Color(0xFF9E9E9E), fontSize: getWidth(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container inputSearch(
    BuildContext context, {
      required String hintText,
      required TextEditingController textEditingController,
      required dynamic onSearch,
      required List<String> options,
    }) {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _autocompleteKey = GlobalKey();
  return Container(
    margin: EdgeInsets.only(
      right: getWidth(10),
      left: getWidth(10),
      top: getHeight(5),
    ),
    child: Column(
      children: [
        // Row(
        //   children: [
        //     Expanded(
        //       child: TextFormField(
        //         focusNode: _focusNode,
        //         controller: textEditingController,
        //         style: TextStyle(fontSize: getWidth(12)),
        //         onEditingComplete: () {
        //           FocusScope.of(context).unfocus();
        //           onSearch();
        //         },
        //         decoration: InputDecoration(
        //           isCollapsed: true,
        //           border: InputBorder.none,
        //           focusedBorder: InputBorder.none,
        //           enabledBorder: InputBorder.none,
        //           errorBorder: InputBorder.none,
        //           disabledBorder: InputBorder.none,
        //           hintText: hintText,
        //           contentPadding: EdgeInsets.only(
        //             right: getWidth(16),
        //           ),
        //           labelStyle: TextStyle(
        //               color: Color(0xFF878C92), fontSize: getWidth(16)),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        Row(
          children: [
            Expanded(
              child: RawAutocomplete<String>(
                key: _autocompleteKey,
                focusNode: _focusNode,
                textEditingController: textEditingController,
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    focusNode: _focusNode,
                    controller: textEditingController,
                    style: TextStyle(fontSize: getWidth(12)),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      onSearch();
                    },
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: hintText,
                      contentPadding: EdgeInsets.only(
                        right: getWidth(16),
                      ),
                      labelStyle: TextStyle(
                          color: Color(0xFF878C92), fontSize: getWidth(16)),
                    ),
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  return Material(
                    elevation: 4.0,
                    child: ListView(
                      children: options
                          .map((String option) => GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(option),
                        ),
                      ))
                          .toList(),
                    ),
                  );
                },
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return options.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  }).toList();
                },
              ),
            )
          ],
        )
      ],
    ),
  );
}

Container inputWithHint(BuildContext context,
    {required String hintText,
      required String labelText,
      required String initialText,
      required TextEditingController textEditingController,
      required bool err,
      Function? onchange}) {
  return Container(
    height: getWidth(56),
    padding: EdgeInsets.symmetric(vertical: getHeight(5)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(getHeight(4)),
      border: Border.all(
        color: err ? Colors.red : Color(0xFFE7E8EA),
        width: getHeight(1),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            onChanged: (e) {
              onchange == null ? null : onchange();
            },
            controller: textEditingController,
            style: TextStyle(fontSize: getWidth(16)),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelText: labelText,
              hintText: hintText,
              contentPadding:
              EdgeInsets.only(left: getWidth(16), right: getWidth(16)),
              labelStyle:
              TextStyle(color: Color(0xFF878C92), fontSize: getWidth(16)),
            ),
          ),
        ),
      ],
    ),
  );
}

Container inputSignup(BuildContext context,
    {required String hintText,
      required TextEditingController textEditingController,
      required bool focus,
      required bool err}) {
  return Container(
    height: getWidth(56),
    padding: EdgeInsets.symmetric(vertical: getHeight(5)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(getHeight(4)),
      border: Border.all(
        color: err
            ? Colors.red
            : focus
            ? Color(0xFF61B3FF)
            : Color(0xFFE7E8EA),
        width: getHeight(1),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            style: TextStyle(fontSize: getWidth(16)),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelText: hintText,
              contentPadding:
              EdgeInsets.only(left: getWidth(16), right: getWidth(16)),
              labelStyle:
              TextStyle(color: Color(0xFF878C92), fontSize: getWidth(16)),
            ),
          ),
        ),
      ],
    ),
  );
}

Container inputPasswordSignup(
    BuildContext context,
    TextEditingController controller,
    String hintText,
    bool isHide,
    Function changeHide,
    bool focus,
    bool err,
    {Function? onchange}) {
  return Container(
    height: getWidth(56),
    padding: EdgeInsets.symmetric(vertical: getHeight(5)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(getHeight(4)),
      border: Border.all(
        color: err
            ? Colors.red
            : focus
            ? Color(0xFF61B3FF)
            : Color(0xFFE7E8EA),
        width: getHeight(1),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
              onChanged: (e) {
                onchange != null ? onchange() : null;
              },
              style: TextStyle(fontSize: getWidth(16)),
              controller: controller,
              obscureText: isHide,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                labelText: hintText,
                contentPadding: EdgeInsets.only(left: getWidth(16)),
                labelStyle:
                TextStyle(color: Color(0xFF878C92), fontSize: getWidth(16)),
              )),
        ),
        IconButton(
            onPressed: () {
              changeHide();
            },
            icon: Icon(
              isHide ? Icons.visibility_off : Icons.visibility,
              size: 24,
            ))
      ],
    ),
  );
}

Container inputOnChange(BuildContext context,
    {required String hintText,
      required TextEditingController textEditingController,
      required Function function}) {
  return Container(
    height: getWidth(56),
    padding: EdgeInsets.symmetric(vertical: getHeight(5)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(getHeight(4)),
      border: Border.all(
        color: Color(0xFFE7E8EA),
        width: getHeight(1),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            onChanged: (text) => {function()},
            controller: textEditingController,
            style: TextStyle(fontSize: getWidth(16)),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelText: hintText,
              contentPadding:
              EdgeInsets.only(left: getWidth(16), right: getWidth(16)),
              labelStyle:
              TextStyle(color: Color(0xFF878C92), fontSize: getWidth(16)),
            ),
          ),
        ),
      ],
    ),
  );
}