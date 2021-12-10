"""
    to_bytes(num::Number) -> Vector{UInt8}

Creates the byte array consistituting the number `num`

# Arguments
- `num::Number`: the type of the mask

# Returns
- `Vector{UInt8}`: the bytes constituting the number `num`
"""
function to_bytes(num::Number)::Vector{UInt8}
    return reinterpret(UInt8, [num])
end

"""
    from_bytes(type::Type{T}, array::A) where {A <: AbstractArray{UInt8}, T <: Number} -> T

Creates a value of type `T` constituted by the byte-array `array`

# Arguments
- `type::Type{T}`: the type to which the byte-array is transformed
- `array::A`: the byte array

# Returns
- `T`:
"""
function from_bytes(type::Type{T}, array::A)::T where
    {A <: AbstractArray{UInt8}, T <: Number}
    values = reinterpret(type, array)
    return values[1]
end
