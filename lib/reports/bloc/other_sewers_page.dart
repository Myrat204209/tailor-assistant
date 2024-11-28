// import 'package:flutter_bloc/flutter_bloc.dart';

// class SewersPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Select Employee')),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               // Select an employee
//               context.read<ReportBloc>().add(EmployeeSelected(
//                 employeeCode: 'EMP021301',
//                 employeeName: 'Аида',
//               ));
//             },
//             child: Text('Select Employee'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Select a product
//               Product selectedProduct = Product(
//                 itemCode: 'ITEM123', 
//                 itemName: 'Sample Item',
//                 docNumber: 'DOC001',
//               );
//               context.read<ReportBloc>().add(ProductSelected(product: selectedProduct));
//             },
//             child: Text('Select Product'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Select an operation
//               Operation selectedOperation = Operation(
//                 workCode: 'WORK001', 
//                 workName: 'Sample Work',
//                 workPrice: 10.0,
//               );
//               context.read<ReportBloc>().add(OperationSelected(operation: selectedOperation));
//             },
//             child: Text('Select Operation'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Add quantity to operation
//               context.read<ReportBloc>().add(QuantityAdded(workCode: 'WORK001', quantity: 5));
//             },
//             child: Text('Add Quantity'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Save Report
//               context.read<ReportBloc>().add(SaveReport());
//             },
//             child: Text('Save Report'),
//           ),
//           BlocBuilder<ReportBloc, ReportState>(
//             builder: (context, state) {
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: state.reportItems.length,
//                 itemBuilder: (context, index) {
//                   final item = state.reportItems[index];
//                   return ListTile(
//                     title: Text(item.employeeName),
//                     subtitle: Text(item.itemName),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
