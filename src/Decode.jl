"""
"""
module Decode
    import ..Utils
    import ..Frames
    import ..Signals
    import ..Messages

    """
    """
    function decode(signal::Signals.NamedSignal{T}, can_frame::Frames.CANFrame)::T where {T}
        return decode(signal.signal, can_frame)
    end

    """
    """
    function decode(signal::Signals.UnnamedSignal{T},
                    can_frame::Frames.CANFrame,
                    default::R)::Union{T,R} where {T,R}
        try
            return decode(signal, can_frame)
        catch
            return default
        end
    end

    """
    """
    function decode(signal::Signals.Bit, can_frame::Frames.CANFrame)::Bool
        start = Signals.start(signal)

        if start >= 8Frames.dlc(data)
            throw(DomainError(start_bit, "CANFrame does not have data at bit position"))
        else
            mask = Utils.mask(UInt64, 1, start)
            value = Utils.from_bytes(UInt64, Frames.data(can_frame))
            if mask & value != 0
                return true
            else
                return false
            end
        end
    end

    """
    """
    function decode(signal::Signals.Unsigned{T}, can_frame::Frames.CANFrame) where {T}
        start = Signals.start(signal)
        length = Signals.length(signal)
        factor = Signals.factor(signal)
        offset = Signals.offset(signal)
        byte_order = Signals.byte_order(signal)

        if byte_order == :little_endian
            if start >= 8*Frames.dlc(can_frame)
                throw(DomainError())
            end

            if start + length - 1 >= 8 * Frames.dlc(can_frame)
                throw(DomainError())
            end

            value = Utils.from_bytes(UInt64, Frames.data(can_frame))
            value = value >> start
        elseif byte_order == :big_endian
            start_bit_in_byte = start % 8
            start_byte = div(start, 8)

            if start_bit_in_byte != 7 && start_bit_in_byte != 0
                start = 8*start_byte + (7 - start_bit_in_byte)
            end

            new_shift = 8Frames.dlc(can_frame) - start - length
            if new_shift < 0
                throw(DomainError(new_shift, "The bits cannot be selected"))
            end

            value = Utils.from_bytes(UInt64, reverse(Frames.data(can_frame)))
            value = value >> new_shift
        else
            throw(DomainError(byte_order, "Byte order not supported"))
        end

        value = value & Utils.mask(UInt64, length)
        result = factor * value + offset
        return result
    end

    function decode(signal::Signals.Signed{T}, can_frame::Frames.CANFrame) where {T}
        start = Signals.start(signal)
        length = Signals.length(signal)
        factor = Signals.factor(signal)
        offset = Signals.offset(signal)
        byte_order = Signals.byte_order(signal)

        if byte_order == :little_endian
            if start >= 8*Frames.dlc(can_frame)
                throw(DomainError())
            end

            if start + length - 1 >= 8 * Frames.dlc(can_frame)
                throw(DomainError())
            end

            value = Utils.from_bytes(Int64, Frames.data(can_frame))
            value = value >> start
        elseif byte_order == :big_endian
            start_bit_in_byte = start % 8
            start_byte = div(start, 8)

            start = 8*start_byte + (7 - start_bit_in_byte)
            new_shift = 8*Frames.dlc(can_frame) - start - length

            if new_shift < 0
                throw(DomainError(new_shift, "The bits cannot be selected"))
            end

            value = Utils.from_bytes(Int64, reverse(Frames.data(can_frame)))
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

    """
    """
    function decode(signal::Signals.FloatSignal{T}, can_frame::Frames.CANFrame) where {T}
        start = Signals.start(signal)
        length = Signals.length(signal)
        factor = Signals.factor(signal)
        offset = Signals.offset(signal)
        byte_order = Signals.byte_order(signal)

        if byte_order == :little_endian
            if start >= 8*Frames.dlc(can_frame)
                throw(DomainError())
            end

            if start + length - 1 >= 8 * Frames.dlc(can_frame)
                throw(DomainError())
            end

            value = Utils.from_bytes(UInt64, Frames.data(can_frame))
            value = value >> start
        elseif byte_order == :big_endian
            start_bit_in_byte = start % 8
            start_byte = div(start, 8)

            start = 8*start_byte + (7 - start_bit_in_byte)
            new_shift = 8Frames.dlc(can_frame) - start - length

            if new_shift < 0
                throw(DomainError(new_shift, "The bits cannot be selected"))
            end

            value = Utils.from_bytes(UInt64, reverse(Frames.data(can_frame)))
            value = value >> new_shift
        else
            throw(DomainError(byte_order, "Byte order not supported"))
        end

        value = value & Utils.mask(UInt64, length)
        result = Utils.from_bytes(T, Utils.to_bytes(value))
        result = factor * result + offset
        return result
    end

    """
    """
    function decode(signal::Signals.Raw, can_frame::Frames.CANFrame)::UInt64
        start = Signals.start(signal)
        length = Signals.length(signal)
        byte_order = Signals.byte_order(signal)

        if byte_order == :little_endian
            if start + length - 1 >= 8 * Frames.dlc(can_frame)
                throw(DomainError())
            end

            value = Utils.from_bytes(UInt64, Frames.data(can_frame))
            value = value >> start
        elseif byte_order == :big_endian
            start_bit_in_byte = start % 8
            start_byte = div(start, 8)

            start = 8*start_byte + (7 - start_bit_in_byte)
            new_shift::Int16 = 8*Frames.dlc(can_frame) - start - length

            if new_shift < 0
                throw(DomainError(new_shift, "The bits cannot be selected"))
            end

            value = Utils.from_bytes(UInt64, reverse(Frames.data(can_frame)))
            value = value >> new_shift
        else
            throw(DomainError(byte_order, "Byte order not supported"))
        end

        result = value & Utils.mask(UInt64, length)
        return UInt64(result)
    end
end
