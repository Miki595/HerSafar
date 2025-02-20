import 'user_signup_data.dart';

class DriverSignupData extends UserSignupData {
  String? vehicleImage;
  String? vehicleCategory;
  String? vehicleModel;
  String? vehicleNumberPlate;
  String? licensePicture;
  String? carRegistrationFront;
  String? carRegistrationBack;

  DriverSignupData({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? cnicFront,
    String? cnicBack,
    String? city,
    String? district,
    String password = '',
    required String userType, // Must be "Driver"
    this.vehicleImage,
    this.vehicleCategory,
    this.vehicleModel,
    this.vehicleNumberPlate,
    this.licensePicture,
    this.carRegistrationFront,
    this.carRegistrationBack,
  }) : super(
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          cnicFront: cnicFront,
          cnicBack: cnicBack,
          city: city,
          district: district,
          password: password,
          userType: userType,
        );

  // Convert to JSON for API submission
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data.addAll({
      'vehicleImage': vehicleImage,
      'vehicleCategory': vehicleCategory,
      'vehicleModelName': vehicleModel,
      'vehicleNumberPlate': vehicleNumberPlate,
      'licensePicture': licensePicture,
      'carRegistrationFront': carRegistrationFront,
      'carRegistrationBack': carRegistrationBack,
    });
    return data;
  }

  // Step 3: Validate Driver Documents Upload
  bool validateDriverDocuments() {
    print("🚀 Running Driver Documents Validation...");
    if (vehicleImage == null || vehicleImage!.isEmpty) {
      print("❌ Missing: Vehicle Image");
      return false;
    }
    if (licensePicture == null || licensePicture!.isEmpty) {
      print("❌ Missing: License Picture");
      return false;
    }
    if (carRegistrationFront == null || carRegistrationFront!.isEmpty) {
      print("❌ Missing: Car Registration Front");
      return false;
    }
    if (carRegistrationBack == null || carRegistrationBack!.isEmpty) {
      print("❌ Missing: Car Registration Back");
      return false;
    }
    print("✅ Driver Documents Validation Passed!");
    return true;
  }

  // Step 4: Validate Vehicle Information
  bool validateVehicleInfo() {
    print("🚀 Running Vehicle Information Validation...");
    if (vehicleCategory == null || vehicleCategory!.isEmpty) {
      print("❌ Missing: Vehicle Category");
      return false;
    }
    if (vehicleModel == null || vehicleModel!.isEmpty) {
      print("❌ Missing: Vehicle Model Name");
      return false;
    }
    if (vehicleNumberPlate == null || vehicleNumberPlate!.isEmpty) {
      print("❌ Missing: Vehicle Number Plate");
      return false;
    }
    print("✅ Vehicle Information Validation Passed!");
    return true;
  }

  // Step 5: Validate Final Step Before OTP
  @override
  bool validateFinal() {
    print("🚀 Running DriverSignupData final validation...");

    // Validate base user signup and CNIC upload
    if (!super.validateSignup() || !super.validateCNICUpload()) {
      print("❌ Signup or CNIC validation failed!");
      return false;
    }

    // Validate driver documents and vehicle info
    if (!validateDriverDocuments() || !validateVehicleInfo()) {
      print("❌ Driver documents or vehicle info validation failed!");
      return false;
    }

    // ✅ Skip password validation if we are before the password setup step
    if (password.isEmpty) {
      print("⚠️ Skipping password validation since it's not required yet.");
      return true;
    }

    // Validate password only when it's required
    if (!validatePassword()) {
      print("❌ Missing: Password");
      return false;
    }

    print("✅ DriverSignupData validation passed!");
    return true;
  }
}
