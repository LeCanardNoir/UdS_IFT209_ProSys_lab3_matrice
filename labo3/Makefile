AS = as
LD = ld


ARMV8:	main.o mult.o
	@echo
	@echo ------------------
	@echo Edition des liens
	@echo ------------------
	@echo

	$(LD) -e Main main.o  mult.o  -o matmult -lc



main.o: main.as
	@echo
	@echo ----------------------------------------------
	@echo Compilation du programme principal, main.as
	@echo ----------------------------------------------
	@echo

	$(AS) --gstabs main.as -o main.o

mult.o: mult.as
	@echo
	@echo ----------------------------------------------
	@echo Compilation du sous-programme, mult.as
	@echo ----------------------------------------------
	@echo

	$(AS) --gstabs mult.as -o mult.o
