class StocksRepository:

    def __init__(self):
        self.connection_info = { 'host': 'localhost', 'db': 'dashboarddb', 'user': 'root', 'password': 'Pa$$w0rd', 'charset': 'utf8' }

    def select_stockmaster_by_name(self, name_key):

        import pymysql

        conn = pymysql.connect(**self.connection_info)
        cursor = conn.cursor()

        sql = "select symbol, market, name, sector, industry, listing_date, settle_month, representative, homepage, region from stocks_stockmaster where name like %s"
        cursor.execute(sql, ("%" + name_key + "%",))

        rows = cursor.fetchall() # 반환 값은 tuple의 list [ (...), (...), ..., (...) ]
        keys = ["symbol", "market", "name", "sector", "industry", 'listing_date', "settle_month", "representative", "homepage", "region"]
        result = []
        for row in rows:
            row_dict = { key:value for key, value in zip(keys, row) }
            result.append(row_dict)

        conn.close()

        return result

    def select_stockmaster_by_symbol(self, symbol):
        import pymysql

        conn = pymysql.connect(**self.connection_info)
        cursor = conn.cursor()

        sql = "select symbol, market, name, sector, industry, listing_date, settle_month, representative, homepage, region from stocks_stockmaster where symbol = %s"
        cursor.execute(sql, (symbol,))

        row = cursor.fetchone() # 반환 값은 tuple (...)
        keys = ["symbol", "market", "name", "sector", "industry", 'listing_date', "settle_month", "representative", "homepage", "region"]
        
        result = { key:value for key, value in zip(keys, row) }
            
        conn.close()

        return result