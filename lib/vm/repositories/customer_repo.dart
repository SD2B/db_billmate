import 'package:db_billmate/helpers/api_helper/api_service.dart';
import 'package:db_billmate/models/customer_model.dart';

class CustomerRepo {

 static Future<List<CustomerModel>> fetchCustomers() async {
    final data = await ApiService.get('customers');
    return (data as List<dynamic>).map((e) => CustomerModel.fromJson(e)).toList();
  }

  static Future<void> addCustomer(String name, String email, String phone) async {
    await ApiService.post('customers', {'name': name, 'email': email, 'phone': phone});
  }
}
