class UserTicket {
  final String __ticketId;
  final String __userEmail; 
  final int __paymentTypeId;
  final DateTime __purcahseDate; 

  UserTicket (
    {required String ticketId,
    required String userEmail,
    required int paymentTypeId,
    required DateTime purchaseDate})
    :__ticketId = ticketId,
    __userEmail = userEmail,
    __paymentTypeId = paymentTypeId,
    __purcahseDate = purchaseDate;

  factory UserTicket.fromJSON(Map<String, dynamic> json) => UserTicket(
    ticketId: json['ticket_id'] as String,
    userEmail: json['user_email'] as String,
    paymentTypeId: json['payment_type_id'] as int,
    purchaseDate: json['purchase_date'] as DateTime);

  String getTicketId() => __ticketId;
  String getUserEmail() => __userEmail;
  int getPaymentTypeId() => __paymentTypeId;
  DateTime getPurchaseDate() => __purcahseDate;
  
}