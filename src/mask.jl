"""

"""
function mask(::Type{T}, length::UInt8, shift::UInt8) where {T <: Unsigned}
    ret = mask(T, length)
    ret <<= shift
    return T(ret)
end

"""
"""
function mask(::Type{T}, length::S1, shift::S2) where
    {T <: Unsigned, S1 <: Integer, S2 <: Integer}

    l = convert(UInt8, length)
    s = convert(UInt8, shift)
    return mask(T, l, s)
end

"""
"""
function mask(::Type{T}, length::UInt8) where {T <: Unsigned}
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
"""
function mask(::Type{T}, length::S) where {T <: Unsigned, S <: Integer}
    l = convert(UInt8, length)
    return mask(T, l)
end

function mask(::Type{T}) where {T <: Unsigned}
    return full_mask(T)
end

"""
"""
function full_mask(::Type{T}) where {T <: Unsigned}
    ret = zero(T)
    for i in 0:(8sizeof(T) - 2)
        ret += 1
        ret <<= 1
    end
    ret += 1
    return ret
end

"""
    zero
"""
function zero_mask(::Type{T}) where {T <: Unsigned}
    return zero(T)
end
