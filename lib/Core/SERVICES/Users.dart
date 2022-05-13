  class Users {
    String? uid;
    String? email;
    String? firstName;
    String? lastName;
    String? gender;
    Users({this.uid, this.email, this.firstName, this.lastName, this.gender});
    // receiving data from server
    factory Users.fromMap(map){
      return Users(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        gender: map['gender'],
      );
    }
    //sending data to out server
    Map<String, dynamic> toMap(){
      return{
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
      };
    }
  }