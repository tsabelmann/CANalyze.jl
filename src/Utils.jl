module Utils
    include("endian.jl")
    export is_little_endian, is_big_endian

    include("mask.jl")
    export mask, zero_mask, full_mask

    include("convert.jl")
    export to_bytes, from_bytes
end
