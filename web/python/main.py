#!/usr/bin/python

import socket
import serial
import sys

from struct import *

client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
#client.connect("test.sock")

ser = serial.Serial('/dev/ardMega-Kai', 57600)
try:
    while True:
        if ser.inWaiting() >= 13:
            if ser.read(1) == '#':
                value = unpack("3f", ser.read(size=12))

                print "%.1f %.1f %.1f" % value

        #client.send(x)
        #print ord(x)
        #print client.recv(1024)
except KeyboardInterrupt, k:
    print "Closing connection..."


client.close()
