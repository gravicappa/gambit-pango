targets = pango-cairo.o1

CFLAGS += ${shell pkg-config --cflags cairo} \
          ${shell pkg-config --cflags pango} \
          ${shell pkg-config --cflags pangocairo}
LDFLAGS += ${shell pkg-config --libs cairo} \
           ${shell pkg-config --libs pango} \
           ${shell pkg-config --libs pangocairo}

pango-cairo.o1: pango-cairo.scm 

include config.mk
