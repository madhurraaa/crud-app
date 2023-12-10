class Users {
    final int? id;
    final String mobileNumber;
    final String email;
    final String password;
    final String dob;

    Users({
        this.id,
        required this.mobileNumber,
        required this.email,
        required this.password,
        required this.dob,
    });

    factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["id"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        password: json["password"],
        dob: json["dob"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "mobile_number": mobileNumber,
        "email": email,
        "password": password,
        "dob": dob,
    };
}
