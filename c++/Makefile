CC=g++
CFLAGS=-Wall -fexceptions -std=c++14 -O3
LIBS=

helper: helper.cpp
	$(CC) -o helper $(CFLAGS) helper.cpp $(LIBS)

crtp: crtp.cpp
	$(CC) -o crtp $(CFLAGS) crtp.cpp $(LIBS)

clean:
	rm -f crtp helper
