#!/usr/bin/python

from nanomsg import *
import _nanomsg_ctypes as nnc
import struct

with Socket(SUB) as s:
	s.connect("ipc:///tmp/testnano")
	s.set_string_option(SUB, SUB_SUBSCRIBE, '')
	frameSize = 324*240*4
	while True:
		frameNoBuf, frame, err = nnc.nn_recvmsg(s, [4, frameSize])
		frameNo, = struct.unpack('<L', frameNoBuf)
		if not err:
			print "frameNo "+ str(frameNo) + " and frame data (" + str(len(frame)) + " bytes) received"
		else:
			print "error reading from socket: "+str(err)

