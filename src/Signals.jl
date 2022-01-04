"""The module provides signals, a mechanism that models data retrievable from or
written to CAN-bus data. A signal models one data entity, e.g., one variable inside the
CAN-bus data.
"""
module Signals
import Base

"""
"""
abstract type AbstractSignal{T} end

"""
"""
abstract type UnnamedSignal{T} <: AbstractSignal{T} end

"""
"""
abstract type AbstractIntegerSignal{T <: Integer} <: UnnamedSignal{T} end

"""
"""
abstract type AbstractFloatSignal{T <: AbstractFloat} <: UnnamedSignal{T} end

"""
"""
struct Bit <: AbstractIntegerSignal{Bool}
    start::UInt16
end

"""
"""
function Bit(start::Integer)
    start = convert(UInt16, start)
    return Bit(start)
end

"""
"""
function Bit(; start::Integer=0)
    return Bit(start)
end

"""
"""
function start(signal::Bit)::UInt16
    return signal.start
end

"""
"""
function Base.length(signal::Bit)::UInt16
    return 1
end

"""
"""
function byte_order(signal::Bit)::Symbol
    return :little_endian
end

"""
"""
function Base.:(==)(lhs::Bit, rhs::Bit)
    return start(lhs) == start(rhs)
end

"""
"""
struct Unsigned{T} <: AbstractFloatSignal{T}
    start::UInt16
    length::UInt16
    factor::T
    offset::T
    byte_order::Symbol

    """
    """
    function Unsigned(start::UInt16,
                      length::UInt16,
                      factor::T,
                      offset::T,
                      byte_order::Symbol) where {T <: AbstractFloat}
          if byte_order != :little_endian && byte_order != :big_endian
              throw(DomainError(byte_order, "Byte order not supported"))
          end

          if length == 0
              throw(DomainError(length, "The length has to be greater or equal to 1"))
          end

          return new{T}(start, length, factor, offset, byte_order)
    end
end

"""
"""
function Unsigned(start::Integer,
                  length::Integer,
                  factor::Union{Integer, AbstractFloat},
                  offset::Union{Integer, AbstractFloat},
                  byte_order::Symbol)
    start = convert(UInt16, start)
    length = convert(UInt16, length)
    if factor isa Integer && offset isa Integer
        factor = convert(Float64, factor)
        offset = convert(Float64, offset)
    else
        factor, offset = promote(factor, offset)
    end
    return Unsigned(start, length, factor, offset, byte_order)
end

"""
"""
function Unsigned(; start::Integer,
                    length::Integer,
                    factor::Union{Integer, AbstractFloat},
                    offset::Union{Integer, AbstractFloat},
                    byte_order::Symbol=:little_endian)
    return Unsigned(start, length, factor, offset, byte_order)
end


"""
"""
function Unsigned{T}(start::Integer,
                length::Integer;
                factor::Union{Integer, AbstractFloat}=one(T),
                offset::Union{Integer, AbstractFloat}=zero(T),
                byte_order::Symbol=:little_endian) where {T}
    factor = convert(T, factor)
    offset = convert(T, offset)
    return Unsigned(start, length, factor, offset, byte_order)
end

"""
"""
function Unsigned{T}(; start::Integer,
                       length::Integer,
                       factor::Union{Integer, AbstractFloat}=one(T),
                       offset::Union{Integer, AbstractFloat}=zero(T),
                       byte_order::Symbol=:little_endian) where {T}
    factor = convert(T, factor)
    offset = convert(T, offset)
    return Unsigned(start, length, factor, offset, byte_order)
end

"""
"""
function start(signal::Unsigned{T})::UInt16 where {T}
    return signal.start
end

"""
"""
function Base.length(signal::Unsigned{T})::UInt16 where {T}
    return signal.length
end

"""
"""
function factor(signal::Unsigned{T})::T where {T}
    return signal.factor
end

"""
"""
function offset(signal::Unsigned{T})::T where {T}
    return signal.offset
end

"""
"""
function byte_order(signal::Unsigned{T})::Symbol where {T}
    return signal.byte_order
end

"""
"""
function Base.:(==)(lhs::F, rhs::F) where {T, F <: AbstractFloatSignal{T}}
    if start(lhs) != start(rhs)
        return false
    end

    if length(lhs) != length(rhs)
        return false
    end

    if factor(lhs) != factor(rhs)
        return false
    end

    if offset(lhs) != offset(rhs)
        return false
    end

    if byte_order(lhs) != byte_order(rhs)
        return false
    end

    return true
end

struct Signed{T} <: AbstractFloatSignal{T}
    start::UInt16
    length::UInt16
    factor::T
    offset::T
    byte_order::Symbol

    function Signed(start::UInt16,
                    length::UInt16,
                    factor::T,
                    offset::T,
                    byte_order::Symbol) where {T <: AbstractFloat}
        if byte_order != :little_endian && byte_order != :big_endian
            throw(DomainError(byte_order, "Byte order not supported"))
        end

        if length == 0
            throw(DomainError(length, "The length has to be greater or equal to 1"))
        end

        return new{T}(start, length, factor, offset, byte_order)
    end
end

"""
"""
function Signed(start::Integer,
                length::Integer,
                factor::Union{Integer, AbstractFloat},
                offset::Union{Integer, AbstractFloat},
                byte_order::Symbol)
    start = convert(UInt16, start)
    length = convert(UInt16, length)
    if factor isa Integer && offset isa Integer
        factor = convert(Float64, factor)
        offset = convert(Float64, offset)
    else
        factor, offset = promote(factor, offset)
    end
    return Signed(start, length, factor, offset, byte_order)
end

"""
"""
function Signed(; start::Integer,
                  length::Integer,
                  factor::Union{Integer, AbstractFloat},
                  offset::Union{Integer, AbstractFloat},
                  byte_order::Symbol=:little_endian)
    return Signed(start, length, factor, offset, byte_order)
end

"""
"""
function Signed{T}(start::Integer,
                   length::Integer;
                   factor::Union{Integer, AbstractFloat}=one(T),
                   offset::Union{Integer, AbstractFloat}=zero(T),
                   byte_order::Symbol=:little_endian) where {T}
    factor = convert(T, factor)
    offset = convert(T, offset)
    return Signed(start, length, factor, offset, byte_order)
end

"""
"""
function Signed{T}(; start::Integer,
                     length::Integer,
                     factor::Union{Integer, AbstractFloat}=one(T),
                     offset::Union{Integer, AbstractFloat}=zero(T),
                     byte_order::Symbol=:little_endian) where {T}
    factor = convert(T, factor)
    offset = convert(T, offset)
    return Signed(start, length, factor, offset, byte_order)
end

"""
"""
function start(signal::Signed{T})::UInt16 where {T}
    return signal.start
end

"""
"""
function Base.length(signal::Signed{T})::UInt16 where {T}
    return signal.length
end

"""
"""
function factor(signal::Signed{T})::T where {T}
    return signal.factor
end

"""
"""
function offset(signal::Signed{T})::T where {T}
    return signal.offset
end

"""
"""
function byte_order(signal::Signed{T})::Symbol where {T}
    return signal.byte_order
end

"""
"""
struct FloatSignal{T} <: AbstractFloatSignal{T}
    start::UInt16
    factor::T
    offset::T
    byte_order::Symbol

    function FloatSignal(start::UInt16, factor::T, offset::T,
                         byte_order::Symbol) where {T <: AbstractFloat}
        new{T}(start, factor, offset, byte_order)
    end
end

"""
"""
function FloatSignal(start::Integer,
                     factor::Union{Integer,AbstractFloat},
                     offset::Union{Integer,AbstractFloat},
                     byte_order::Symbol)
    start = convert(UInt16, start)
    if factor isa Integer && offset isa Integer
        factor = convert(Float64, factor)
        offset = convert(Float64, offset)
    else
        factor, offset = promote(factor, offset)
    end
    return FloatSignal(start, factor, offset, byte_order)
end

"""
"""
function FloatSignal(; start::Integer,
                       factor::Union{Integer,AbstractFloat},
                       offset::Union{Integer,AbstractFloat},
                       byte_order::Symbol)
    return FloatSignal(start, factor, offset, byte_order)
end

"""
"""
function FloatSignal{T}(start::Integer;
                        factor::Union{Integer,AbstractFloat}=one(T),
                        offset::Union{Integer,AbstractFloat}=zero(T),
                        byte_order::Symbol=:little_endian) where {T}
    factor = convert(T, factor)
    offset = convert(T, offset)
    return FloatSignal(start, factor, offset, byte_order)
end

function FloatSignal{T}(; start::Integer,
                          factor::Union{Integer,AbstractFloat}=one(T),
                          offset::Union{Integer,AbstractFloat}=zero(T),
                          byte_order::Symbol=:little_endian) where {T}
    factor = convert(T, factor)
    offset = convert(T, offset)
    return FloatSignal(start, factor, offset, byte_order)
end

const Float16Signal = FloatSignal{Float16}
const Float32Signal = FloatSignal{Float32}
const Float64Signal = FloatSignal{Float64}

"""
"""
function start(signal::FloatSignal{T})::UInt16 where {T}
    return signal.start
end

function Base.length(signal::FloatSignal{T})::UInt16 where {T}
    return 8sizeof(T)
end

"""
"""
function factor(signal::FloatSignal{T})::T where {T}
    return signal.factor
end

"""
"""
function offset(signal::FloatSignal{T})::T where {T}
    return signal.offset
end

"""
"""
function byte_order(signal::FloatSignal{T})::Symbol where {T}
    return signal.byte_order
end

"""
"""
struct Raw <: AbstractIntegerSignal{UInt64}
    start::UInt16
    length::UInt16
    byte_order::Symbol

    """
    """
    function Raw(start::UInt16, length::UInt16,byte_order::Symbol)
        if length == 0
            throw(DomainError(length, "The length has to be greater or equal to 1"))
        end

        if byte_order != :little_endian && byte_order != :big_endian
            throw(DomainError(byte_order, "Byte order not supported"))
        end

        return new(start, length, byte_order)
    end
end

"""
"""
function Raw(start::Integer, length::Integer, byte_order::Symbol)
    start = convert(UInt16, start)
    length = convert(UInt16, length)
    return Raw(start, length, byte_order)
end


"""
"""
function Raw(; start::Integer,
               length::Integer,
               byte_order::Symbol=:little_endian) where {T}
    return Raw(start, length, byte_order)
end


"""
"""
function start(signal::Raw)::UInt16
    return signal.start
end

"""
"""
function Base.length(signal::Raw)::UInt16
    return signal.length
end

"""
"""
function byte_order(signal::Raw)::Symbol
    return signal.byte_order
end

"""
"""
struct NamedSignal{T} <: AbstractSignal{T}
    name::String
    unit::Union{Nothing,String}
    default::Union{Nothing,T}
    signal::UnnamedSignal{T}

    function NamedSignal(name::String,
                         unit::Union{Nothing,String},
                         default::Union{Nothing,T},
                         signal::UnnamedSignal{T}) where {T}
        if name == ""
            throw(DomainError(name, "name cannot be the empty string"))
        end

        return new{T}(name, unit, default, signal)
    end
end

"""
"""
function NamedSignal(name::String;
                     unit::Union{Nothing,String}=nothing,
                     default::Union{Nothing,T}=nothing,
                     signal::UnnamedSignal{T}) where {T}
    return NamedSignal(name, unit, default, signal)
end

"""
"""
function NamedSignal(; name::String,
                     unit::Union{Nothing,String}=nothing,
                     default::Union{Nothing,T}=nothing,
                     signal::UnnamedSignal{T}) where {T}
    return NamedSignal(name, unit, default, signal)
end

"""
"""
function name(signal::NamedSignal{T})::String where {T}
    return signal.name
end

"""
"""
function unit(signal::NamedSignal{T})::Union{Nothing,String} where {T}
    return signal.unit
end

"""
"""
function default(signal::NamedSignal{T})::Union{Nothing,T} where {T}
    return signal.default
end

"""
"""
function signal(signal::NamedSignal{T})::UnnamedSignal{T} where {T}
    return signal.signal
end

const Signal = NamedSignal

"""
"""
struct Bits
    bits::Set{UInt16}
end

"""
"""
function Bits(bits::Integer...)
    Bits(Set(UInt16[bits...]))
end

"""
"""
function Bits(signal::AbstractFloatSignal{T}) where {T}
    bits = Set{UInt16}()
    start_bit = start(signal)
    if byte_order(signal) == :little_endian
        for i=0:length(signal)-1
            bit_pos = start_bit + i
            push!(bits, bit_pos)
        end
    elseif byte_order(signal) == :big_endian
        for j=0:length(signal)-1
            push!(bits, start_bit)
            if start_bit % 8 == 0
                start_byte = div(start_bit,8)
                start_bit = 8 * (start_byte + 1) + 7
            else
                start_bit -= 1
            end
        end
    end
    return Bits(bits)
end

"""
"""
function Bits(signal::AbstractIntegerSignal{T}) where {T}
    bits = Set{UInt16}()
    start_bit = start(signal)
    if byte_order(signal) == :little_endian
        for i=0:length(signal)-1
            bit_pos = start_bit + i
            push!(bits, bit_pos)
        end
    elseif byte_order(signal) == :big_endian
        for j=0:length(signal)-1
            push!(bits, start_bit)
            if start_bit % 8 == 0
                start_byte = div(start_bit,8)
                start_bit = 8 * (start_byte + 1) + 7
            else
                start_bit -= 1
            end
        end
    end
    return Bits(bits)
end

function Bits(sig::NamedSignal{T}) where {T}
    return Bits(signal(sig))
end

"""
"""
function share_bits(lhs::Bits, rhs::Bits)::Bool
    return !isdisjoint(lhs.bits, rhs.bits)
end

"""
"""
function overlap(lhs::AbstractSignal{R}, rhs::AbstractSignal{S})::Bool where {R,S}
    lhs_bits = Bits(lhs)
    rhs_bits = Bits(rhs)
    return share_bits(lhs_bits, rhs_bits)
end

function check(signal::AbstractFloatSignal{T}, available_bytes::UInt8)::Bool where {T}
    if byte_order(signal) == :little_endian
        if start(signal) + length(signal) - 1 >= 8*available_bytes
            return false
        else
            return true
        end
    elseif byte_order(signal) == :big_endian
        start_bit_in_byte = start(signal) % 8
        start_byte = div(start(signal), 8)

        if start_bit_in_byte != 7 && start_bit_in_byte != 0
            start_bit = 8*start_byte + (7 - start_bit_in_byte)
        else
            start_bit = start(signal)
        end

        new_shift = 8*available_bytes - start_bit - length(signal)
        if new_shift < 0
            return false
        end

        return true
    else
        return false
    end
end

"""
"""
function check(signal::AbstractIntegerSignal{T}, available_bytes::UInt8)::Bool where {T}
    if byte_order(signal) == :little_endian
        if start(signal) + length(signal) - 1 >= 8*available_bytes
            return false
        else
            return true
        end
    elseif byte_order(signal) == :big_endian
        start_bit_in_byte = start(signal) % 8
        start_byte = div(start(signal), 8)


        if start_bit_in_byte != 7 && start_bit_in_byte != 0
            start_bit = 8*start_byte + (7 - start_bit_in_byte)
        else
            start_bit = start(signal)
        end

        new_shift = 8*available_bytes - start_bit - length(signal)
        if new_shift < 0
            return false
        end

        return true
    else
        return false
    end
end

"""
"""
function check(sig::NamedSignal{T}, available_bytes::UInt8)::Bool where {T}
    return check(signal(sig), available_bytes)
end

export Bit, Unsigned, Signed, Raw, Float16Signal, Float32Signal, Float64Signal
export Signal, FloatSignal
export NamedSignal
export start, factor, offset, byte_order
export name, unit, default, signal
end
