class UserSignupData {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? cnicFront;
  String? cnicBack;
  String? city;
  String? district;
  String password; // Only set at step 6 for Drivers
  String userType; // "Rider" or "Driver"

  UserSignupData({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.cnicFront,
    this.cnicBack,
    this.city,
    this.district,
    this.password = '',
    required this.userType,
  });

  // Convert to JSON for API submission
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'cnicFront': cnicFront,
      'cnicBack': cnicBack,
      'password': password,
      'userType': userType,
      'city': city,
      'district': district,
    };
  }

  // Step 1: Validate Basic Signup Information
  bool validateSignup() {
    print("🚀 Running Signup Validation...");
    if (fullName == null || fullName!.isEmpty) {
      print("❌ Missing: Full Name");
      return false;
    }
    if (email == null || email!.isEmpty) {
      print("❌ Missing: Email");
      return false;
    }
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      print("❌ Missing: Phone Number");
      return false;
    }
    print("✅ Signup Data is valid!");
    return true;
  }

  // Step 2: Validate CNIC Upload
  bool validateCNICUpload() {
    print("🚀 Running CNIC Upload Validation...");
    if (cnicFront == null || cnicFront!.isEmpty) {
      print("❌ Missing: CNIC Front");
      return false;
    }
    if (cnicBack == null || cnicBack!.isEmpty) {
      print("❌ Missing: CNIC Back");
      return false;
    }
    print("✅ CNIC Upload Data is valid!");
    return true;
  }

  // Step 6: Validate Password (Only required at password step)
  bool validatePassword() {
    print("🚀 Running Password Validation...");
    if (password.isEmpty) {
      print("❌ Missing: Password");
      return false;
    }
    print("✅ Password Validation Passed!");
    return true;
  }

  // Final Validation (Before OTP)
  bool validateFinal() {
    print("🚀 Running UserSignupData final validation...");

    if (!validateSignup() || !validateCNICUpload()) {
      print("❌ Signup or CNIC validation failed!");
      return false;
    }

    print("⚠️ Skipping password validation for driver before step 6.");
    return true;
  }
}
