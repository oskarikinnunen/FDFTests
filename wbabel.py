from itertools import permutations
from itertools import combinations
import subprocess
import pathlib
import sys
import os

class colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    RED = '\033[91m'

path = str(pathlib.Path(__file__).parent.resolve())
#perms = [''.join(p) for p in permutations('0 0\n-0 -0\n')]


map1 = \
"-128 127 0\n," + \
"127 -128 0\n," + \
"0 127 -128\n," + \
"0 -128 127\n"

map127 = \
"-127 ,0\n," + \
"0 ,127\n,-"

map128 = \
"-128 ,0\n," + \
"0 ,128\n,-"

#map2 = " -,\n,1 1,1,1 ,1 ,1 ,1"
map2ez = \
"-1,\n," + \
"-1 -1 -1,\n," + \
"-1 -1, -1"
map3 = "0 0 0,\n,0 0 ,0\n,-"
#0 0 0\n
#0 0 0\n
#
map4 = \
"-1280 1270 0\n," + \
"1270 -1280 0\n," + \
"0 1270 -1280\n," + \
"0 -1280 1270\n"

mapmax = \
"2147483647 -2147483648\n," + \
"-2147483648 2147483647\n"

mapmaxwrong = \
"-2147483647, ,0,\n," + \
"0 0\n"

mapuimax = \
"0 0\n," + \
"4294967295, ,0"


map5 = "-0 0 0,\n,0 0 0-\n"
#-0 0 0\n
#0 0 0\n
#
map6 = "1,1,1,1, , ,\n,\n"


curmap = mapuimax
prefix = "mumax_"
lst = list(curmap.split(","))
perms = permutations(lst)
p_set = set(perms)
print(path + '/testfile')
tlen = len(p_set)
print(tlen)
if (len(sys.argv) > 1 and sys.argv[1] == "exit"):
	exit()
i = 0
found_rootmap = False
for p in p_set:
	str_p = ""
	for s in list(p):
			str_p += s
	if str_p == curmap.replace(",",""):
		found_rootmap = True
	subprocess.call(['zsh', 'auth_babel.sh', str_p , prefix + str(i)])
	if (round(i / tlen, 5) * 100) % 5 == 0:
		os.system('clear')
		print('cur test file	= ' + str(i) + ' out of ' + str(tlen))
		print('Found root map	= ' + str(found_rootmap))
		print(str(round(i / tlen, 2) * 100) + "%")
		print('\nTEST FILE CONTENT= \n' + str_p)
	i += 1
print('\n\nFound root map during testing:	' + str(found_rootmap) + colors.RED +"\n				(TEST IS BORKE IF THIS IS FALSE)")
print(colors.HEADER + "Finished testing " + str(tlen) + " permutations")