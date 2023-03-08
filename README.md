# Math Expression Compiler using Lex and Yacc

## Overview
Lex and Yacc are two tools used together for writing compilers or interpreters for programming languages. Lex generates code for recognizing and returning tokens from input text, while Yacc generates code for recognizing and building an abstract syntax tree from the tokenized input. Together, these tools provide a powerful way to build software systems by specifying the grammar and regular expressions for the language. The abstract syntax tree is an intermediate representation of the program that can be used for further processing and integration with other software components.

## Project

This project is a compiler for a special form of math expressions using Lex and Yacc. The expressions use the following symbols:
- `:A:` as `+`
- `:S:` as `-`
- `:D:` as `/`
- `:M:` as `*`

The compiler takes input from the user and generates an output using the operator precedence rules. The priority of calculation is reversed, meaning that the result of `3 :D: 12` is equal to `4`.

## Installation and Usage

To install and use the compiler, follow these steps:

1. Clone the repository to your local machine.

2. Compile the Lex and Yacc files using the following command:

    ```
    yacc -d parser.y
    lex lexical.l
    gcc -o compiler y.tab.c lex.yy.c -lm
    ```
    
3. Run the compiler by executing the `compiler` executable.

4. Enter a math expression in the special format described above and press Enter.

5. The compiler will generate the output based on the operator precedence rules and print it to the console.

## Example
   
run the exe file in the shell or terminal and use this example to test:
```cpp    
x = 2 :M: 3 :A: 4 :D: 2 :S: 1 //input

//output
t0 = 2 / 4
t1 = 3 * 2
t2 = 1 - t0
t3 = t0 + t1
the result of x is t3 which is equal to 6.5
```

In the above example, the math expression `2 :M: 3 :A: 4 :D: 2 :S: 1` is evaluated using the compiler, and the output `7.5` is displayed on the console.

## Conclusion

This project demonstrates the use of Lex and Yacc to build a compiler for a special form of math expressions. The compiler can handle complex expressions and generate accurate outputs based on the operator precedence rules.

## Installation

1. Open your terminal or command prompt.
3. Clone the repository using the `git clone` command. For example: `git clone https://github.com/Amir-Shamsi/special-calculator-compiler.git`.
4. Navigate to the directory of the cloned repository using the `cd` command. For example: `cd special-calculator-compiler`.
5. Verify that the necessary files are present in the repository, specifically `lexical.l` and `parser.y`.
6. Install Lex and Yacc if they are not already installed on your system. You can do this by installing the `flex` and `bison` packages for Unix/Linux systems or by downloading and installing the appropriate version for your operating system from their official websites.
7. Run Lex to generate the lexical analyzer code by running the command `lex lexical.l` in your terminal. This should generate a `lex.yy.c` file in your repository.
8. Run Yacc to generate the parser code by running the command `yacc -d parser.y` in your terminal. This should generate `y.tab.c` and `y.tab.h` files in your repository.
9. Compile and link the generated code with your project's code using a compiler such as `gcc`. For example, you can compile and link the generated code with a `main.c` file by running the command `gcc -o myprogram main.c lex.yy.c y.tab.c -lfl`.
10. Run the compiled program by running the command `./myprogram`.

That's it! You should now have successfully cloned the repository and run Lex and Yacc for your project.

    
