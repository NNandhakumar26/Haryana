import 'dart:convert';

class Person {
  String? name;
  int? age;
  String? gender;
  DateTime? dob;
  String? email;
  int? contact1;
  int? contact2;
  Address? address;
  Person({
    this.name,
    this.age,
    this.gender,
    this.dob,
    this.email,
    this.contact1,
    this.contact2,
    this.address,
  });

  Person copyWith({
    String? name,
    int? age,
    String? gender,
    DateTime? dob,
    String? email,
    int? contact1,
    int? contact2,
    Address? address,
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      contact1: contact1 ?? this.contact1,
      contact2: contact2 ?? this.contact2,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'dob': dob?.millisecondsSinceEpoch,
      'email': email,
      'contact1': contact1,
      'contact2': contact2,
      'address': address?.toMap(),
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['name'],
      age: map['age']?.toInt(),
      gender: map['gender'],
      dob: map['dob'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dob'])
          : null,
      email: map['email'],
      contact1: map['contact1']?.toInt(),
      contact2: map['contact2']?.toInt(),
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(name: $name, age: $age, gender: $gender, dob: $dob, email: $email, contact1: $contact1, contact2: $contact2, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.name == name &&
        other.age == age &&
        other.gender == gender &&
        other.dob == dob &&
        other.email == email &&
        other.contact1 == contact1 &&
        other.contact2 == contact2 &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        dob.hashCode ^
        email.hashCode ^
        contact1.hashCode ^
        contact2.hashCode ^
        address.hashCode;
  }
}

class Address {
  String? streetName;
  String? city;
  String? state;
  String? country;
  int? pincode;
  Address({
    this.streetName,
    this.city,
    this.state,
    this.country,
    this.pincode,
  });

  Address copyWith({
    String? streetName,
    String? city,
    String? state,
    String? country,
    int? pincode,
  }) {
    return Address(
      streetName: streetName ?? this.streetName,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'streetName': streetName,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      streetName: map['streetName'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      pincode: map['pincode']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(streetName: $streetName, city: $city, state: $state, country: $country, pincode: $pincode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.streetName == streetName &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.pincode == pincode;
  }

  @override
  int get hashCode {
    return streetName.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        pincode.hashCode;
  }
}
