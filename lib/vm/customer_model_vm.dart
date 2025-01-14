// import 'package:db_billmate/models/customer_model.dart';
// import 'package:db_billmate/models/ui_model.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class CustomerModelVM extends AsyncNotifier<CustomerModel> {
//   @override
//   Future<CustomerModel> build() async {
//     return setToTempModel(CustomerModel());
//   }

//   CustomerModel setToTempModel(CustomerModel model) {
//     state = AsyncValue.data(model);
//     return model;
//   }
// }

// final customerModelVMProvider = AsyncNotifierProvider<CustomerModelVM, List<UiModel>>(CustomerModelVM.new);
