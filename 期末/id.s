.data
.global ids
.global idsum

format_int:	.asciz "%d"
format_intn:.asciz "%d\n"
format_ch:	.asciz "%c"
ids:		.skip 12
idsum:		.skip 4
Title:		.asciz "*****Input ID*****\n"
Prompt1:	.asciz "** Please Enter Member 1 ID:**\n"
Prompt2:	.asciz "** Please Enter Member 2 ID:**\n"
Prompt3:	.asciz "** Please Enter Member 3 ID:**\n"
Prompt4:	.asciz "** Please Enter Command **\n"
Prompt5:	.asciz "*****Print Team Member ID and ID Summation*****\n"
Prompt6:	.asciz "\nID Summation = "
Prompt7:	.asciz "*****End Print*****\n"

.text
.global id

id:
	stmfd   sp!, {lr}

	ldr	 	r0, =Title
	bl		printf

	ldr		r0, =Prompt1
	bl		printf

	mov		r9, sp
	subs	sp,	lr, pc
	bleq	End
	movne	sp, r9

	ldr		r0, =format_int
	ldr		r1, =ids
	bl		scanf

	ldr		r0, =Prompt2
	bl 		printf
	ldr		r0, =format_int
	ldr		r1, =ids
	add		r1, r1, #4
	bl		scanf

	ldr		r0, =Prompt3
	bl 		printf
	ldr		r0, =format_int
	ldr		r1, =ids
	add		r1, r1, #8
	bl		scanf
	ldr	 	r0, =Prompt4
	bl		printf

command_loop:
	ldr		r0, =format_ch
	sub  	sp, sp, #4
	mov		r1, sp
	bl		scanf

	ldrb	r0, [sp]
	add		sp, #4

	cmp		r0, #'p'
	bne		command_loop

	bl		add
	ldr		r0, =Prompt5
	bl		printf

printids:
	ldr		r0, =format_intn
	ldr		r4, =ids
	ldr		r1, [r4]
	bl		printf
	ldr		r1, [r4, #4]!
	ldr		r0, =format_intn
	bl		printf
	ldr		r1, [r4, #4]!
	ldr		r0, =format_intn
	bl		printf

	ldr		r0, =Prompt6
	bl		printf
	ldr		r0, =format_intn
	ldr		r1, =idsum
	ldr		r1, [r1]
	bl		printf
	ldr 	r0, =Prompt7
	bl 		printf
	ldmfd	sp!, {lr}
	mov		pc, lr

add:
	ldr  	r2, =ids
	ldr		r4, [r2]
	mov		r3, #2

add_loop:
	ldr		r5, [r2, #4]!
	add		r4, r4, r5
	subs	r3, r3, #1
	ldreq	r6, =idsum
	streq	r4, [r6]
	bne		add_loop
	mov		pc, lr

End:
	mov		sp, r9
	ldmfd	sp!, {lr}
	mov		pc, lr
