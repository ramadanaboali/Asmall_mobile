class CartMedelLocal{
  //attributes = fields in table
  String _id;
  String _name;
  String _img;
  String _description;
  double _price;
  double _totalPrice;
  int _quantity;
  int _selectItem;
  String _ColorId;
  String _ProductSizeId;
  CartMedelLocal(dynamic obj){
    _id = obj['id'];
    _name = obj["name"];
    _img=obj["img"];
    _price = obj["price"];
    _totalPrice=obj["totalPrice"];
    _quantity = obj["quantity"];
    _description=obj["description"];
    _ColorId=obj["ColorId"];
    _ProductSizeId=obj["ProductSizeId"];
    _selectItem=obj["selectItem"];
  }
  CartMedelLocal.fromMap(Map<String,dynamic> data){
    _id = data['id'];
    _name = data['name'];
    _img = data['img'];
    _description=data["description"];
    _price = data['price'];
    _totalPrice = data['totalPrice'];
    _quantity = data['quantity'];
    _ColorId=data["ColorId"];
    _ProductSizeId=data["ProductSizeId"];
    _selectItem=data["selectItem"];
  }
  Map<String, dynamic> toMap() => {'id' : _id,'name' : _name,'img' : _img,"description":_description,'price' : _price,'totalPrice' : _totalPrice,'quantity' : _quantity,"ColorId":_ColorId,"ProductSizeId":_ProductSizeId,"selectItem":_selectItem};

  String get id => _id;
  String get name => _name;
  String get img => _img;
  String get description=>_description;
  double get price => _price;
  double get totalPrice => _totalPrice;
  int get quantity => _quantity;
  int get selectItem => _selectItem;
  String get ColorId =>_ColorId;
  String get ProductSizeId =>_ProductSizeId;
}