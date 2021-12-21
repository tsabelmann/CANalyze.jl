"""
    mask(::Type{T}, length::UInt8, shift::UInt8) where {T <: Unsigned} -> T

Creates a mask of type `T` with `length` number of bits and right-shifted by `shift` number
of bits

# Arguments
- `Type{T}`: the type of the mask
- `length::UInt8`: the number of bits
- `shift::UInt8`: the right-shift

# Returns
- `T`: the mask defined by `length` and `shift`
"""
function mask(::Type{T}, length::UInt8, shift::UInt8)::T where {T <: Integer}
    ret = mask(T, length)
    ret <<= shift
    return T(ret)
end

"""
    mask(::Type{T}, length::Integer, shift::Integer) where {T <: Unsigned} -> T

Creates a mask of type `T` with `length` number of bits and right-shifted by `shift` number
of bits

# Arguments
- `Type{T}`: the type of the mask
- `length::Integer`: the number of bits
- `shift::Integer`: the right-shift

# Returns
- `T`: the mask defined by `length` and `shift`
"""
function mask(::Type{T}, length::Integer, shift::Integer)::T where {T <: Integer}
    l = convert(UInt8, length)
    s = convert(UInt8, shift)
    return mask(T, l, s)
end

"""
    mask(::Type{T}, length::UInt8) where {T <: Unsigned} -> T

Creates a mask of type `T` with `length` number of bits

# Arguments
- `Type{T}`: the type of the mask
- `length::UInt8`: the number of bits

# Returns
- `T`: the mask defined by `length`
"""
function mask(::Type{T}, length::UInt8)::T where {T <: Integer}
    ret = zero(T)
    if length > 0
        for i in 1:(length-1)
            ret += 1
            ret <<= 1
        end
        ret += 1
    end
    return T(ret)
end

"""
    mask(::Type{T}, length::Integer) where {T <: Unsigned} -> T

Creates a mask of type `T` with `length` number of bits

# Arguments
- `Type{T}`: the type of the mask
- `length::Integer`: the number of bits

# Returns
- `T`: the mask defined by `length`
"""
function mask(::Type{T}, length::Integer)::T where {T <: Integer}
    l = convert(UInt8, length)
    return mask(T, l)
end

"""
    mask(::Type{T}) where {T <: Unsigned} -> T

Creates a full mask of type `T`

# Arguments
- `Type{T}`: the type of the mask

# Returns
- `T`: the full mask
"""
function mask(::Type{T})::T where {T <: Integer}
    return full_mask(T)
end

"""
    full_mask(::Type{T}) where {T <: Unsigned} -> T

Creates a full mask of type `T`

# Arguments
- `Type{T}`: the type of the mask

# Returns
- `T`: the full mask
"""
function full_mask(::Type{T})::T where {T <: Integer}
    ret = zero(T)
    for i in 0:(8sizeof(T) - 2)
        ret += 1
        ret <<= 1
    end
    ret += 1
    return ret
end

"""
    zero_mask(::Type{T}) where {T <: Unsigned} -> T

Creates a zero mask of type `T`

# Arguments
- `Type{T}`: the type of the mask

# Returns
- `T`: the zero mask
"""
function zero_mask(::Type{T})::T where {T <: Integer}
    return zero(T)
end
