CC =	gcc
RM =	rm -f

SRC=	src/auth.c

OBJ=	$(SRC:.c=.o)

LDFLAGS= -lcryptsetup

CFLAGS= -fPIC -fno-stack-protector

LIB=	pamela.so

$(LIB):	$(OBJ)
	$(CC) $(OBJ) -shared -rdynamic $(LDFLAGS) -o $(LIB)

all:	$(LIB)

install:
	@sudo ./install.sh

uninstall:
	@sudo ./uninstall.sh

check:
	@sudo ./check.sh

test:

clean:
	$(RM) $(OBJ)
	$(RM) $(LIB)

re: clean all
