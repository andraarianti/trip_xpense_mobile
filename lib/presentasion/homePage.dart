import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trip_xpense/data/models/staff_model.dart';
import 'package:trip_xpense/presentasion/provider/expense_list_provider.dart';
import 'package:trip_xpense/presentasion/provider/profile_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_provider.dart';
import 'package:trip_xpense/presentasion/provider/trip_waiting_approval_provider.dart';
import 'package:trip_xpense/presentasion/trip/tripDetailPageProvider.dart';

import '../data/models/auth/login_model.dart';
import '../domain/entities/trip_entity.dart';
import '../domain/usecase/trip_usecase.dart';
import 'auth/login.dart';

class HomePage extends StatelessWidget {
  final TripUseCase _tripUseCase = TripUseCase();

  @override
  Widget build(BuildContext context) {
    final Box<LoginResponse> box = Hive.box('loginBox');
    final LoginResponse? staff = box.getAt(0);
    String? username = staff?.username;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false)
          .refreshData(username!);
      Provider.of<TripInProgressProvider>(context, listen: false).refreshData();
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 150,
            child: AppBar(
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
            child: Column(
              children: [
                Card(
                  // child: Consumer<ProfileProvider>(
                  //   builder: (context, provider, child) {
                  //      StaffModel staff = provider.data.single;
                      child:  Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Add an image widget to display an image
                            Image.asset(
                              'assets/images/office.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            // Add some spacing between the image and the text
                            Container(width: 20),
                            // Add an expanded widget to take up the remaining horizontal space
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Add some spacing between the top of the card and the title
                                  Container(height: 5),
                                  // Add a title widget
                                  Text(
                                    "Hello! ${username}",
                                    style: TextStyle(
                                        color: Colors.grey[80],
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Add some spacing between the title and the subtitle
                                  Container(height: 5),
                                  // Add a text widget to display some text
                                  Text(
                                    'It\'s time to take action. Jump in and review those pending trips waiting for your approval. Your timely action keeps the wheels turning smoothly. Let\'s get those trips approved and keep things moving forward!',
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    //   );
                    // },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: _buildCard('Need Approval', _tripListFuture,
                          Color(0xFFFF9B85)), // Ubah warna untuk judul pertama
                    ),
                    Expanded(
                      child: _buildCard(
                          'Approval Finish',
                          _approvedTripListFuture,
                          Color(0xFFAFCBFF)), // Ubah warna untuk judul kedua
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Need Approval',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Expanded(child: Consumer<TripInProgressProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (provider.hasError) {
                      print('Error : ${provider.error}');
                      return Center(child: Text('Error: ${provider.error}'));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 0.8, right: 0.8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.data.length,
                          itemBuilder: (context, index) {
                            final trip = provider.data[index];
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
                                    Text(
                                        '${trip.location} - \$ ${trip.totalCost}'),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TripDetailPageProvider(
                                          trips:
                                              trip), // Melewatkan nilai tripId
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      String title, Future<List<TripEntity>> future, Color color) {
    // Tambahkan parameter color
    return FutureBuilder<List<TripEntity>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final tripList = snapshot.data!;
          int itemCount = tripList.length;
          return Container(
            height: 100,
            width: 190,
            child: Card(
              elevation: 4,
              color: color,
              // Gunakan warna yang diberikan sebagai background card
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        //fontWeight: FontWeight.bold,
                        //color: Colors.white, // Ubah warna teks menjadi putih agar terlihat jelas di atas background card yang berwarna
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$itemCount',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        //color: Colors.white, // Ubah warna teks menjadi putih agar terlihat jelas di atas background card yang berwarna
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<TripEntity>> get _tripListFuture async {
    final tripList = await _tripUseCase.getTripWithoutDrafted();
    return tripList
        .map((tripModel) => _tripUseCase.mapToEntity(tripModel))
        .where((entity) => entity.statusName == 'In Progress')
        .toList(); // Tambahkan method toList() untuk mengonversi hasil menjadi List<TripEntity>
  }

  Future<List<TripEntity>> get _approvedTripListFuture async {
    final tripList = await _tripUseCase.getTripWithoutDrafted();
    return tripList
        .map((tripModel) => _tripUseCase.mapToEntity(tripModel))
        .where((entity) => entity.statusName == 'Approved')
        .toList(); // Tambahkan method toList() untuk mengonversi hasil menjadi List<TripEntity>
  }
}
