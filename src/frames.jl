abstract type AbstractCANFrame end

abstract type TimedCANFrame <: AbstractCANFrame end

abstract type UntimedCANFrame <: AbstractCANFrame end

struct CANFrame <: UntimedCANFrame
    can_id::UInt32
    dlc::UInt8
    data::Array{UInt8,1}
    is_extended_frame::Bool
end

struct CANFdFrame <: UntimedCANFrame
    can_id::UInt32
    data::Array{UInt8,1}
    is_extended_frame::Bool
end

function dlc(frame::AbstractCANFrame)::UInt8
    return frame.dlc
end

function can_id(frame::AbstractCANFrame)::UInt32
    frame.can_id
end

function is_standard_frame(frame::AbstractCANFrame)::Bool
    return !is_extended_frame(frame)
end

function is_extended_frame(frame::AbstractCANFrame)::Bool
    return frame.is_extended_frame
end

function max_size(::Type{AbstractCANFrame})::UInt8
    return 8
end

function max_size(::Type{CANFrame})::UInt8
    return 8
end

function max_size(::Type{CANFdFrame})::UInt8
    return 64
end
