#!/usr/bin/python

import sys

f = open("list", "r")
arr = f.read()
f.close()
f = open("controlList", "r")
arrControl = f.read()
f.close()

i=0

for n in arr:
    if n != arrControl[i]:
        print ("false")
        sys.exit("error")
    i = i + 1

print("all is good")
