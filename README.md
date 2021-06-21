# su20-lab

# Lab3

* excise1 主要让你熟悉venus 的操作，可以用这个来查看内存，你会发现不同类型的数据在memery的储存方式
* .text就是machine code，点开你会发现是machine code在内存中的储存方式是最低位字节存在最低位的地址，即Little-Endianness

<img src="F:\CS\picture\image-20210602153456361.png" alt="image-20210602153456361" style="zoom:50%;" />

<img src="F:\CS\picture\image-20210602153508112.png" alt="image-20210602153508112" style="zoom:50%;" />

* .data就是static data区域你可以直观的发现它是往上grow的，然后stack中的则是往下grow的，.word说明一个元素占4个字节
* ecall的功能是由a0和a1中的值来决定的

* 调试用venus比较好，本地运行需要配置java环境，而且我一用中文注释好像就不太行
* 计算阶乘可以用递归，教材上有类似的递归的例题P102
* 做链表递归的时候，要注意当callee中要改变s-register的时候一定要提前储存在内存中，而改变t-register若要储存则是Caller要做的
* 书上关于jalr的说明是有问题的，正确的应该是三个参数如：jalr ra t0 0

# Lab４

* 第一个task在一个有错误的machine code里面找五个bug，因为包含指针，容易搞错，array的首地址是存在memory中的所以应该是用lw，然后注意每个元素的长度，然后容易漏掉的一个是t0 register在jal的地方被改变而且jal回来后还要用那么在jal前必须先存在memory中
* 第二个task没难度，找到输入参数和相应offset的关系基本就解决了

# Lab 5

* 这个lab主要让你熟悉Logism软件的用法，并画一些简单的logic circuit，按着它给的提示做就好了，顺便起到复习的作用，注意Logism运行的时候teminal 不能关，不然同时软件也会关了且没有保存提示，没保存就需要重新做
* ex1是用AND OR NOT三个逻辑门画出XOR NAND NOR MUX（2-to-1)  MUX(4-to-1) 其中MUX的画法忘了话，复习一下ppt就知道了
* ex2 画一个通过clock控制的自增结构，用到了adder和register
* ex3是画一个FSM，这里还贴心的给你复习了啥是FSM，基本流程就是给出truth table，然后观察输入输出值的关系，写成boolean expression化简后转化为逻辑电路，可以直观看到实现 current state + input => next state +output
* ex4 主要让你熟悉一下spliter的使用方法，例子很简单
* ex5 实现A最右边的B bits移到最左边，这个稍微需要想一想怎么使用MUX和spliter实现上述功能，页面给出的Hints很有用

# Lab 6

* 这个lab让你改造non-pipelined circuit为一个pipelined circuit 并比较两者之间的max clock rate差异

* Ex1 计算pipelined circuit的max circuit，首先找到critic path，注意比较adder两个input哪个耗时更长，显然是上面的input耗时长 cycle time = c-to-q+mul+add+set up = 10+60+45+10=125ns 

  ![image-20210608150024225](F:\CS\picture\image-20210608150024225.png)

* Ex2 改造为pipelined circuit 加个register就行了 ，此时分别计算每个stage的时长，取最大的作为cycle time就行了，应该是10+60+10=80 ns，明显pipelined 提高了clock rate

  ![image-20210608150335091](F:\CS\picture\image-20210608150335091.png)

* pipelined有时需要bubble是因为下一条指令的input需要上一条指令的Write Back，就需要等上一条指令WB写入register更新input后才能运行下一条指令，而这里唯一的WB数据逆向传输在第二次click前已经就绪，就不再需要等待

# Lab 7

* Exercise1通过venus模拟不同情况（改变programme parameter和Cache parameter）下Cache的读写，以及观察miss、hit，这个挺简单的，根据几个parameters先算出T、I、O的值，然后就可以把整个Cache的结构画出来，miss还是hit就一目了然了
* Exercise2 矩阵乘法中三个loop中的参数ijk交换共有六种情况下，分别运行比较运行时间，这个主要从Cache的spatial locality分析每次循环的stride即可
* Exercise3 从Cache blocksize的角度对矩阵转置代码的进行优化，然后测试不同blocksize和matrix size下优化效果，分析原因，尽管不知道电脑的实际blocksize，但是只要提高了locality，运行的效率明显提高
* 注意题目给出的代码中drand48 lrand48 srand48是基于linux的系统函数，windows无法调用，除非你装虚拟机，不然的话用rand和srand改一下代码，问题不大的
