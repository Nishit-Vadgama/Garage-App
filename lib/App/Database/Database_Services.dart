import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../Model/Service_Model.dart';
import '../Model/Vehicle_Model.dart';
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
      await vehicleRef.set(vehicle.toJson());
      logger.i("ADDED VEHICLE --> ${vehicle.toJson()}");
      return true;
    } catch (e) {
      logger.e("Error while adding vehicle --> $e");
      return false;
    }
  }

  /////////////////// UPDATE VEHICLE //////////////////
  static Future<bool> updateVehicle({required Vehicle vehicle}) async {
    try {
      await CollectionService.VehicleCollection.doc(vehicle.vehicleId)
          .update(vehicle.toJson());
      logger.i("UPDATED VEHICLE --> ${vehicle.toJson()}");
      return true;
    } catch (e) {
      logger.e("Error while updating vehicle --> $e");
      return false;
    }
  }

  /////////////////// GET VEHICLE BY ID //////////////////
  static Future<Vehicle> getVehicleByVehicleId(
      {required String vehicleId}) async {
    try {
      var vehicleRef = CollectionService.VehicleCollection.doc(vehicleId);
      var vehicleDoc = await vehicleRef.get();
      if (vehicleDoc.exists) {
        var vehicle = Vehicle.fromJson(vehicleDoc.data()!);
        logger.i("Retrieved VEHICLE --> $vehicle");
        return vehicle;
      } else {
        logger.e("Vehicle not found with id --> $vehicleId");
        return Vehicle();
      }
    } catch (e) {
      logger.e("Error while getting vehicle by id --> $e");
      return Vehicle();
    }
  }

  /////////////////// GET ALL VEHICLE //////////////////
  static Future<List<Vehicle>> getAllVehicles() async {
    try {
      var all = await CollectionService.VehicleCollection.get();
      List<Vehicle> allVehicles =
          all.docs.map((vehicle) => Vehicle.fromJson(vehicle.data())).toList();
      return allVehicles;
    } catch (error) {
      logger.e("Error while getting all vehicles --> $error");
      return [];
    }
  }

  /////////////////// GET IN WORKING IN VEHICLE //////////////////
  // static Stream<List<Vehicle>> getWorkingVehicles() =>
  //     CollectionService.VehicleCollection.where('inWorkShop', isEqualTo: true)
  //         .snapshots()
  //         .map((snapshot) =>
  //             snapshot.docs.map((doc) => Vehicle.fromJson(doc.data())).toList())
  //         .handleError(
  //       (error) {
  //         logger.e("Error while getting workshop vehicles --> $error");
  //       },
  //     );

  static Future<List<Vehicle>> getWorkingVehicles() async {
    try {
      var allVehiclesSnapshot = await CollectionService.VehicleCollection.get();
      List<Vehicle> workingVehicles = [];

      for (var vehicleDoc in allVehiclesSnapshot.docs) {
        var servicesSnapshot =
            await vehicleDoc.reference.collection("Services").get();

        bool hasPendingService = servicesSnapshot.docs.any((serviceDoc) {
          var data = serviceDoc.data();
          return data["isDone"] == false;
        });

        if (hasPendingService) {
          workingVehicles.add(Vehicle.fromJson(vehicleDoc.data()));
        }
      }

      return workingVehicles;
    } catch (error) {
      logger.e("Error while getting working vehicles --> $error");
      return [];
    }
  }

  /////////////////// GET SERVICES OF VEHICLE //////////////////
  static Future<List<Service>> getVehicleServices(
      {required String vehicleId}) async {
    try {
      var services = await CollectionService.VehicleCollection.doc(vehicleId)
          .collection("Services")
          .get();

      print("ALL SERVICES --> $services");

      // Correct mapping of documents
      List<Service> myList =
          services.docs.map((doc) => Service.fromJson(doc.data())).toList();

      print("SERVICES --> $myList");
      return myList;
    } catch (error) {
      logger.e("Error while getting vehicles Services --> $error");
      return [];
    }
  }

  static Future<bool> isRunningService({required String vehicleId}) async {
    try {
      // Correct mapping of documents
      List<Service> myList = await getVehicleServices(vehicleId: vehicleId);
      bool isRunning = myList.any((service) => service.isDone == false);
      return isRunning;
    } catch (error) {
      logger.e("Error while getting vehicles Services --> $error");
      return false;
    }
  }

  static Future<bool> addOrUpdateVehicleService({
    required String vehicleId,
    required Service service,
  }) async {
    try {
      final serviceRef = CollectionService.VehicleCollection.doc(vehicleId)
          .collection("Services")
          .doc(service.serviceId!.isEmpty ? null : service.serviceId);

      if (service.serviceId!.isEmpty) {
        service.serviceId = serviceRef.id;
      }

      await serviceRef.set(service.toJson(), SetOptions(merge: true));
      return true;
    } catch (error) {
      logger.e("Error while addOrUpdateVehicleService --> $error");
      return false;
    }
  }
}
