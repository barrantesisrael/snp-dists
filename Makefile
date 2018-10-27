
CC = gcc
CFLAGS = -Wall -Wextra -O3 -std=c99 
LIBS = -lz -lm

EXE = snp-dists
PREFIX = /usr/local
TESTDIR = test

.PHONY: all check clean format
.DEFAULT: all

all: $(EXE)

$(EXE): main.c 
	$(CC) $(CFLAGS) -o $(EXE) $^ $(LIBS)

main.c: kseq.h

install: $(EXE)
	install -v -t $(PREFIX)/bin $(EXE)

clean:
	$(RM) *~ *.o $(EXE)

check:
	./$(EXE) -v
	./$(EXE) /dev/null || true
	./$(EXE) -b $(TESTDIR)/singleton.aln
	./$(EXE) -b $(TESTDIR)/good.aln
	./$(EXE) -b $(TESTDIR)/gzip.aln.gz
	./$(EXE) -b -k $(TESTDIR)/lowercase.aln
	./$(EXE) -b    $(TESTDIR)/lowercase.aln
	./$(EXE) -b -c -q $(TESTDIR)/good.aln
	./$(EXE) -b -a $(TESTDIR)/ambig.aln
	./$(EXE) -b    $(TESTDIR)/ambig.aln
#	./$(EXE) $(TESTDIR)/huge.aln.gz > /dev/null

format:
	clang-format -i main.c
