using Base

function Base.convert(::Type{A}, value::T) where {A <: AbstractArray{UInt8,1}, T <: Integer}
    ret = reinterpret(UInt8, [value])
    return ret
end

function Base.convert(::Type{A}, value::Float16) where {A <: AbstractArray{UInt8,1}}
    ret = reinterpret(UInt8, [value])
    return ret
end

function Base.convert(::Type{A}, value::Float32) where {A <: AbstractArray{UInt8,1}}
    ret = reinterpret(UInt8, [value])
    return ret
end

function Base.convert(::Type{A}, value::Float64) where {A <: AbstractArray{UInt8,1}}
    ret = reinterpret(UInt8, [value])
    return ret
end

# function convert(::Type{T}, array::A, ::Type{LittleEndian}) where {T <: Integer, A <: AbstractArray{UInt8, 1}}
#     ret = zero(T)
#
#     len = length(array)
#     if  len > sizeof(T)
#         array = array[1:sizeof(T)]
#     elseif len < sizeof(T)
#         k = sizeof(T) - len
#         array = [array..., fill(0, k)...]
#     end
#
#     for v in array[end:-1:2]
#         ret += v
#         ret <<= 8
#     end
#
#     ret += array[1]
#     return ret
# end
#
# function convert(::Type{T}, array::A, ::Type{BigEndian}) where {T <: Integer, A <: AbstractArray{UInt8, 1}}
#     ret = zero(T)
#
#     len = length(array)
#     if  len > sizeof(T)
#         array = array[1:sizeof(T)]
#     elseif len < sizeof(T)
#         k = sizeof(T) - len
#         array = [array..., fill(0, k)...]
#     end
#
#     for v in array[1:end-1]
#         ret += v
#         ret <<= 8
#     end
#
#     ret += array[end]
#     return ret
# end
