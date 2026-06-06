import '../../domain/models/page_result.dart';

class PageResultDto<T> {
  final List<T> items;
  final int totalCount;
  final int numItemsPerPage;
  final int currentPageNumber;
  final int? nextPageNumber;

  const PageResultDto({
    required this.items,
    required this.totalCount,
    required this.numItemsPerPage,
    required this.currentPageNumber,
    this.nextPageNumber,
  });

  factory PageResultDto.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final rawItems = json['items'] as List? ?? [];
    return PageResultDto(
      items: rawItems.map((e) => fromJson(e as Map<String, dynamic>)).toList(),
      totalCount: json['totalCount'] as int? ?? 0,
      numItemsPerPage: json['numItemsPerPage'] as int? ?? 20,
      currentPageNumber: json['currentPageNumber'] as int? ?? 1,
      nextPageNumber: json['nextPageNumber'] as int?,
    );
  }

  PageResult<T> toDomain() => PageResult(
        items: items,
        totalCount: totalCount,
        numItemsPerPage: numItemsPerPage,
        currentPageNumber: currentPageNumber,
        nextPageNumber: nextPageNumber,
      );
}
