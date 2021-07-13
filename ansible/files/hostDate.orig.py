#!/bin/python3
import platform
from datetime import datetime

print("Content-type:text/html\r\n\r\n")
print('<html>')
print('<head>')
print('<title>Host info</title>')
print('</head>')
print('<body>')
print('<h2>' + str(platform.node()) + '\t' + str(datetime.now().isoformat()) +'</h2>')
print('</body>')
print('</html>')
