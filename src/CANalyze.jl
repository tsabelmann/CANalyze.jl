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
