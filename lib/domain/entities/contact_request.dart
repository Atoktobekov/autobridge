class ContactRequest {
  ContactRequest({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.comment,
    required this.budget,
    required this.preferredBrand,
    required this.preferredModel,
  });

  final String id;
  final String fullName;
  final String phone;
  final String comment;
  final String budget;
  final String preferredBrand;
  final String preferredModel;
}
