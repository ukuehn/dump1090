#
# When building a package or installing otherwise in the system, make
# sure that the variable PREFIX is defined, e.g. make PREFIX=/usr/local
#
PROGNAME=dump1090

ifdef PREFIX
BINDIR=$(PREFIX)/bin
SHAREDIR=$(PREFIX)/share/$(PROGNAME)
EXTRACFLAGS=-DHTMLPATH=\"$(SHAREDIR)\"
endif

CFLAGS=-O2 -g -Wall -W `pkg-config --cflags librtlsdr`
LIBS=`pkg-config --libs librtlsdr` -lpthread -lm
CC=gcc

all: dump1090

%.o: %.c
	$(CC) $(CFLAGS) $(EXTRACFLAGS) -c $<

dump1090: dump1090.o anet.o
	$(CC) -g -o dump1090 dump1090.o anet.o $(LIBS)

install: dump1090
	install -m 755 dump1090 $(BINDIR)
	mkdir -p $(SHAREDIR)
	install -m 644 public_html/gmap.html $(SHAREDIR)

clean:
	rm -f *.o dump1090
