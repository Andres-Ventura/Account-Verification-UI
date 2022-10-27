Lab 3

.ORIG x3000
RESTART LEA R0, PROMPT
	
	PUTS; Outputs string to screen
	GETC; Reads single character from keyboard
	
	ADD R3, R3, #0; Clears R3
	ADD R3, R0, #0; Assigns R3
	ADD R3, R3, #-16
	ADD R3, R3, #-16
	ADD R3, R3, #-16; ASCII -48

	ADD R4, R3, #0
	ADD R4, R4, #0
	BRn OUTOFBOUND
	ADD R4, R4, #-6
	BRp OUTOFBOUND

		LEA R0, DAYS ; Address days (Sunday) in R0 
		ADD R3, R3, #0; Condition Setter
LOOP	BRz DISPLAY
		ADD R0, R0, #10; Next day
		ADD R3, R3, #-1; Decrease variable for loop
		BR LOOP

DISPLAY PUTS
	BR RESTART
OUTOFBOUND HALT

PROMPT .STRINGZ "Enter a number:"
DAYS   .STRINGZ "Sunday "
	   .STRINGZ "Monday " 
	   .STRINGZ "Tuesday " 
	   .STRINGZ "Wednesday "
	   .STRINGZ "Thursday "
	   .STRINGZ "Friday "
	   .STRINGZ "Saturday "
.END







Lab 4

.ORIG x3000
					
	LEA R1, xFF			
	LDR R1, R1, #0		; The input
	
	ADD R2, R2, #0		; Initializing variables
	ADD R3, R3, #1		; n-1 and n-2 storing
	ADD R4, R4, #0		; storing n 
	ADD R5, R5, #0		; counter 

	ADD R1, R1, x-2		; If conditional
	BRnz nth_FIB_FOUND	; Check in loop status

FIND_nth_FIB
	
	NOT R6, R1		
	ADD R6, R6, #1		; Comparing counter var with N
	ADD R6, R6, R5		; Subtracting counter var from N
	BRz nth_FIB_FOUND		; Continues only if counter != N	

	ADD R4, R2, R3 		; Next fib computation
	ADD R5, R5, #1		; Counter Incrementation
	ADD R2, R3, #0		; R2 set to R3
	ADD R3, R4, #0		; R3 set to R4

	BR FIND_nth_FIB	

nth_FIB_FOUND	
	
	STI R4, Fn			; Fib number storage	

LARGEST_FIB
	
	ADD R4, R2, R3 		; Next fib computation
	BRn LARGEST_FOUND		; Overflow occurrence checker only if negative

	ADD R2, R3, #0		; R2 set to R3
	ADD R3, R4, #0		; R3 set to R4
	ADD R5, R5, #1		; Counter Incrementation

	BR LARGEST_FIB

LARGEST_FOUND 

	STI R5, N			; Counter storing
	STI R3, FN			; Nth fib number storing

HALT
	Fn 	.FILL x3101		; Nth fib
	N 	.FILL x3102		; Nth fib counter
	FN	.FILL X3103		; Nth fib

.END
