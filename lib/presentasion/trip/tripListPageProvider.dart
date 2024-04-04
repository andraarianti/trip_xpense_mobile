import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_waiting_approval_provider.dart';
import 'package:trip_xpense/presentasion/trip/tripDetailPage.dart';
import 'package:trip_xpense/presentasion/trip/tripDetailPageProvider.dart';

import '../provider/toggle_button_provider.dart';
import '../provider/trip_provider.dart';

// class TripPageProvider extends StatelessWidget {
//   const TripPageProvider({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<TripProvider>(context, listen: false).refreshData();
//     });
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFFD0B3FF),
//                 Color(0xFFAFCBFF), // Lighter version of Colors.lightBlue
//                 Color(0xFFD7F9FF), // Lighter version of Colors.lightBlue
//               ],
//             ),
//           ),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.airplane_ticket_rounded,
//               color: Colors.white,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Trip Xpense',
//               style: TextStyle(
//                 fontSize: 24, // Adjust the font size as needed
//                 fontWeight: FontWeight.bold, // Make the text bold
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer<TripProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (provider.hasError) {
//             print('Error : ${provider.error}');
//             return Center(child: Text('Error: ${provider.error}'));
//           } else {
//             List<bool> isSelected = [false, false];
//             return Column(
//               children: [
//                 SizedBox(height: 10,),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: provider.data.length,
//                       itemBuilder: (context, index) {
//                         final trip = provider.data[index];
//                         print('Data Trip : ${provider.data[1]}');
//                         return Card(
//                           child: ListTile(
//                             title: Text(
//                               'ID: ${trip.tripId} - Status: ${trip.statusName}',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Staff Name: ${trip.staffName}'),
//                                 Text('${trip.location} - \$ ${trip.totalCost}'),
//                               ],
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => TripDetailPageProvider(trips: trip), // Melewatkan nilai tripId
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }


class TripPageProvider extends StatelessWidget {
  const TripPageProvider({Key? key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<TripProvider>(context, listen: false).loadData('In Progress');
      Provider.of<TripInProgressProvider>(context, listen: false).refreshData();
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFD0B3FF),
                Color(0xFFAFCBFF), // Lighter version of Colors.lightBlue
                Color(0xFFD7F9FF), // Lighter version of Colors.lightBlue
              ],
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.airplane_ticket_rounded,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Trip Xpense',
              style: TextStyle(
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make the text bold
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Consumer<TripProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.hasError) {
            print('Error : ${provider.error}');
            return Center(child: Text('Error: ${provider.error}'));
          } else {
            return ChangeNotifierProvider(
              create: (context) => ToggleButtonProvider(), // Tidak memerlukan argumen
              child: ToggleButtonsAndListView(),
            );
          }
        },
      ),
    );
  }
}

class ToggleButtonsAndListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toggleButtonProvider = Provider.of<ToggleButtonProvider>(context);
    final provider = Provider.of<TripProvider>(context);
    final providerTrip = Provider.of<TripInProgressProvider>(context);
    List<bool> isSelected = [
      toggleButtonProvider.isSelected1,
      toggleButtonProvider.isSelected2
    ];

    return Column(
      children: [
        SizedBox(height: 10),
        ToggleButtons(
          isSelected: isSelected,
          constraints: BoxConstraints.expand(width: 120, height: 50),
          selectedColor: Colors.white,
          // text color of not selected toggle
          color: Colors.blue[200],
          // fill color of selected toggle
          fillColor: Colors.purple.shade100,
          // when pressed, splash color is seen
          splashColor: Colors.red.shade200,
          // long press to identify highlight color
          highlightColor: Colors.orange.shade200,
          // if consistency is needed for all text style
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          // border properties for each toggle
          renderBorder: true,
          borderColor: Colors.white,
          borderWidth: 1.5,
          borderRadius: BorderRadius.circular(10),
          children: [
            Text('In Progress'),
            Text('Approved'),
          ],
          onPressed: (int index) {
            if (index == 0) {
              Provider.of<ToggleButtonProvider>(context, listen: false).toggleButton1();
              Provider.of<TripInProgressProvider>(context, listen: false).refreshData();
            } else if (index == 1) {
              Provider.of<ToggleButtonProvider>(context, listen: false).toggleButton2();
            }

            // Mendapatkan status yang dipilih berdasarkan indeks tombol yang ditekan
            String selectedStatus = index == 0 ? 'In Progress' : 'Approved';

            print('Selected status: $selectedStatus'); // Tambahkan ini untuk debugging

            // Panggil metode untuk memfilter data berdasarkan status yang dipilih
            Provider.of<TripProvider>(context, listen: false).loadData(selectedStatus);
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provider.data.length,
              itemBuilder: (context, index) {
                final trip = provider.data[index];
                print('Index: $index');
                return Card(
                  child: ListTile(
                    title: Text(
                      'ID: ${trip.tripId} - Status: ${trip.statusName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Staff Name: ${trip.staffName}'),
                        Text('${trip.location} - \$ ${trip.totalCost}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripDetailPageProvider(
                            trips: trip,
                          ), // Melewatkan nilai tripId
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
