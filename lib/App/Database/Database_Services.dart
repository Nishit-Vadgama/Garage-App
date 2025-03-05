import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:nv/App/Model/Vehicle_Model.dart';

import 'Collection_Service.dart';

class DatabaseServices {
  static final DatabaseServices _instance = DatabaseServices._internal();
  DatabaseServices._internal();
  factory DatabaseServices() => _instance;

  static final db = FirebaseFirestore.instance;
  static final Logger logger = Logger();

  /////////////////// ADD VEHICLE //////////////////
  static Future<bool> addVehicle({required Vehicle vehicle}) async {
    try {
      var vehicleRef = CollectionService.VehicleCollection.doc();
      vehicle.vehicleId = vehicleRef.id;
      vehicle.addedOn = Timestamp.now();
      await vehicleRef.set(vehicle.toJson());
      logger.i("ADDED VEHICLE --> ${vehicle.toJson()}");
      return true;
    } catch (e) {
      logger.e("Error while adding vehicle --> $e");
      return false;
    }
  }

  /////////////////// GET ALL VEHICLE //////////////////
  static Stream<List<Vehicle>> getAllVehicles() =>
      CollectionService.VehicleCollection.snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Vehicle.fromJson(doc.data())).toList())
          .handleError(
        (error) {
          logger.e("Error while getting vehicles --> $error");
        },
      );

  /////////////////// GET CURRENT IN  VEHICLE //////////////////
  static Stream<List<Vehicle>> getWorkingVehicles() =>
      CollectionService.VehicleCollection.where('inWorkShop', isEqualTo: true)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Vehicle.fromJson(doc.data())).toList())
          .handleError(
        (error) {
          logger.e("Error while getting workshop vehicles --> $error");
        },
      );
}
