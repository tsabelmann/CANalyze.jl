module Frames
    abstract type AbstractCANFrame end

    mutable struct CANFrame <: AbstractCANFrame
        frame_id::UInt32
        data::Array{UInt8,1}
        is_extended::Bool

        function CANFrame(frame_id::UInt32, data::AbstractArray{UInt8};
                          is_extended::Bool=false)
            if length(data) > 8
                throw(DomainError(data, "CANFrame allows a maximum of 8 bytes"))
            end
            return new(frame_id, data, is_extended)
        end
    end

    """
    """
    function CANFrame(frame_id::Integer, data::A; is_extended::Bool=false) where
        {A <: AbstractArray{<:Integer}}
        return CANFrame(convert(UInt32, frame_id), UInt8[data...])
    end

    """
    """
    function CANFrame(frame_id::Integer, data::Integer...; is_extended::Bool=false)
        return CANFrame(convert(UInt32, frame_id), UInt8[data...]; is_extended)
    end

    """
    """
    mutable struct CANFdFrame <: AbstractCANFrame
        frame_id::UInt32
        data::Array{UInt8,1}
        is_extended::Bool

        """
        """
        function CANFdFrame(frame_id::UInt32, data::A; is_extended::Bool=false) where
            {A <: AbstractArray{UInt8}}
            if length(data) > 64
                throw(DomainError(data, "CANFdFrame allows a maximum of 64 bytes"))
            end
            return new(frame_id, data, is_extended)
        end
    end

    """
    """
    function CANFdFrame(frame_id::Integer, data::A; is_extended::Bool=false) where
        {A <: AbstractArray{<:Integer}}
        return CANFdFrame(convert(UInt32, frame_id), UInt8[data...]; is_extended)
    end

    """
    """
    function CANFdFrame(frame_id::Integer, data::Integer...; is_extended::Bool=false)
        return CANFdFrame(convert(UInt32, frame_id), UInt8[data...]; is_extended)
    end

    """
    """
    function frame_id(frame::AbstractCANFrame)::UInt32
        if is_extended(frame)
            return frame.frame_id & 0x1F_FF_FF_FF
        else
            return frame.frame_id & 0x7_FF
        end
    end

    """
    """
    function data(frame::AbstractCANFrame)::Array{UInt8,1}
        return frame.data
    end

    """
    """
    function dlc(frame::AbstractCANFrame)::UInt8
        return length(frame.data)
    end

    """
    """
    function is_standard(frame::AbstractCANFrame)::Bool
        return !frame.is_extended
    end

    """
    """
    function is_extended(frame::AbstractCANFrame)::Bool
        return frame.is_extended
    end

    """
    """
    function max_size(::Type{AbstractCANFrame})::UInt8
        return 8
    end

    """
    """
    function max_size(::Type{CANFrame})::UInt8
        return 8
    end

    """
    """
    function max_size(::Type{CANFdFrame})::UInt8
        return 64
    end

    export CANFdFrame, CANFrame
    export frame_id, data, dlc, is_extended, is_standard, max_size
end
