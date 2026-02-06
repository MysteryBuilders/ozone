class HelperQuery{
  Map<String, dynamic> buildFilterQueryParams({
    String? categoryId,
    String? minPrice,
    String? maxPrice,
    String? search,
    bool? onSale,
    int? page,
    int? pageSize,
    String? sortBy,
    String? sortDirection,
    int? userid,
    String? entityId,
    String? brandId,
    String? sku,
    String ?sourceCode,
    String? sortOrder,
    Map<String,dynamic>? searchCriteriaMap

  }) {
    final Map<String, dynamic> queryParams = {};
    int filterGroupIndex = 0;
    if(userid != null){
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] = 'customer_id';
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] = userid;
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] = 'eq';

    }else {
      if(searchCriteriaMap!= null){
        print("searchCriteriaMap ---> ${searchCriteriaMap}");
        searchCriteriaMap.forEach((key, value) {
          if (value is List) {
            if(value.isNotEmpty) {
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
                  key;
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
                  value.join(',');
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
              'in';
              filterGroupIndex++;
              print('Key: $key, Values: ${value.join(', ')}');
            }
          } else {
            if(searchCriteriaMap.containsKey("startPrice")){
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
              'price';
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
              searchCriteriaMap['startPrice'];
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
              'gteq';
              filterGroupIndex++;


            }
            if(searchCriteriaMap.containsKey("endPrice")){
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
              'price';
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
              searchCriteriaMap['endPrice'];
              queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
              'lteq';
              filterGroupIndex++;

            }
          }
        });




      }else {
        if (brandId != null) {
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
          'manufacturer';
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
              brandId;
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
          'eq';
          filterGroupIndex++;
        }
        if (categoryId != null) {
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
          'category_id';
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
              categoryId;
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
          'eq';
          filterGroupIndex++;
        }
        if (entityId != null) {
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
          'entity_id';
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
              entityId;
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
          'eq';
          filterGroupIndex++;
        }

        if (minPrice != null) {
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
          'price';
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
              minPrice;
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
          'gteq';
          filterGroupIndex++;
        }


        if (maxPrice != null) {
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
          'price';
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
              maxPrice;
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
          'lteq';
          filterGroupIndex++;
        }

        if (search != null && search.isNotEmpty) {
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
          'name';
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
          '%$search%';
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
          'like';
          filterGroupIndex++;
        }

        if (onSale == true) {
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
          'special_price';
          queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
          'notnull';
          filterGroupIndex++;
        }
      }

      // Visibility filter for products
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
      'visibility';
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
      '4';
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
      'eq';

      // Pagination and Sorting
      if (page != null) {
        queryParams['searchCriteria[currentPage]'] = page;
      }
      if (pageSize != null) {
        queryParams['searchCriteria[pageSize]'] = pageSize;
      }

      if (sortBy != null) {
        queryParams['searchCriteria[sortOrders][1][field]'] = sortBy;
      }
      if (sortOrder != null) {
        queryParams['searchCriteria[sortOrders][0][field]'] = sortOrder;
      }

      if (sortDirection != null) {
        queryParams['searchCriteria[sortOrders][0][direction]'] = sortDirection;
      }

    }
    return queryParams;
  }
  Map<String, dynamic> buildStockParams({

    String ?sourceCode,
    String? sku

  }) {
    final Map<String, dynamic> queryParams = {};
    int filterGroupIndex = 0;
    print('sourceCode-----> $sourceCode');
    if (sourceCode != null) {
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
      'source_code';
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
          sourceCode;
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
      'eq';
      filterGroupIndex++;
    }
    if (sku != null) {
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][field]'] =
      'sku';
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][value]'] =
          sku;
      queryParams['searchCriteria[filter_groups][$filterGroupIndex][filters][0][condition_type]'] =
      'eq';
      filterGroupIndex++;
    }
    return queryParams;

  }

  String mapToQueryString(Map<String, dynamic> map) {
    return map.entries
        .map((e) =>
    '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value.toString())}')
        .join('&');
  }

}