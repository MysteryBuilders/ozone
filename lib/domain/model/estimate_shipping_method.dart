class EstimateShippingMethod{

  final String carrierCode;


  final String methodCode;

  final String carrierTitle;


  final String methodTitle;

  final double amount;

  final double baseAmount;

  final bool available;

  final String errorMessage;

  final double priceExclTax;

  final double priceInclTax;
  EstimateShippingMethod(this.methodTitle, this.amount, this.baseAmount, this.available, this.errorMessage, this.priceExclTax, this.priceInclTax,  this.carrierCode,  this.methodCode,  this.carrierTitle);

  }