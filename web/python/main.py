#!/usr/bin/python

import socket
import serial
import sys


client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
client.connect("test.sock")

ser = serial.Serial('/dev/ardMega-Kai', 57600)
try:
    while True:
        x = ser.read(1)
        client.send(x)
        print ord(x)
        #print client.recv(1024)
except KeyboardInterrupt, k:
    print "Closing connection..."


client.close()
