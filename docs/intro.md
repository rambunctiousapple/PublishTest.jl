# JuliaProgrammingLanguage.jl

You read about this amazing new programming language, Julia, that is interactive like Python but compiles to efficient code like C. You wrote your first Julia program and benchmarked it
{:cell}
```julia
#using BenchmarkTools

#@info "This will be fast..."  #@info is used to print out informative messages to the user, frequently used for progress updates.

#f(x) = for i in 1:100 cos(x) end
#@benchmark f(30.0)            # @benchmark compiles the code before running it 
# so compilation overhead is not measured. It is more accurate than 
# @time which may include compile time in the measurement. 
```
Wait, what? That is slow like Python *not* fast like C, which takes X nanoseconds to execute the same function. Why?

It is because Julia solves what is called "the two programming language problem". You program in a language like Python to write code quickly but then must rewrite the code in C or a similar language to make it run fast. Now you have two code bases in two languages that must be maintained and kept in sync. This is the "two programming language problem". It is a sofware engineering headache.

How does Julia solve this problem? example here showing how some code must be inherently inefficient, unless properly type annotated or separated by function barrier.

In Julia you can write code quickly, like Python, but get speed like C. At least that is the aspiration, which is mostly achieved today. However, you must understand the limitations of the current Julia compiler or your code will be easy to write, like Python, but also *slow* like Python.

Key problems:
* users don't understand workflow. Not well documented.
* Julia supports interactive, typeless programming. When compiler can't infer types it defaults to python like generic code which is very slow. Mostly this doesn't happen but occasionally it does in a way that confuses beginners. Not uncommon to experience 20x-50x slowdown.
* The garbage collector is not fully multithreaded so if your code allocates in the most frequently executed loop there can be enormous GC overhead. Multithreaded code can be slower than single threaded code, which is rarely the case in other languages. Good multithreaded performance requires more careful programming.

multithreading example showing slowdown.

Will begin with packages rather than programming because if you jump straight into programming 
>O, that way madness lies; let me shun that;

{:cell}
```julia
@info "print a message..."
using Plots
gr()  #if don't specify a backend it defaults to something that uses a qt plugin on github. This doesn't work for obscure resons. 
plot(rand(10),rand(10))
# =>
```