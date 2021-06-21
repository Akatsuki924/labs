.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
main:
    addi t0, x0, 0 # t0为k的值
    addi s0, x0, 0 # s0储存sum
    la s1, source
    la s2, dest
loop:
    slli s3, t0, 2#t0是k，s3为地址跨度
    add t1, s1, s3# t1为souce中当前元素地址
    lw t2, 0(t1)# t2 是source数组当前元素值
    beq t2, x0, exit# 末尾元素为0，退出循环
    add a0, x0, t2 # a0 为传入参数fun中的x
    addi sp, sp, -8# t register在caller阶段保存在内存中
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal square # 默认储存在ra中
    lw t0, 0(sp)
    lw t2, 4(sp) #这个t2的储存感觉没有必要，后面覆盖了
    addi sp, sp, 8
    add t2, x0, a0 # t2 为当前的fun(souce[k])值
    add t3, s2, s3 # t3是dest[k]的地址
    sw t2, 0(t3) # 给dest[k]赋值
    add s0, s0, t2 # 更新sum的值
    addi t0, t0, 1
    jal x0, loop
square:
    add t0, a0, x0
    add t1, a0, x0
    addi t0, t0, 1
    addi t2, x0, -1
    mul t1, t1, t2
    mul a0, t0, t1
    jr ra 
exit:
    add a0, x0, s0 # a0是返回值
    add a1, x0, x0
    ecall # Terminate ecall