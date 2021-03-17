function mask(::Type{T}, length::UInt8, shift::UInt8) where {T <: Unsigned}
    ret = mask(T, length)
    ret <<= shift
    return ret
end

function mask(::Type{T}, length::UInt8) where {T <: Unsigned}
    ret = zero(T)
    for i in 1:(length-1)
        ret += 1
        ret <<= 1
    end
    ret += 1
    return ret
end

function mask(::Type{T}) where {T <: Unsigned}
    return full_mask(T)
end

function full_mask(::Type{T}) where {T <: Unsigned}
    ret = zero(T)
    for i in 0:(8sizeof(T) - 2)
        ret += 1
        ret <<= 1
    end
    ret += 1
    return ret
end

function zero_mask(::Type{T}) where {T <: Unsigned}
    return zero(T)
end
