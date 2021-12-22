"""
"""
module Signals
    """
    """
    abstract type AbstractSignal{T} end

    """
    """
    struct NamedSignal{T} <: AbstractSignal{T}
        name::Union{Nothing,String}
        unit::Union{Nothing,String}
    end

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
    function start(signal::Bit)::UInt16
        return signal.start
    end

    """
    """
    struct Unsigned{T} <: AbstractFloatSignal{T}
        start::UInt16
        length::UInt16
        factor::T
        offset::T
        byte_order::Symbol
    end

    """
    """
    function Unsigned(start::Integer,
                    length::Integer,
                    factor::T,
                    offset::T;
                    byte_order::Symbol=:little_endian) where {T}

        if byte_order != :little_endian && byte_order != :big_endian
            byte_order = :little_endian
        end

        if length == 0
            throw(DomainError(length, "The length has to be greater or equal to 1"))
        end

        return Unsigned{T}(
                convert(UInt16, start),
                convert(UInt16, length),
                factor,
                offset,
                byte_order
        )
    end

    """
    """
    function Unsigned(; start::Integer,
                      length::Integer,
                      factor::T,
                      offset::T,
                      byte_order::Symbol=:little_endian) where {T}
        return Unsigned(start, length, factor, offset; byte_order=byte_order)
    end

    """
    """
    function start(signal::Unsigned{T})::UInt16 where {T}
        return signal.start
    end

    """
    """
    function length(signal::Unsigned{T})::UInt16 where {T}
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

    struct Signed{T} <: AbstractFloatSignal{T}
        start::UInt16
        length::UInt16
        factor::T
        offset::T
        byte_order::Symbol
    end

    function Signed(start::Integer,
                    length::Integer;
                    factor::T=one(T),
                    offset::T=zero(T),
                    byte_order::Symbol=:little_endian) where {T}

        if byte_order != :little_endian && byte_order != :big_endian
            byte_order = :little_endian
        end

        if length == 0
            throw(DomainError(length, "The length has to be greater or equal to 1"))
        end

        return Signed{T}(
                convert(UInt16, start),
                convert(UInt16, length),
                factor,
                offset,
                byte_order
        )
    end

    """
    """
    function Signed(; start::Integer,
                      length::Integer,
                      factor::T=one(T),
                      offset::T=zero(T),
                      byte_order::Symbol=:little_endian) where {T}
        return Signed(start, length, factor=factor, offset=offset, byte_order=byte_order)
    end

    """
    """
    function start(signal::Signed{T})::UInt16 where {T}
        return signal.start
    end

    """
    """
    function length(signal::Signed{T})::UInt16 where {T}
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
    function Signal(start::Integer,
                    length::Integer;
                    factor::T=one(T),
                    offset::T=zero(T),
                    signed::Bool=false,
                    byte_order::Symbol=:little_endian)::Union{Unsigned{T},
                                                              Signed{T}} where {T}
        if signed
            return Signed(start, length,
                          factor=factor,
                          offset=offset,
                          byte_order=byte_order)
        else
            return Unsigned(start, length,
                            factor=factor,
                            offset=factor,
                            byte_order=byte_order)
        end
    end

    """
    """
    function Signal(; start::Integer,
                    length::Integer,
                    factor::T=one(T),
                    offset::T=zero(T),
                    signed::Bool=false,
                    byte_order::Symbol=:little_endian) where {T}
        return Signal(start, length,
                      factor=factor,
                      offset=offset,
                      signed=signed,
                      byte_order=byte_order)
    end

    """
    """
    struct Float{T} <: AbstractFloatSignal{T}
        start::UInt16
        factor::T
        offset::T
        byte_order::Symbol
    end

    """
    """
    function Float(start::Integer,
                         factor::T,
                         offset::T;
                         byte_order::Symbol=:little_endian) where {T}
        start = convert(UInt16, start)
        return Float{T}(start, factor, offset, byte_order)
    end

    """
    """
    function Float(; start::Integer,
                     factor::T,
                     offset::T,
                     byte_order::Symbol=:little_endian) where {T}
        return Float(start, factor, offset; byte_order=byte_order)
    end

    """
    """
    function start(signal::Float{T})::UInt16 where {T}
        return signal.start
    end

    """
    """
    function factor(signal::Float{T})::T where {T}
        return signal.factor
    end

    """
    """
    function offset(signal::Float{T})::T where {T}
        return signal.offset
    end

    """
    """
    function byte_order(signal::Float{T})::Symbol where {T}
        return signal.byte_order
    end

    """
    """
    struct Raw <: AbstractIntegerSignal{UInt64}
        start::UInt16
        length::UInt16
        byte_order::Symbol
    end

    """
    """
    function Raw(start::Integer,
                 length::Integer;
                 byte_order::Symbol=:little_endian) where {T}
        start  = convert(UInt16, start)
        length = convert(UInt16, length)
        return Raw(start, length, byte_order)
    end

    """
    """
    function Raw(; start::Integer,
                   length::Integer,
                   byte_order::Symbol=:little_endian) where {T}
        return Raw(start, length; byte_order=byte_order)
    end


    """
    """
    function start(signal::Raw)::UInt16
        return signal.start
    end

    """
    """
    function length(signal::Raw)::UInt16
        return signal.length
    end

    """
    """
    function byte_order(signal::Raw)::Symbol
        return signal.byte_order
    end
end
