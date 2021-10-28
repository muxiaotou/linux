https://mp.weixin.qq.com/s/YZX2JaR9dz5lmElcy-efOg
- 将标准输出和标注输入同时重定向到同一位置, cmd > out.log 2>&1

变量作用域：
    shell在函数当中定义的变量也是全局变量，可以在函数当中使用关键字local声明此变量为局部变量
    