module CANTools

include("Utils.jl")
using .Utils
export is_little_endian, is_big_endian
export mask, zero_mask, full_mask

include("Variables.jl")
using .Variables

include("Messages.jl")
using .Messages

include("Frames.jl")
using .Frames

include("Decode.jl")
using .Decode

include("Encode.jl")
using .Encode

end
