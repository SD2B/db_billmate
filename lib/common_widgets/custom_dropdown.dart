import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomDropdown extends HookWidget {
  final List<String> items;
  final String? initialValue;
  final ValueChanged<String?> onChanged;
  final String? hint;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialValue,
    this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final selectedValue = useState<String?>(initialValue);

    return FormField<String>(
      validator: (value) => validator?.call(value),
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: state.hasError ? Colors.red : Colors.transparent,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedValue.value,
                  hint: hint != null
                      ? Text(
                          hint!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xffA8B1BE),
                                  ),
                        )
                      : null,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                            ),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    selectedValue.value = newValue;
                    state.didChange(newValue); // Update FormField state
                    onChanged(newValue); // Notify parent about the change
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: Colors.white,
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
