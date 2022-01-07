"""The module provides utilities to convert numbers into and from byte representations,
functions to check whether the system is little-endian or big-endian, and functions to
create bitmasks.
"""
module Utils
"""
    to_bytes(num::Number) -> Vector{UInt8}

Creates the byte representation of the number `num`.

# Arguments
- `num::Number`: the number from which we retrieve the bytes.

# Returns
- `Vector{UInt8}`: the bytes representation of the number `num`

# Examples
```jldoctest
using CANalyze.Utils
bytes = Utils.to_bytes(UInt16(0xAAFF))

# output
2-element Vector{UInt8}:
 0xff
 0xaa
```
"""
function to_bytes(num::Number)::Vector{UInt8}
    return reinterpret(UInt8, [num])
end

"""
    from_bytes(type::Type{T}, array::AbstractArray{UInt8}) where {T <: Number} -> T

Creates a value of type `T` constituted by the byte-array `array`. If the `array` length
is smaller than the size of `T`, `array` is filled with enough zeros.

# Arguments
- `type::Type{T}`: the type to which the byte-array is transformed
- `array::AbstractArray{UInt8}`: the byte array

# Returns
- `T`: the value constructed from the byte sequence

# Examples
```jldoctest
using CANalyze.Utils
bytes = Utils.from_bytes(UInt16, UInt8[0xFF, 0xAA])

# output
0xaaff
```
"""
function from_bytes(type::Type{T}, array::AbstractArray{UInt8})::T where {T <: Number}
    if length(array) < sizeof(T)
        for i=1:(sizeof(T) - length(array))
            push!(array, UInt8(0))
        end
    end

    values = reinterpret(type, array)
    return values[1]
end

"""
    is_little_endian() -> Bool

Returns whether the system has little-endian byte-order

# Returns
- `Bool`: The system has little-endian byte-order
"""
function is_little_endian()::Bool
    x::UInt16 = 0x0001
    lst = reinterpret(UInt8, [x])

    if lst[1] == 0x01
        return true
    else
        return false
    end
end

"""
    is_big_endian() -> Bool

Returns whether the system has big-endian byte-order

# Returns
- `Bool`: The system has big-endian byte-order
"""
function is_big_endian()::Bool
    return !is_little_endian()
end

"""
    mask(::Type{T}, length::UInt8, shift::UInt8) where {T <: Integer} -> T

Creates a mask of type `T` with `length` number of bits and right-shifted by `shift`
number of bits.

# Arguments
- `Type{T}`: the type of the mask
- `length::UInt8`: the number of bits
- `shift::UInt8`: the right-shift

# Returns
- `T`: the mask defined by `length` and `shift`
"""
function mask(::Type{T}, length::UInt8, shift::UInt8)::T where {T <: Integer}
    ret::T = mask(T, length)
    ret <<= shift
    return ret
end

"""
    mask(::Type{T}, length::Integer, shift::Integer) where {T <: Integer} -> T

Creates a mask of type `T` with `length` number of bits and right-shifted by `shift`
number of bits.

# Arguments
- `Type{T}`: the type of the mask
- `length::Integer`: the number of bits
- `shift::Integer`: the right-shift

# Returns
- `T`: the mask defined by `length` and `shift`

# Examples
```jldoctest
using CANalyze.Utils
m = Utils.mask(UInt64, 32, 16)

# output
0x0000ffffffff0000
```
"""
function mask(::Type{T}, length::Integer, shift::Integer)::T where {T <: Integer}
    l = convert(UInt8, length)
    s = convert(UInt8, shift)
    return mask(T, l, s)
end

"""
    mask(::Type{T}, length::UInt8) where {T <: Integer} -> T

Creates a mask of type `T` with `length` number of bits.

# Arguments
- `Type{T}`: the type of the mask
- `length::UInt8`: the number of bits

# Returns
- `T`: the mask defined by `length`
"""
function mask(::Type{T}, length::UInt8)::T where {T <: Integer}
    ret::T = zero(T)
    if length > 0
        for i in 1:(length-1)
            ret += 1
            ret <<= 1
        end
        ret += 1
    end
    return ret
end

"""
    mask(::Type{T}, length::Integer) where {T <: Integer} -> T

Creates a mask of type `T` with `length` number of bits.

# Arguments
- `Type{T}`: the type of the mask
- `length::Integer`: the number of bits

# Returns
- `T`: the mask defined by `length`

# Examples
```jldoctest
using CANalyze.Utils
m = Utils.mask(UInt64, 32)

# output
0x00000000ffffffff
```
"""
function mask(::Type{T}, length::Integer)::T where {T <: Integer}
    l = convert(UInt8, length)
    return mask(T, l)
end

"""
    mask(::Type{T}) where {T <: Integer} -> T

Creates a full mask of type `T` with `8sizeof(T)` bits.

# Arguments
- `Type{T}`: the type of the mask

# Returns
- `T`: the full mask

# Examples
```jldoctest
using CANalyze.Utils
m = Utils.mask(UInt64)

# output
0xffffffffffffffff
```
"""
function mask(::Type{T})::T where {T <: Integer}
    return full_mask(T)
end

"""
    full_mask(::Type{T}) where {T <: Integer} -> T

Creates a full mask of type `T` with `8sizeof(T)` bits.

# Arguments
- `Type{T}`: the type of the mask

# Returns
- `T`: the full mask

# Examples
```jldoctest
using CANalyze.Utils
m = Utils.full_mask(Int8)

# output
-1
```
"""
function full_mask(::Type{T})::T where {T <: Integer}
    ret::T = zero(T)
    for i in 0:(8sizeof(T) - 2)
        ret += 1
        ret <<= 1
    end
    ret += 1
    return ret
end

"""
    zero_mask(::Type{T}) where {T <: Integer} -> T

Creates a zero mask of type `T` where every bit is unset.

# Arguments
- `Type{T}`: the type of the mask

# Returns
- `T`: the zero mask

# Examples
```jldoctest
using CANalyze.Utils
m = Utils.zero_mask(UInt8)

# output
0x00
```
"""
function zero_mask(::Type{T})::T where {T <: Integer}
    return zero(T)
end

"""
    bit_mask(::Type{T}, bits::Set{UInt16}) where {T <: Integer} -> T

Creates a bit mask of type `T` where every bit inside `bits` is set.

# Arguments
- `Type{T}`: the type of the mask
- `bits::Set{UInt16}`: the set of bits we want to set

# Returns
- `T`: the mask

# Examples
```jldoctest
using CANalyze.Utils
m = Utils.bit_mask(UInt8, Set{UInt16}([0,1,2,3,4,5,6,7]))

# output
0xff
```
"""
function bit_mask(::Type{T}, bits::Set{UInt16})::T where {T <: Integer}
    result = zero(T)
    for bit in bits
        result |= mask(T, 1, bit)
    end
    return T(result)
end

function bit_mask(::Type{T}, bits::Integer...)::T where {T}
    bits = Set{UInt16}(bits)
    return bit_mask(T, bits)
end

function bit_mask(::Type{S}, bits::AbstractArray{T,N})::S where {S,T,N}
    bits = Set{UInt16}(bits)
    return bit_mask(S, bits)
end

export to_bytes, from_bytes
export is_little_endian, is_big_endian
export mask, zero_mask, full_mask, bit_mask
end
