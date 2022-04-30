# Heading ->

{:cell}
```julia
@info "print a message..."
using Plots
gr()  #if don't specify a backend it defaults to something that uses a qt plugin on github. This doesn't work for obscure resons. 
plot(rand(10),rand(10))
# =>
```