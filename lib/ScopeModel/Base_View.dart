import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Locator_Service.dart';
class BaseView<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> builder;
  final Function(T) onModelRely;
  BaseView({ScopedModelDescendantBuilder<T> builder,this.onModelRely}) : builder = builder;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BaseViewState<T>();
  }
}
class BaseViewState <T extends Model> extends State<BaseView<T>>
{
  T _model = locatorGetIt<T>();
  @override
  void initState() {
    // TODO: implement initState
    if(widget.onModelRely!=null)
      {
        widget.onModelRely(_model);
      }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<T>(model:_model
      ,child: ScopedModelDescendant<T>(builder: widget.builder,rebuildOnChange: true,),);
  }

}
