CFLAGS = -Wall -g
INCLUDES = -Istorage -I.

all: tests

tests: test_ctools
	@./test_ctools

binarystore.o: storage/binarystore.c storage/binarystore.h storage/storage.h
	$(CC) -c storage/binarystore.c $(INCLUDES) $(CFLAGS)

textstore.o: storage/textstore.c storage/textstore.h storage/storage.h
	$(CC) -c storage/textstore.c $(INCLUDES) $(CFLAGS)

critbit.o: critbit.c critbit.h
	$(CC) -c critbit.c $(CFLAGS)

quicklist.o: quicklist.c quicklist.h
	$(CC) -c quicklist.c $(CFLAGS)

benchmark.o: benchmark.c critbit.h
	$(CC) -c benchmark.c $(CFLAGS)

benchmark: benchmark.o critbit.o
	$(CC) -o benchmark benchmark.o critbit.o$(INCLUDES) $(CFLAGS) -lm

test_ctools: quicklist.o critbit.o binarystore.o textstore.o test_ctools.c storage/test_storage.c storage/storage.h
	$(CC) -o test_ctools textstore.o binarystore.o quicklist.o critbit.o test_ctools.c test_quicklist.c test_critbit.c cutest/CuTest.c storage/test_storage.c $(INCLUDES) $(CFLAGS) -lm

clean:
	@rm -f *.o *~ test_ctools benchmark
