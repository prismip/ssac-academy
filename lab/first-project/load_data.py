columns = [
	'global_seq', 'count_date', 'count_date_seq', 'created_date', 'updated_date', 'region_name', 'infection_count', 
    'increased_count', 'on_quarantine', 'release_quarantine', 'death_count', 'local', 'overseas', 'infection_rate'
]

keys = [
	'seq', 'stdDay', 'count_date_seq', 'createDt', 'updateDt', 'gubun', 'defCnt', 'incDec',
	'isolIngCnt', 'isolClearCnt', 'deathCnt', 'localOccCnt', 'overFlowCnt', 'qurRate'
]

key_column_map = { key: column for key, column in zip(keys, columns) }
# print( key_column_map )
column_key_map = { column: key for key, column in zip(keys, columns) }
# print( column_key_map )

def request_data(f, to):
    import requests

    url_string = 'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson'
    api_key = 'R%2BBEwJ49XVmTutdoCAdNq4m7wjOsdFNhVtlzkxWVeZJPhwQqWbGcD7CNeQPipFzIWAanQVw%2FrPLsGkfcYvD4AQ%3D%3D'

    qs = 'serviceKey={0}&pageNo={1}&numOfRows={2}&startCreateDt={3}&endCreateDt={4}'.format(api_key, 1, 10, f, to)

    # response_body = request.urlopen(url_string + '?' + qs).read()
    response = requests.get(url_string + '?' + qs)
    response_body = response.content

    return response_body

def make_dict_from_json(data):
    import xmltodict
    import json

    response_dict = xmltodict.parse(data) # return collections.OrderedDict
    response_dict2 = json.loads(json.dumps(response_dict))
    # return response_dict2
    
    if response_dict2['response']['body']['totalCount'] == '0':
        return None
    else:
        return response_dict2['response']['body']['items']['item']
    
def fix_invalid_data(value):
    try: value['isolIngCnt'] = value['isolIngCnt'] if value['isolIngCnt'] else '-1' 
    except: value['isolIngCnt'] = '-1'

    try: value['localOccCnt'] = value['localOccCnt'] if value['localOccCnt'] else '-1'
    except: value['localOccCnt'] = '-1'

    try: value['overFlowCnt'] = value['overFlowCnt'] if value['overFlowCnt'] else '-1'
    except: value['overFlowCnt'] = '-1'

    try: value['isolClearCnt'] = value['isolClearCnt'] if value['isolClearCnt'] else '-1'
    except: value['isolClearCnt'] = '-1'  

    try: value['qurRate'] = value['qurRate'] if value['qurRate'] else '-1'
    except: value['qurRate'] = '-1'

    try: value['defCnt'] = value['defCnt'] if value['defCnt'] else '-1'
    except: value['defCnt'] = '-1'

    return value

def transfer_to_database(values):

    from datetime import datetime
    import pymysql

    connection_info = { 'host': 'localhost', 'user': 'root', 'password': 'Pa$$w0rd', 'db': 'demodb_a', 'charset': 'utf8' }

    conn = pymysql.connect(**connection_info)
    cursor = conn.cursor()

    for value in values:

        dt = datetime.strptime(value['stdDay'], "%Y년 %m월 %d일 %H시")
        value['stdDay'] = datetime.strftime(dt, '%Y-%m-%d')
        dt = datetime.strptime(value['createDt'], "%Y-%m-%d %H:%M:%S.%f")
        value['createDt'] = datetime.strftime(dt, '%Y-%m-%d %H:%M:%S')

        sql = "SELECT IFNULL(COUNT(*), 0) FROM infection_count WHERE count_date = %s and region_name = %s and created_date = %s"
        cursor.execute(sql, (value['stdDay'], value['gubun'], value['createDt']))
        if cursor.fetchone()[0] > 0:
            continue    

        value = fix_invalid_data(value)

        sql = "SELECT IFNULL(MAX(count_date_seq), 0) FROM infection_count WHERE count_date = %s and region_name = %s"
        cursor.execute(sql, (value['stdDay'], value['gubun']))
        count_date_sequence = cursor.fetchone()[0]
        value['count_date_seq'] = 1 if count_date_sequence == 0 else count_date_sequence + 1

        if not value['updateDt'] or value['updateDt'] == 'null':
            value['updateDt'] = value['createDt']
        else:
            dt = datetime.strptime(value['updateDt'], "%Y-%m-%d %H:%M:%S.%f")
            value['updateDt'] = datetime.strftime(dt, '%Y-%m-%d %H:%M:%S')

        value['qurRate'] = value['qurRate'] if value['qurRate'].isdigit() else '-1'  

        sql = 'INSERT INTO infection_count VALUES(NULL, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
        cursor.execute(sql, [ value[column_key_map[column]] for column in columns[1:] ])

    conn.commit()

    conn.close()

def show_usage_message(error_type):
    if error_type not in [1, 2, 3, 4]:
        raise ValueError("Invalid Error Type - Error shoud be 1 or 2 or 3 or 4 !!!!!")
    
    messages = ["Invalid Execution !!!", "Invalid from-date Format !!!", "Invalid from-date Format !!!", "Data Not Found. !!!"]
    print(messages[error_type - 1])
    print("USAGE : load_infection_data.py from-date(yyyymmdd) to-date(yyyymmdd)")
    print("        and date shoud be after '20200301'")
        
if __name__ == "__main__":

    import sys
    from datetime import datetime

    print(sys.argv)
    if len(sys.argv) != 3:
        show_usage_message(1)
        sys.exit(-1)
        
    for idx in range(2, 4):
        try:
            datetime.strptime(sys.argv[1], "%Y%m%d")
        except:
            show_usage_message(idx)
            sys.exit(-1)

    response_body = request_data(sys.argv[1], sys.argv[2])
    values = make_dict_from_json(response_body)
    
    if values == None:
        show_usage_message(4)
        sys.exit(-1)
        
    transfer_to_database(values)