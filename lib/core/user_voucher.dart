class UserVoucher {
  final int __voucherId;
  final String __userEmail; 
  final bool __isActive;
 
  UserVoucher (
    {required int voucherId,
    required String userEmail,
    bool? isActive})
    :__voucherId = voucherId,
    __userEmail = userEmail,
    __isActive = isActive!;

  factory UserVoucher.fromJSON(Map<String, dynamic> json) => UserVoucher(
    voucherId: json['voucher_id'] as int,
    userEmail: json['user_email'] as String,
    isActive: json['is_active'] as bool);

  int getVoucherId() => __voucherId;
  String getUserEmail() => __userEmail;
  bool getIsActive() => __isActive;
  
}