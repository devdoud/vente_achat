import 'package:freezed_annotation/freezed_annotation.dart';

import '../impl/logger.dart';

part 'model.freezed.dart';

@freezed
abstract class InfiniteList<T> implements _$InfiniteList<T> {
  const InfiniteList._();

  const factory InfiniteList({
    required List<T> data,
    required String? first,
    required String? next,
    required String? last,
  }) = _InfiniteList<T>;

  factory InfiniteList.empty() => const InfiniteList(
      data: [],
      first: null,
      last: null,
      next: null
  );

  factory InfiniteList.fromApi(Map<String, dynamic> json, T Function(Map<String, dynamic> json) callback){
    try{
      final view= json.containsKey("hydra:view")?json["hydra:view"] as Map<String, dynamic>:null;
      final collections= json.containsKey("hydra:member")?json["hydra:member"]  as List:[];

      return InfiniteList<T>(
          first: view!=null && view.containsKey("hydra:first")?view["hydra:first"].toString():null,
          next: view!=null && view.containsKey("hydra:next")?view["hydra:next"].toString():null,
          last: view!=null && view.containsKey("hydra:last")?view["hydra:last"].toString():null,
          data: collections.map((e) => callback(e as Map<String, dynamic>)).toList()
      );
    }catch(e){
      AppLogger.get().logError("PagingData: $e");
    }

    return InfiniteList.empty();
  }

  bool get isEmpty => data.isEmpty;
  bool get isNotEmpty => !isEmpty;
}