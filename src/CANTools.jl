module CANTools

include("Utils.jl")
using .Utils
export is_little_endian, is_big_endian
export mask, zero_mask, full_mask

include("Variable.jl")
using .Variable

include("Message.jl")
using .Message

include("Frame.jl")
using .Frame

end
