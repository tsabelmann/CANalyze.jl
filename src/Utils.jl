module Utils
    include("Endian.jl")
    export is_little_endian, is_big_endian

    include("Mask.jl")
    export mask, zero_mask, full_mask
end
