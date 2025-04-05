class UserModel{
  final String id;
  final String? documentId;
  final String email;
  final String firstName;
  final String lastName;
  final List<dynamic>? address;
  final bool? isSeller;
  final String? sellerId;

  UserModel( {
   required this.id,
   this.documentId,
   required this.email,
   required this.firstName,
   required this.lastName,
   this.isSeller,
   this.sellerId,
    this.address,
});

  factory UserModel.fromMap(Map<String, dynamic> data,String id) {
    return UserModel(
      id: data['id'] ?? '',
      email: data['email'] ?? '',
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      isSeller: data['is_seller'] ?? false,
      sellerId: data['seller_id'],
      documentId: id,
      address: data['address']
    );
  }

  toJson(){
    return {
      "id":id,
      "email":email,
      "first_name":firstName,
      "last_name":lastName,
      "is_seller": isSeller ?? false,
      "seller_id":  sellerId,
      "address":address ?? []
    };
  }
}

class SellerModel{
  final String sellerId;
  final String sellerEmail;
  final String businessName;
  final String contactNumber;
  final String? documentId;

  SellerModel({
    this.documentId,
    required this.sellerId,
    required this.sellerEmail,
    required this.businessName,
    required this.contactNumber
  });

  factory SellerModel.fromMap(Map<String, dynamic> data,String id) {
    return SellerModel(
      sellerId: data['seller_id'],
      documentId: id,
      sellerEmail: data['business_email'],
      businessName: data['business_name'],
      contactNumber: data['contact_number'],
    );
  }

  toJson(){
    return {
      "seller_id":sellerId,
      "business_email":sellerEmail,
      "business_name":businessName,
      "contact_number":contactNumber
    };
  }

}

class AddressModel{
  final String userId;
  final String? documentId;
  final List<String> address;

  AddressModel({
    this.documentId,
    required this.userId,
    required this.address,
  });

  factory AddressModel.fromMap(Map<String, dynamic> data,String id) {
    return AddressModel(
      userId: data['user_id'],
      documentId: id, address: data['address'],
    );
  }

  toJson(){
    return {
      "user_id":userId,
      'address':address
    };
  }

}