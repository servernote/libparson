CC		=	gcc
#CC_DBG	+=	-g
CC_OPT	+=
CC_INC	+=
CFLAGS	+=	$(CC_OPT) $(CC_DBG) $(CC_INC)
DESTLIB	=	/usr/local/lib
DESTINC	=	/usr/local/include

all:	libparson.a libparson.so.1.0

libparson.oa:	../parson/parson.c ../parson/parson.h
	$(CC) $(CFLAGS) -o $@ -c $<

libparson.os:	../parson/parson.c ../parson/parson.h
	$(CC) $(CFLAGS) -fPIC -o $@ -c $<

libparson.a:	libparson.oa
	ar rv $@ $?
	ranlib $@

libparson.so.1.0:	libparson.os
	$(CC) -shared -Wl,-soname,libparson.so.1 -o libparson.so.1.0 $?

clean:
	rm -f *.o* *.a *.so*

install:	all
	install libparson.a $(DESTLIB)
	install libparson.so.1.0 $(DESTLIB)
	ldconfig $(DESTLIB)
	ln -f -s -r $(DESTLIB)/libparson.so.1 $(DESTLIB)/libparson.so
	install -m 0644 ../parson/parson.h $(DESTINC)
