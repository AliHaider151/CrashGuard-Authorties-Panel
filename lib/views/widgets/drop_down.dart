import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';

class CustomDropDown<T> extends StatefulWidget {
  final T? selectedLable;
  final String? label;
  final List<T> items;
  final Function(T) onChanged;
  final double? width;
  final bool isLoading;
  final Widget Function(BuildContext, T)? itemBuilder;
  final Widget? prefix;

  const CustomDropDown({
    super.key,
    this.selectedLable,
    required this.items,
    required this.onChanged,
    this.width,
    this.label,
    this.isLoading = false,
    this.itemBuilder,
    this.prefix,
  });

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedLable;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 45,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),

        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: widget.isLoading
          ? const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 4),
              ),
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton2<T>(
                customButton: Row(
                  children: [
                    if (widget.prefix != null) ...[8.width, widget.prefix!],
                    10.width,
                    Expanded(
                      child: selectedValue != null && widget.itemBuilder != null
                          ? widget.itemBuilder!(context, selectedValue!)
                          : Text(
                              selectedValue?.toString() ?? (widget.label ?? ""),
                              style: textTheme.bodySmall!.copyWith(
                                color: selectedValue == null
                                    ? Colors.black26
                                    : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                    5.width,
                  ],
                ),
                value: widget.items.contains(selectedValue)
                    ? selectedValue
                    : null,
                hint: Text(
                  widget.label ?? "",
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                isExpanded: true,

                items: widget.items.map((T item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: widget.itemBuilder != null
                        ? widget.itemBuilder!(context, item)
                        : Text(
                            item.toString(),
                            style: textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  );
                }).toList(),
                onChanged: widget.isLoading
                    ? null
                    : (T? value) {
                        if (value != null) {
                          setState(() {
                            selectedValue = value;
                          });
                          widget.onChanged(value);
                        }
                      },

                buttonStyleData: ButtonStyleData(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 56,
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  elevation: 4,
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: WidgetStateProperty.all(6),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
    );
  }
}

class MultiSelectDropDown<T> extends StatefulWidget {
  final String header;
  final String? label;
  final List<T> items;
  final List<T> initialSelected;
  final double? width;
  final bool isLoading;
  final Widget Function(BuildContext, T)? itemBuilder;
  final ValueChanged<List<T>> onChanged;

  const MultiSelectDropDown({
    super.key,
    required this.header,
    required this.items,
    required this.onChanged,
    this.initialSelected = const [],
    this.label,
    this.width,
    this.isLoading = false,
    this.itemBuilder,
  });

  @override
  State<MultiSelectDropDown<T>> createState() => _MultiSelectDropDownState<T>();
}

class _MultiSelectDropDownState<T> extends State<MultiSelectDropDown<T>> {
  late List<T> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = List<T>.from(widget.initialSelected);
  }

  void toggleSelectAll() {
    setState(() {
      if (selectedItems.length == widget.items.length) {
        selectedItems.clear();
      } else {
        selectedItems = List<T>.from(widget.items);
      }
    });
    widget.onChanged(selectedItems);
  }

  void toggleItem(T item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
    widget.onChanged(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.header.isNotEmpty)
          Text(
            widget.header,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        if (widget.header.isNotEmpty) const SizedBox(height: 4),
        Container(
          height: 43,
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: widget.isLoading
              ? const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : DropdownButtonHideUnderline(
                  child: DropdownButton2<T>(
                    hint: Text(
                      selectedItems.isEmpty
                          ? (widget.label ?? widget.header)
                          : "${selectedItems.length} selected",
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    isExpanded: true,
                    // 🟢 Build all menu items
                    items: [
                      ...List.generate(widget.items.length + 1, (index) {
                        final item = index == 0
                            ? null
                            : widget.items[index - 1];

                        return DropdownMenuItem<T>(
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, innerSetState) {
                              final bool isChecked = index == 0
                                  ? selectedItems.length == widget.items.length
                                  : selectedItems.contains(item);

                              return InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  if (index == 0) {
                                    // ✅ Close dropdown on Select All
                                    toggleSelectAll();
                                    Navigator.pop(context);
                                  } else {
                                    // ✅ Keep dropdown open
                                    toggleItem(item!);
                                    innerSetState(
                                      () {},
                                    ); // refresh this checkbox
                                  }
                                },
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: .8,
                                      child: Checkbox(
                                        value: isChecked,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        onChanged: (_) {
                                          if (index == 0) {
                                            toggleSelectAll();
                                            Navigator.pop(context);
                                          } else {
                                            toggleItem(item!);
                                            innerSetState(() {});
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: index == 0
                                          ? const Text("Select All")
                                          : (widget.itemBuilder?.call(
                                                  context,
                                                  item!,
                                                ) ??
                                                Text(
                                                  item.toString(),
                                                  style: textTheme.bodySmall
                                                      ?.copyWith(fontSize: 12),
                                                )),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                    onChanged: (_) {},
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                      iconSize: 20,
                    ),
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 56,
                      width: widget.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.transparent,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      elevation: 4,
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: WidgetStateProperty.all(6),
                        thumbVisibility: WidgetStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
