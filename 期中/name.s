.data
msg1: .asciz "*****Print Name*****\n"
msg2: .asciz "*****End Print*****\n"
team: .asciz "Team 01\n"
name1:.asciz "Henry Yan\n"
name2:.asciz "Justin Hsu\n"
name3:.asciz "Iven Hong\n"

.text
.global name

name:
	stmfd 	sp!, {lr}

	ldr		r0, =msg1
	bl 		printf

	ldr 	r0, =team
	bl 		printf

	ldr 	r0, =name1
	bl 		printf

	ldr 	r0, =name2
	bl 		printf

	ldr 	r0, =name3
	bl 		printf

	ldr 	r0, =msg2
	bl 		printf

	ldmfd	sp!, {lr}
	mov 	pc, lr
