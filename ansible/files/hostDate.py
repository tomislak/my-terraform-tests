#!/bin/python3
import platform
import psycopg2
from datetime import datetime
from configparser import ConfigParser


def config(filename='database.ini', section='postgresql'):
    parser = ConfigParser()
    parser.read(filename)

    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))

    return db

def select():
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute('SELECT * FROM hostdate;')
        print(cur.fetchmany(10))
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            #print('Database connection closed.')

def insert():
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        postgres_insert_query = """ INSERT INTO hostdate (stringhost, stringdate) VALUES (%s, %s)"""
        record_to_insert = (str(platform.node()), str(datetime.now().isoformat()))
        cur.execute(postgres_insert_query, record_to_insert)
        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            #print('Database connection closed.')

if __name__ == '__main__':

    print("Content-type:text/html\r\n\r\n")
    print('<html>')
    print('<head>')
    print('<title>Host info</title>')
    print('</head>')
    print('<body>')
    print('<h2>' + str(platform.node()) + '\t' + str(datetime.now().isoformat()) +'</h2>')
    print('</body>')
    print('</html>')
    insert()
    select()

