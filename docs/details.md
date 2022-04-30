# Details

{:cell}
```julia
#@info "print a message..."
#using Plots
#gr()  #if don't specify a backend it defaults to something that uses a qt plugin on github. This doesn't work for obscure resons. 
#plot(rand(10),rand(10))
# 
```
{:cell}
```julia
using UnicodePlots

histogram(randn(1_000) .* .1, nbins=15, closed=:left)
```
{:cell}
```julia
using UnicodePlots

plt = lineplot([-1, 2, 3, 7], [-1, 2, 9, 4],
               title="Example Plot", name="my line", xlabel="x", ylabel="y")
```

{:cell}
```julia
using UnicodePlots

histogram(randn(1_000_000) .* .1, nbins=100, vertical=true)
```

{:cell}
```julia
using UnicodePlots

heatmap(collect(0:30) * collect(0:30)', xfact=.1, yfact=.1, xoffset=-1.5, colormap=:inferno)
```

