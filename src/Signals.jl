module Signals

    abstract type AbstractSignal{T} end

    struct NamedSignal{T} <: AbstractSignal{T}
        name::Union{Nothing,String}
        unit::Union{Nothing,String}
    end

    abstract type UnnamedSignal{T} <: AbstractSignal{T} end

    abstract type IntegerSignal{T <: Integer} <: UnnamedSignal{T} end

    abstract type FloatSignal{T <: AbstractFloat} <: UnnamedSignal{T} end

    struct Bit <: IntegerSignal{Bool}
        start::UInt16
    end

    function Bit(start::Integer)
        return Bit(convert(UInt16, start))
    end

    function start(signal::Bit)::UInt16
        return signal.start
    end

    struct Signal{T} <: FloatSignal{T}
        start::UInt16
        length::UInt16
        factor::T
        offset::T
        signed::Bool
        byte_order::Symbol
    end

    function Signal(start::Integer,
                    length::Integer,
                    factor::T,
                    offset::T;
                    signed::Bool=False,
                    byte_order::Symbol=:little_endian) where {T}

        if byte_order != :little_endian && byte_order != :big_endian
            byte_order = :little_endian
        end

        if length == 0
            throw(DomainError(length, "The length has to be greater or equal to 1"))
        end

        return Signal{T}(
                convert(UInt16, start),
                convert(UInt16, length),
                factor,
                offset,
                signed,
                byte_order
        )
    end

    """
    """
    function start(signal::Signal{T})::UInt16 where {T}
        return signal.start
    end

    """
    """
    function length(signal::Signal{T})::UInt16 where {T}
        return signal.length
    end

    """
    """
    function factor(signal::Signal{T})::T where {T}
        return signal.factor
    end

    """
    """
    function offset(signal::Signal{T})::T where {T}
        return signal.offset
    end

    """
    """
    function signed(signal::Signal{T})::Bool where {T}
        return signal.signed
    end

    """
    """
    function unsigned(signal::Signal{T})::Bool where {T}
        return !signal.signed
    end

    """
    """
    function byte_order(signal::Signal{T})::Symbol where {T}
        return signal.byte_order
    end
end
