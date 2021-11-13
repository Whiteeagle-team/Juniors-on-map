import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:juniors_on_map/src/providers/locations_providers.dart';
import 'package:juniors_on_map/src/screens/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController _mapController;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(const CameraPosition(
      target: LatLng(15.334823311129327, 44.19856926684617),
      zoom: 16.5,
    )));
  }

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(15.341364845189633, 44.20385910191321),
    zoom: 20,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.selectANursery),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            }, icon: const Icon(Icons.power_settings_new_rounded))
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: context.watch<MapProvider>().mapType,
              onTap: (argument) {
                context.read<MapProvider>().currentLocation = null;
              },
              initialCameraPosition: initialCameraPosition,
              onMapCreated: onMapCreated,
              markers:
                  Set<Marker>.of(context.watch<MapProvider>().getLocations()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                      icon: const Icon(Icons.map),
                      onPressed: () {
                        context.read<MapProvider>().changMapType;
                      },
                    )),
              ),
            ),
            if (context.watch<MapProvider>().currentLocation != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, 0.2),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                radius: 25,
                              ),
                              title: Text(
                                context
                                    .watch<MapProvider>()
                                    .currentLocation!
                                    .name,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context
                                        .watch<MapProvider>()
                                        .currentLocation!
                                        .info,
                                  ),
                                  const SizedBox(height: 4,),
                                  Text(
                                    context
                                        .watch<MapProvider>()
                                        .currentLocation!
                                        .phone,
                                    style: TextStyle(color: Colors.blue[200]),
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                              trailing: const Icon(Icons.call),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.areYouSure),
          content: Text(AppLocalizations.of(context)!.doYouWantToCloseTheApp),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          ],
        ),
      )) ?? false;
    }
}
