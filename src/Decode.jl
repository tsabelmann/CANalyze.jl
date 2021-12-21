"""
"""
module Decode
    import ..Utils
    import ..Frames
    import ..Signals
    import ..Messages


    """
    """
    function decode(signal::Signals.Bit, data::Frames.CANFrame)::Bool
        start_bit = Signals.start(signal)
        start_byte = div(start_bit, 8)

        if start_byte >= Frames.dlc(data)
            throw(DomainError(start_bit, "CANFrame does not have data at bit position"))
        else
            mask = Utils.mask(UInt64, 1, start_bit)
            value = Utils.from_bytes(UInt64, Frames.data(data))
            if mask & value != 0
                return true
            else
                return false
            end
        end
    end

    """
    """
    function decode(signal::Signals.Bit,
                    data::Frames.CANFrame,
                    default::T)::Union{Bool,T} where {T}
        try
            return decode(signal, data)
        catch
            return default
        end
    end

    """
    """
    function decode(signal::Signals.Signal{T}, data::Frames.CANFrame) where {T}
        byte_order = Signals.byte_order(signal)
        signed = Signals.signed(signal)

        if byte_order == :little_endian
            start = Signals.start(signal)
            length = Signals.length(signal)
            factor = Signals.factor(signal)
            offset = Signals.offset(signal)

            if start >= 8*Frames.dlc(data)
                throw(DomainError())
            end

            if start + length - 1 >= 8 * Frames.dlc(data)
                throw(DomainError())
            end

            if signed
                value = Utils.from_bytes(Int64, Frames.data(data))
            else
                value = Utils.from_bytes(UInt64, Frames.data(data))
            end

            value = value >> start

            if signed
                value = value & Utils.mask(Int64, length)
                # sign extend value if most-significant bit is 1
                if (value >> (length - 1)) & 0x01 != 0
                    value = value + ~Utils.mask(Int64, length)
                end
            else
                value = value & Utils.mask(UInt64, length)
            end

            result = factor * value + offset
            return result
        elseif byte_order == :big_endian

        else
            throw(DomainError(byte_order, "Byte order not supported"))
        end
    end
end
