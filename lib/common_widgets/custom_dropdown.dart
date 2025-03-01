import 'package:db_billmate/common_widgets/custom_text_field.dart';
import 'package:db_billmate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchableDropdown<T> extends HookWidget {
  final double? height;
  final double? width;
  final List<T>? items;
  final Future<List<T>> Function()? asyncValues;
  final T? initialValue;
  final ValueChanged<T?> onChanged;
  final String? labelText; // Added labelText parameter
  final String? hint; // Hint text for dropdown
  final String? Function(T?)? validator;
  final String Function(T)? itemAsString;

  const SearchableDropdown({
    super.key,
    this.height,
    this.width,
    this.items,
    this.asyncValues,
    required this.onChanged,
    this.initialValue,
    this.labelText,
    this.hint,
    this.validator,
    required this.itemAsString,
  });

  @override
  Widget build(BuildContext context) {
    final selectedValue = useState<T?>(initialValue);
    final dropdownItems = useState<List<T>?>(items?.toList());
    final originalItems = useState<List<T>?>(items?.toList());
    final isLoading = useState(false);
    final searchController = useTextEditingController();
    final searchFocus = useFocusNode();

    Future<void> loadAsyncValues() async {
      if (asyncValues != null) {
        isLoading.value = true;
        final fetchedItems = await asyncValues!();
        originalItems.value = fetchedItems;
        dropdownItems.value = fetchedItems;
        isLoading.value = false;
      }
    }

    return FormField<T>(
      validator: (value) => validator?.call(value),
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (labelText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  labelText!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
              ),
            GestureDetector(
              onTap: () async {
                await loadAsyncValues();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    searchFocus.requestFocus();
                    return Dialog(
                      backgroundColor: whiteColor,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 400,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomTextField(
                                    width: 250,
                                    height: 45,
                                    controller: searchController,
                                    focusNode: searchFocus,
                                    hintText: "Search..",
                                    onChanged: (p0) {
                                      dropdownItems.value = originalItems.value!
                                          .where((item) => itemAsString!(item)
                                              .toLowerCase()
                                              .contains(p0.toLowerCase()))
                                          .toList();
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ValueListenableBuilder<List<T>?>(
                                    valueListenable: dropdownItems,
                                    builder: (context, currentItems, child) {
                                      if (isLoading.value) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (currentItems == null ||
                                          currentItems.isEmpty) {
                                        return const Center(
                                            child: Text("No items found"));
                                      }
                                      return ListView.builder(
                                        itemCount: currentItems.length,
                                        itemBuilder: (context, index) {
                                          final item = currentItems[index];
                                          return ListTile(
                                            title: Text(itemAsString!(item)),
                                            onTap: () {
                                              selectedValue.value = item;
                                              onChanged(item);
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: height ?? 45,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: state.hasError
                        ? Colors.red
                        : ColorCode.colorList(context).borderColor!,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedValue.value != null
                          ? itemAsString!(selectedValue.value!)
                          : hint ?? "Select an item",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: selectedValue.value == null ? 16 : null,
                            fontWeight: selectedValue.value == null
                                ? FontWeight.w400
                                : null,
                            color: selectedValue.value == null
                                ? const Color(0xffA8B1BE)
                                : Colors.black,
                          ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
