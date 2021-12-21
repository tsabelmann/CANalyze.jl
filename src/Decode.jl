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
    function decode(signal::Signal.Unsigned{T}, data::Frames.CANFrame) where {T}
        
    end


end
