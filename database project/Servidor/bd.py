import pyodbc
from singleton import SingletonMeta
class Bd(metaclass = SingletonMeta):
    def __init__(self) -> None:
        server = '186.15.202.159'
        database = 'TransGaby'
        username = 'leiner'
        password = 'a123'
        conn_str = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
        
        self.conn = pyodbc.connect(conn_str)
        self.cursor = self.conn.cursor()
