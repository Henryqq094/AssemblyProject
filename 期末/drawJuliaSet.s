.text
	.global	drawJuliaSet
SomeConst:
	.word 4000000
	.word 1500
	.word 1000
	.word 0xffff
FRAME_WIDTH:
	.word 640
drawJuliaSet:
	stmfd sp!, {r4-r5, fp, lr}
	add fp, sp, #12		@用於快速還原上一層函數的lr
	mov r4, sp
	mov r5, r0
	rsb sp, lr, r0
	mov sp, r4
	mov r0, r5
	sub sp, sp, #52		@騰出stack來準備存放暫存資料
	str r0, [fp, #-52]	@cX
	str r1, [fp, #-56]	@cY
	str r2, [fp, #-60]	@width
	str r3, [fp, #-64]	@height
	mov r3, #255
	str r3, [fp, #-44]	@maxIter 
	mov r3, #0
	str r3, [fp, #-24]  @x

Loop1:
	ldr r2, [fp, #-24]  @x
	ldr r3, [fp, #-60]
	cmp r2, r3
	bge End
Loop2_start:
	mov r3, #0
	str r3, [fp, #-20]  @y
Loop2:
	ldr r3, [fp, #-20]	@y
	ldr r2, [fp, #-64]	@height
	cmp r3, r2
	ldrge r3, [fp, #-24]  @x
	addge r3, r3, #1	  @x++
	strge r3, [fp, #-24]  
	bge Loop1
	ldr r3, [fp, #-60]  @width
	mov r3, r3, asr #1  @width>>1
	ldr r2, [fp, #-24]	@x
	rsb r3, r3, r2		@x - (width>>1)
	ldr r2, =SomeConst
	ldr r2, [r2, #4]	@1500
	mul r2, r2, r3		@1500*(x - (width>>1))
	ldr r3, [fp, #-60]	@width
	mov r3, r3, asr #1  
	mov r0, r2
	mov r1, r3
	bl	__aeabi_idiv	@divide
	mov r3, r0
	str r3, [fp, #-40]  @zx
	ldr r3, [fp, #-64]  @height
	mov r3, r3, asr #1
	ldr r2, [fp, #-20]	@y
	rsb r3, r3, r2		@y - (height>>1)
	mov r2, #1000
	mul r2, r2, r3		@1000*(y - (height>>1))
	ldr r3, [fp, #-64]	@height
	mov r3, r3, asr #1
	mov r0, r2
	mov r1, r3
	bl	__aeabi_idiv	@divid
	mov r3, r0
	str r3, [fp, #-36]	@zy
	ldr r3, [fp, #-44]	@maxIter
	str r3, [fp, #-28]	@i
	b Loop3_cmp
Loop2_sec_half:
	ldrh r3, [fp, #-28] @i         
    and r2, r3, #0xFF         
    mov r3, r3, lsl #8           
    orr r3, r3, r2               
    str r3, [fp, #-48]  @color      
    ldr r2, =SomeConst
    ldr r2, [r2, #12]   @0xffff        
    eor r3, r3, r2      @取反      
    and r3, r3, r2               
    str r3, [fp, #-48]
	ldr r3, [fp, #4]             
    cmp r3, #0
    beq End 
    ldr r3, [fp, #4]    
    ldr r2, =FRAME_WIDTH
	ldr r2, [r2]	
    mov r2, r2, lsl #1            
    ldr r1, [fp, #-20]  @ y
    mul r1, r1, r2      @ y * width * 2
    ldr r2, [fp, #-24]  @ x
    mov r2, r2, lsl #1
    add r1, r1, r2
    add r3, r3, r1               
    ldr r2, [fp, #-48]
    strh r2, [r3]                
	ldr r3, [fp, #-20]
	add r3, r3, #1
	str r3, [fp, #-20]
	b Loop2
Loop3_cmp:
	ldr r3, [fp, #-40]	@zx
	ldr r2, [fp, #-40]
	mul r3, r3, r2
	ldr r2, [fp, #-36]	@zy
	ldr r1, [fp, #-36]
	mul r2, r2, r1
	add r3, r3, r2
	ldr r2, =SomeConst
	ldr r2, [r2]
	cmp r3, r2
	bge Loop2_sec_half
	ldr r3, [fp, #-28]	@i
	cmp r3, #0
	ble Loop2_sec_half
Loop3:
	ldr r3, [fp, #-40]	@zx
	ldr r2, [fp, #-40]
	mul r3, r3, r2
	ldr r2, [fp, #-36]	@zy
	ldr r1, [fp, #-36]
	mul r2, r2, r1
	sub r3, r3, r2
	mov r2, #1000
	mov r0, r3
	mov r1, r2
	bl __aeabi_idiv		@(zx * zx - zy * zy)/1000
	mov r3, r0
	ldr r2, [fp, #-52]  @cx
	add r3, r3, r2		@(zx * zx - zy * zy)/1000 + cX
	str r3, [fp, #-16]	@tmp
	ldr r3, [fp, #-40]  @zx
	ldr r2, [fp, #-36]  @zy
	mul r3, r3, r2
	mov r3, r3, lsl #1
	mov r2, #1000
	mov r0, r3
	mov r1, r2
	bl __aeabi_idiv		@(2 * zx * zy)/1000
	mov r3, r0			
	ldr r2, [fp, #-56]	@cY
	add r3, r3, r2		@(2 * zx * zy)/1000 + cY
	str r3, [fp, #-36]  @zy
	ldr r3, [fp, #-16]  @tmp
	str r3, [fp, #-40]	@zx
	ldr r3, [fp, #-28]	@i
	sub r3, r3, #1
	str r3, [fp, #-28]
	b Loop3_cmp
End:
	sub sp, fp, #12
	ldmfd sp!, {r4-r5, fp, lr}
	mov pc, lr
