module CANTools
    include("Utils.jl")
    using .Utils
    export is_little_endian, is_big_endian
    export mask, zero_mask, full_mask

    include("Frames.jl")
    using .Frames

    include("Signals.jl")
    using .Signals

    include("Messages.jl")
    using .Messages

    include("Decode.jl")
    using .Decode

    include("Encode.jl")
    using .Encode
end
