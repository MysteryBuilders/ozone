import 'package:bloc/bloc.dart';



import '../../../../domain/model/products_model.dart';
import '../../../../domain/usecases/product_use_case.dart';
import 'load_more_event.dart';
import 'load_more_state.dart';

class LoadMoreBloc extends Bloc<LoadMoreEvent, LoadMoreState> {
   List<ProductItemModel> _items = [];
  bool _hasReachedMax = false;
  final ProductUseCase productUseCase;

  LoadMoreBloc(this.productUseCase) : super(initalLoading()) {
    on<LoadInitialData>(_onLoadInitialData);
    on<LoadMoreData>(_onLoadMoreData);
  }

  void _onLoadInitialData(LoadInitialData event, Emitter<LoadMoreState> emit) async {
    emit(DataLoading());
    // try {
    //   await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    //   _items.addAll(List.generate(20, (index) => "Item $index"));
    //   emit(DataLoaded(items: _items));
    // } catch (_) {
    //   emit(DataError());
    // }
    (await productUseCase.execute(ProductUseCaseInput(event.map,event.authorization))).fold(
          (failure) {
            if(event.map['searchCriteria[currentPage]'] !=1){
              emit(DataLoaded(items: _items, hasReachedMax: true));
            }else {
              print("failture ---> $failure");

              emit(DataError(message: failure.message));
             }

      },
          (response) async {
            _items = response.items!;
            print("items --->${_items.length} ");
            print("totalCount --->${response.totalCount} ");
            if(response.totalCount == _items.length){
              print("hasReachedMax");
              emit(DataLoaded(items: _items, hasReachedMax: true));
            }else{
              emit(DataLoaded(items: _items));
            }








      },
    );
  }

  void _onLoadMoreData(LoadMoreData event, Emitter<LoadMoreState> emit) async {
    if (_hasReachedMax) return;
    emit(DataLoaded(items: _items, hasReachedMax: false));

      (await productUseCase.execute(ProductUseCaseInput(event.map,event.authorization))).fold(
            (failure) {

              if(event.map['searchCriteria[currentPage]'] !=1){
                emit(DataLoaded(items: _items, hasReachedMax: true));
              }else {
                print("failture ---> $failure");

                emit(DataError(message: failure.message));
              }

        },
            (response) async {
              final newItems = response.items;

              if (newItems!.isEmpty) {
                _hasReachedMax = true;
              } else {
                _items.addAll(newItems);
              }
              emit(DataLoaded(items: _items, hasReachedMax: _hasReachedMax));








        },
      );
     // Simulate network delay

  }
}
