class PageResult<T> {
  final List<T> items;
  final int totalCount;
  final int numItemsPerPage;
  final int currentPageNumber;
  final int? nextPageNumber;

  const PageResult({
    required this.items,
    required this.totalCount,
    required this.numItemsPerPage,
    required this.currentPageNumber,
    this.nextPageNumber,
  });

  bool get hasNextPage => nextPageNumber != null;
  bool get isFirstPage => currentPageNumber == 1;
}
