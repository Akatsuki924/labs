.data
.word 2, 4, 6, 8
n: .word 9# 规定了n的初始值

.text
main:   
    add t0, x0, x0
    addi t1, x0, 1
    la t3, n# 储存n的地址
    lw t3, 0(t3)# 读取该地址memory的数据
fib:    
    beq t3, x0, finish # 控制迭代次数
    add t2, t1, t0
    mv t0, t1
    mv t1, t2
    addi t3, t3, -1  
    j fib
finish: 
    addi a0, x0, 1
    addi a1, t0, 0
    ecall # print integer ecall
    addi a0, x0, 10
    ecall # terminate ecall
