import logging
import pytest

from hpca.utils.influx_query import InfluxQuery
from influxdb.exceptions import InfluxDBClientError


def test_default_host():
    query = InfluxQuery()
    assert query.host == 'influxdb-proxy.metrics.svc.carg.k8s'


def test_data_type_invalid():
    query = InfluxQuery()
    with pytest.raises(SystemExit) as cm:
        query.submit(query='fake query', data_type='yaml')
    assert cm.value.args == ("Invalid data type specified. Use 'json' or 'df'.",)


def test_data_type_json(mocker):
    mock_client = mocker.MagicMock()
    query_return = mocker.MagicMock()
    query_return.raw = '{"k": "v"}'
    mock_client.query.return_value = query_return
    client_mock = mocker.patch('hpca.utils.influx_query.InfluxDBClient', return_value=mock_client)
    df_type = mocker.patch('hpca.utils.influx_query.DataFrameClient')
    query = InfluxQuery(user='test_user', db='something', host='www', password='tef', use_ssl=True, port=9999)
    json_out = query.submit(query='potato', data_type='json')
    client_mock.assert_called_once_with(
        database='something',
        host='www',
        password='tef',
        port=9999,
        ssl=True,
        username='test_user',
    )
    mock_client.query.assert_called_once_with('potato')
    assert json_out == '{"k": "v"}'
    assert not df_type.called


def test_influx_client_error(mocker, caplog):
    query = InfluxQuery()
    mock_client = mocker.MagicMock()
    mock_client.query.side_effect = InfluxDBClientError('client error')
    client_mock = mocker.patch('hpca.utils.influx_query.InfluxDBClient', return_value=mock_client)
    with pytest.raises(InfluxDBClientError) as cm:
        query.submit(query='smthg', data_type='json')
    assert cm.value.args == ('client error',)
    assert caplog.record_tuples == [
        ('hpca.utils.influx_query', logging.ERROR, 'InfluxDB client error:\nclient error'),
    ]


@pytest.fixture()
def spam(caplog):
    print('\nsetting up spam')
    yield {"key": "val", "the caplog fixture": caplog}
    print('tearing down spam\n')


def test_something2(spam, caplog):
    # logging.error('oops')
    assert spam['the caplog fixture'].record_tuples == []


def test_temp(tmpdir):
    tmpfile = tmpdir.join('fname')
    tmpfile.write('hello world')
    print()
    print(tmpdir)
    print(tmpfile)
    import time
    time.sleep(60)
