from rest_framework.pagination import LimitOffsetPagination


class CSVSetPagination(LimitOffsetPagination):
    page_size = 50
    default_limit = 50
    page_size_query_param = "page_size"
    max_page_size = 100
