all:: git-credential-osxkeychain git-credential-osxkeychain-fallback

CC = gcc
RM = rm -f
CFLAGS = -g -O2 -Wall
FALLBACK = -DENABLE_FALLBACK

-include ../../../config.mak.autogen
-include ../../../config.mak

git-credential-osxkeychain: git-credential-osxkeychain.o
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) -Wl,-framework -Wl,Security

git-credential-osxkeychain.o: git-credential-osxkeychain.c
	$(CC) -c $(CFLAGS) $<

git-credential-osxkeychain-fallback: git-credential-osxkeychain-fallback.o
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) -Wl,-framework -Wl,Security

git-credential-osxkeychain-fallback.o: git-credential-osxkeychain.c
	$(CC) -c $(CFLAGS) $(FALLBACK) -o $@ $<

clean:
	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o \
	git-credential-osxkeychain-fallback git-credential-osxkeychain-fallback.o

fallback-install:: git-credential-osxkeychain-fallback
	cp git-credential-osxkeychain-fallback /usr/local/bin

.PHONY: clean fallback-install
