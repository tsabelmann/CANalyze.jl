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
    function decode(signal::Signals.Unsigned{T}, data::Frames.CANFrame) where {T}
        start = Signals.start(signal)
        length = Signals.length(signal)
        factor = Signals.factor(signal)
        offset = Signals.offset(signal)
        byte_order = Signals.byte_order(signal)

        if byte_order == :little_endian
            if start >= 8*Frames.dlc(data)
                throw(DomainError())
            end

            if start + length - 1 >= 8 * Frames.dlc(data)
                throw(DomainError())
            end

            value = Utils.from_bytes(UInt64, Frames.data(data))
            value = value >> start
        elseif byte_order == :big_endian
            start_bit_in_byte = start % 8
            start_byte = div(start, 8)
            start = 8*start_byte + (7 - start_bit_in_byte)
            new_shift = 8Frames.dlc(data) - start - length
            if new_shift < 0
                throw(DomainError(new_shift, "The bits cannot be selected"))
            end

            value = Utils.from_bytes(UInt64, reverse(Frames.data(data)))
            value = value >> new_shift
        else
            throw(DomainError(byte_order, "Byte order not supported"))
        end

        value = value & Utils.mask(UInt64, length)
        result = factor * value + offset
        return result
    end

    function decode(signal::Signals.Signed{T}, data::Frames.CANFrame) where {T}
        start = Signals.start(signal)
        length = Signals.length(signal)
        factor = Signals.factor(signal)
        offset = Signals.offset(signal)
        byte_order = Signals.byte_order(signal)

        if byte_order == :little_endian
            if start >= 8*Frames.dlc(data)
                throw(DomainError())
            end

            if start + length - 1 >= 8 * Frames.dlc(data)
                throw(DomainError())
            end

            value = Utils.from_bytes(Int64, Frames.data(data))
            value = value >> start
        elseif byte_order == :big_endian
            start_bit_in_byte = start % 8
            start_byte = div(start, 8)
            start = 8*start_byte + (7 - start_bit_in_byte)
            new_shift = 8Frames.dlc(data) - start - length
            if new_shift < 0
                throw(DomainError(new_shift, "The bits cannot be selected"))
            end

            value = Utils.from_bytes(Int64, reverse(Frames.data(data)))
            value = value >> new_shift
        else
            throw(DomainError(byte_order, "Byte order not supported"))
        end

        value = value & Utils.mask(Int64, length)
        # sign extend value if most-significant bit is 1
        if (value >> (length - 1)) & 0x01 != 0
            value = value + ~Utils.mask(Int64, length)
        end

        result = factor * value + offset
        return result
    end


end
