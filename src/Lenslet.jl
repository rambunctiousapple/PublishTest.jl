# # Main module

# *This is the principle module of the system*

# !!! info "Main stuff"
#     5 spaces of indentation required for markdown to include text as part of the info block
#     This is info text
#     why isn't this showing up
module Lenslet

# ## Imports

using Unitful
using Unitful.DefaultSymbols
using Plots


# !!! info "Literate Programming"
#
#     These source file only make use of literate features as a test case for
#     the package. They should not be thought of as a showcase for literate
#     programming itself.

"""
This is to demonstrate doc of an abstract type
"""
abstract type TestType end

"""
this struct is to demonstrate ability of Publish to document structs

more doc
"""
struct ThisIsAStruct
    a::Float64
end
export ThisIsAStruct

"""
Don't put text on same line as the three quote marks or won't display properly in Publish.jl autogenerated text 
computes focal length
"""
focal_length(ppd,pixel_pitch) = uconvert(mm,pixel_pitch/(2*tand(1/(2*ppd))))
export focal_length

"""
max f number
"""
max_f_number(eye_relief,eyebox_size) = minimum(eye_relief ./ eyebox_size)
export max_f_number

"""
angles this updates in real time
"""
angles(eyebox,eye_relief) = @. 2 * atand(.5 * (eyebox / eye_relief))
export angles

"""
glob function
"""
glob(a::Float64) = a*2

"""
computes display area
"""
display_area(eye_relief,fov) = reduce(*,@. 2*eye_relief*tan(fov/2))
export display_area

"""
computes display size
"""
lenslet_display_size(pixel_pitch,ppd,eyebox_angles) = @. uconvert(mm,pixel_pitch * ppd * eyebox_angles)
export lenslet_display_size
function display_fraction(pixel_pitch,ppd,eyebox_size,eye_relief,fnumber)
    eyeboxangles = angles(eyebox_size,eye_relief)
    minlenssize = lenslet_display_size(pixel_pitch,ppd,eyeboxangles)
    fl = focal_length(ppd,pixel_pitch)
    println("f# $(fl ./ minlenssize)")
end
export display_fraction

##not verified
"""
private function
"""
function silicon_area(eye_relief,fov,eyebox_size,fnum) 
    area = display_area(eye_relief,fov)
    maxf = max_f_number(eye_relief,eyebox_size)
    if fnum < maxf
        maxf = fnum
    end
    return area/(maxf^2)
end

"""
will this show up?
"""
function plot_values()
    eyebox = 10mm
    ppd = 40

    relief_range = 10mm:1mm:100mm
    pitch_range = .7??m:.2??m:2??m
    result = Matrix{Float64}(undef,length(relief_range),length(pitch_range))

    for (col,pixel_pitch) in enumerate(pitch_range),(row,eye_relief) in enumerate(relief_range)
        maxfnum = max_f_number(eye_relief,eyebox)

        result[row,col] = abs(maxfnum)
     end

    heatmap(ustrip.(??m, pitch_range), ustrip.(mm,relief_range),result,
    c=cgrad([:blue, :white,:red, :yellow]),
    xlabel="pixel pitch", ylabel="eye relief",
    title="F number",margin = 12*Plots.mm,legendlabel = "f#")
    
end
export plot_values


##constraints: 
end # module  need ## for a comment starting at the beginning of a line but comments in the middle of a line can use #
export Lenslet