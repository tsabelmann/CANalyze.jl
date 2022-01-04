"""The module provides utilities to analyze CAN-bus data using databases consisting of
messages, which in turn consist of signals. Signals can be used to decode one value from
CAN-bus data whereas messages support allow the decoding of multiple signals.
"""
module CANalyze
include("Utils.jl")
using .Utils

include("Frames.jl")
using .Frames

include("Signals.jl")
using .Signals

include("Messages.jl")
using .Messages

include("Databases.jl")
using .Databases

include("Decode.jl")
using .Decode

include("Encode.jl")
using .Encode

include("IO.jl")
using .IO
end
