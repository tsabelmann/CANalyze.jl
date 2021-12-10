"""
"""
function to_bytes(num::Number)::Vector{UInt8}
    return reinterpret(UInt8, [num])
end

"""
"""
function from_bytes(array::A, type::Type{T}) where {A <: AbstractArray{UInt8}, T <: Number}
    values = reinterpret(type, array)
    return values[1]
end
