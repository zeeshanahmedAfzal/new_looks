import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:new_looks/screens/admin/admin_screen.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? isError;
  final int? maxLine;
  final EdgeInsetsGeometry? padding;
  final InputBorder? border;
  final Color? focusBorderColor;
  final InputBorder? normalBorder;
  final String? labelText;
  final double? constraintsContMinWidth;
  final double? constraintsContMaxWidth;
  final FontWeight fontWeight;
  final Color? textColor;
  final IconData? suffixIcon;
  final bool? obscureText;
  final bool? isExpandedTextField;
  final bool isConstraintsApplied;
  final Color? iconColor;
  final bool? isLoginScreen;
  final TextInputType? textInputType;
  final Color? cursorColor;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final void Function()? onTap;
  final void Function()? suffixTap;
  final void Function(String)? onChanged;
  final String? Function(String? txt)? validationLogic;
  final double? containerWidth;
  final BorderRadius? borderRadius;
  final double? containerHeight;
  final double? fontSize;
  final Color? floatingLabelStyle;
  final String? errorText;
  final TextStyle? textStyle;
  final double? floatingFontSize;
  final Widget? suffixIconWidget;
  final bool? autoFocus;
  final Color? borderColor;

  CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.fontWeight = FontWeight.w600,
    this.suffixIcon,
    this.iconColor,
    this.obscureText,
    this.onTap,
    this.onChanged,
    this.textInputType,
    this.suffixTap,
    this.containerWidth,
    this.containerHeight,
    this.constraintsContMinWidth,
    this.constraintsContMaxWidth,
    this.textColor,
    this.borderRadius,
    this.fontSize,
    this.isLoginScreen,
    this.floatingLabelStyle,
    this.isConstraintsApplied = true,
    this.errorText,
    this.validationLogic,
    this.labelStyle, this.textStyle,
    this.floatingFontSize, this.isExpandedTextField, this.errorStyle, this.isError = false, this.suffixIconWidget, this.autoFocus, this.border, this.padding, this.focusBorderColor, this.maxLine, this.normalBorder, this.borderColor, this.cursorColor,
  });

  @override
  @override
  Widget build(BuildContext context) {
    var text = controller.text.obs;

    var bdr = OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        borderSide: BorderSide(color: borderColor ?? const Color.fromRGBO(126, 100, 237, 1), width: 1));
    var focusBdr = OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        borderSide: BorderSide(color: focusBorderColor ?? const Color(0xff0f4f84), width: 1));
    var errorBdr = OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        borderSide: BorderSide(color: const Color(0xFF92332d), width: 1));

    return Container(
      height: maxLine != null && maxLine! > 1 ? null : (containerHeight ?? 40),
      width: containerWidth,
      constraints: isConstraintsApplied
          ? BoxConstraints(minWidth: constraintsContMinWidth ?? 0, maxWidth: constraintsContMaxWidth ?? double.infinity)
          : null,
      child: TextFormField(
        style: textStyle,
        maxLines: maxLine != null && maxLine! > 1 ? maxLine : 1,
        minLines: maxLine != null && maxLine! > 1 ? 1 : null,
        expands: isExpandedTextField ?? false,
        autofocus: autoFocus ?? false,
        autocorrect: true,
        obscureText: obscureText ?? false,
        controller: controller,
        onTap: onTap,
        validator: validationLogic,
        keyboardType: textInputType ?? TextInputType.text,
        onChanged: onChanged,
        cursorColor: cursorColor ?? Colors.blue,
        decoration: InputDecoration(
          contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: normalBorder ?? bdr,
          enabledBorder: normalBorder ?? bdr,
          focusedBorder: border ?? focusBdr,
          errorBorder: errorText?.isNotEmpty == true ? errorBdr : null,
          errorText: errorText,
          errorStyle: errorStyle ??
              const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
          isDense: true,
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelStyle ??
              TextStyle(
                fontSize: fontSize ?? 16,
                fontWeight: fontWeight,
                color: textColor ?? const Color(0xFF989898),
              ),
          hintStyle: TextStyle(
            fontSize: fontSize ?? 20,
            fontWeight: fontWeight,
            color: textColor ?? const Color(0xff0f4f84),
          ),
          floatingLabelStyle: TextStyle(
            color: floatingLabelStyle ?? const Color(0xff0f4f84),
            fontSize: floatingFontSize ?? 16,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: suffixIconWidget,
          suffixIconConstraints: const BoxConstraints(maxHeight: 20),
        ),
      ),
    );
  }
}


class MultiColorPickerTextField extends StatefulWidget {
  final String hintText;
  final EdgeInsetsGeometry? padding;
  final bool? isClear;
  final double? containerWidth;
  final BorderRadius? borderRadius;
  final ValueChanged<List<String>>? onColorsChanged;
  final List<Color>? initialColor;

  MultiColorPickerTextField({
    super.key,
    this.hintText = "Select colors...",
    this.padding,
    this.containerWidth,
    this.borderRadius,
    this.onColorsChanged,
    this.initialColor,
    this.isClear,
  });

  @override
  State<MultiColorPickerTextField> createState() =>
      _MultiColorPickerTextFieldState();
}

class _MultiColorPickerTextFieldState extends State<MultiColorPickerTextField> {
  final List<Color> _availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];
  List<Color> _selectedColors = [];
  bool _prevIsClear = false; // Track previous isClear state

  @override
  void initState() {
    super.initState();
    _initializeColors();
  }

  @override
  void didUpdateWidget(covariant MultiColorPickerTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isClear == true && _prevIsClear == false) {
      _clearColors();
    }

    _prevIsClear = widget.isClear ?? false;
  }

  void _initializeColors() {
    if (widget.initialColor?.isNotEmpty == true) {
      setState(() {
        _selectedColors = widget.initialColor ?? [];
      });
    }
  }

  void _clearColors() {
    setState(() {
      _selectedColors.clear();
    });
    widget.onColorsChanged?.call([]);
  }

  void _openColorPickerDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffffffff),
          title: Text("Pick or Add a Color"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 8.0,
                  children: _availableColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(color);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CircleAvatar(
                          backgroundColor: color,
                          radius: 20,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    Color tempColor = Colors.black;
                    Color? newColor = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color(0xffffffff),
                          title: Text("Add a New Color"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ColorPicker(
                                pickerColor: tempColor,
                                onColorChanged: (color) {
                                  tempColor = color;
                                },
                                showLabel: false,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(tempColor);
                              },
                              child: Text("Add"),
                            ),
                          ],
                        );
                      },
                    );

                    if (newColor != null &&
                        !_availableColors.contains(newColor)) {
                      setState(() {
                        _availableColors.add(newColor);
                      });
                    }
                  },
                  child: Text("Add New Color"),
                ),
              ],
            ),
          ),
        );
      },
    ).then((selectedColor) {
      if (selectedColor != null && !_selectedColors.contains(selectedColor)) {
        setState(() {
          _selectedColors.add(selectedColor);
          widget.onColorsChanged?.call(
            _selectedColors.map(colorToHex).toList(),
          );
        });
      }
    });
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openColorPickerDialog,
      child: Container(
        width: widget.containerWidth ?? double.infinity,
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(5),
          border: Border.all(color: Color(0xff000000), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedColors.isNotEmpty)
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _selectedColors.map((color) {
                  return Chip(
                    backgroundColor: color,
                    label: Text(""),
                    onDeleted: () {
                      setState(() {
                        _selectedColors.remove(color);
                      });
                      widget.onColorsChanged?.call(
                        _selectedColors.map(colorToHex).toList(),
                      );
                    },
                  );
                }).toList(),
              ),
            Visibility(
              visible: _selectedColors.isEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.hintText,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class SizeSelectTextField extends StatefulWidget {
  final String hintText;
  final EdgeInsetsGeometry? padding;
  final double? containerWidth;
  final BorderRadius? borderRadius;
  final ValueChanged<List<String>>? onSizesChanged;
  final List<String>? initialSize;
  final bool? isClear;

  const SizeSelectTextField({
    Key? key,
    this.hintText = "Select Size...",
    this.padding,
    this.containerWidth,
    this.borderRadius,
    this.onSizesChanged,
    this.initialSize,
    this.isClear,
  }) : super(key: key);

  @override
  State<SizeSelectTextField> createState() => _SizeSelectTextFieldState();
}

class _SizeSelectTextFieldState extends State<SizeSelectTextField> {
  final List<String> _availableSizes = ["XS", "S", "M", "L", "XL", "XXL", "XXXL"];
  List<String> _selectedSizes = [];
  bool _prevIsClear = false; // Track previous isClear state

  @override
  void initState() {
    super.initState();
    _initializeSizes();
  }

  @override
  void didUpdateWidget(covariant SizeSelectTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isClear == true && _prevIsClear == false) {
      _clearSizes();
    }

    _prevIsClear = widget.isClear ?? false;
  }

  void _initializeSizes() {
    if (widget.initialSize?.isNotEmpty == true) {
      setState(() {
        _selectedSizes = widget.initialSize ?? [];
      });
    }
  }

  void _clearSizes() {
    setState(() {
      _selectedSizes.clear();
    });
    widget.onSizesChanged?.call([]);
  }

  void _openSizePickerDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffffffff),
          title: const Text(
            "Select Size",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _availableSizes.map((size) {
                final isSelected = _selectedSizes.contains(size);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(size);
                  },
                  child: Container(
                    height: 35,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade50 : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade400,
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    ).then((selectedSize) {
      if (selectedSize != null && !_selectedSizes.contains(selectedSize)) {
        setState(() {
          _selectedSizes.add(selectedSize);
          widget.onSizesChanged?.call(_selectedSizes);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openSizePickerDialog,
      child: Container(
        width: widget.containerWidth ?? double.infinity,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(6),
          border: Border.all(color: Color(0xff000000), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedSizes.isNotEmpty)
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: _selectedSizes.map((size) {
                  return Chip(
                    label: Text(
                      size,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.blue.shade50,
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() {
                        _selectedSizes.remove(size);
                        widget.onSizesChanged?.call(_selectedSizes);
                      });
                    },
                  );
                }).toList(),
              ),
            if (_selectedSizes.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  widget.hintText,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class CategorySelectTextField extends StatelessWidget {
  final String hintText;
  final EdgeInsetsGeometry? padding;
  final double? containerWidth;
  final BorderRadius? borderRadius;

  const CategorySelectTextField({
    Key? key,
    this.hintText = "Select Category...",
    this.padding,
    this.containerWidth,
    this.borderRadius,
  }) : super(key: key);

  void _openCategoryPickerDialog(BuildContext context, AdminController controller) {
    showDialog(
      context: context,
      
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffffffff),
          title: const Text(
            "Select Category",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Obx(() {
            if (controller.categories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: controller.categories.map((category) {
                  final isSelected = controller.selectedCategory.value == category;
                  return GestureDetector(
                    onTap: () {
                      controller.selectCategory(category);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade50 : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey.shade400,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    return GestureDetector(
      onTap: () => _openCategoryPickerDialog(context, controller),
      child: Obx(() {
        return Container(
          width: containerWidth ?? double.infinity,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(6),
            border: Border.all(color: const Color(0xff000000), width: 1.0),
          ),
          child: Text(
            controller.selectedCategory.isEmpty ? hintText : controller.selectedCategory.value,
            style: TextStyle(
              color: controller.selectedCategory.isEmpty ? Colors.grey.shade600 : Colors.black,
              fontSize: 14,
            ),
          ),
        );
      }),
    );
  }
}