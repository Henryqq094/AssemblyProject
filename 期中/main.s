.data
format_int:       	.asciz "%d"
format_intn:		.asciz "%d\n"
team:             	.asciz "Team 01\n"
name1:            	.asciz "   Henry Yan\n"
name2:            	.asciz "   Justin Hsu\n"
name3:            	.asciz "   Iven Hong\n"
F1_prompt:        	.asciz "Function1: Name\n"
F2_prompt:        	.asciz "Function2: ID\n"
Main_prompt:		.asciz "\nMain Function:\n"
Sum_Prompt:			.asciz "ID Summation = "
Print_prompt:		.asciz "*****Print All*****\n"
End_prompt:	 		.asciz "*****End Print*****\n"

.text
.global main

main:
    stmfd   sp!, {lr}

    ldr 	r0, =F1_prompt
    bl 		printf
    bl 		name
    ldr 	r0, =F2_prompt
    bl 		printf
    bl 		id

    ldr 	r0, =Main_prompt
    bl 		printf
    ldr 	r0, =Print_prompt
    bl 		printf

    bl 		PrintIDandName
    bl		PrintIDsum
	
	ldr 	r0, =End_prompt
    bl 		printf

    ldmfd 	sp!, {lr}
    mov 	pc, lr

PrintIDandName:
	stmfd   sp!, {lr}
	
    ldr 	r0, =team
    bl 		printf

    ldr 	r4, =ids
    ldr 	r1, [r4]
    ldr 	r0, =format_int
    bl 		printf
    ldr 	r0, =name1
    bl 		printf
    ldr 	r1, [r4, #4]!
    ldr 	r0, =format_int
    bl 		printf
    ldr 	r0, =name2
    bl 		printf
    ldr 	r1, [r4, #4]
    ldr 	r0, =format_int
    bl 		printf
    ldr 	r0, =name3
    bl 		printf
	
	ldmfd	sp!, {lr}
    mov 	pc, lr

PrintIDsum:
	stmfd	sp!, {lr}
	
	ldr		r0, =Sum_Prompt
	bl 		printf
    ldr 	r1, =idsum
    ldr 	r1, [r1]
    ldr 	r0, =format_intn
    bl 		printf
	
	ldmfd	sp!, {lr}
    mov 	pc, lr
	