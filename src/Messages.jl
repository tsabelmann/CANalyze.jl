"""
"""
module Messages
import Base
import ..Signals

"""
    Message

Messages model bundles of signals and enable the decoding of multiple signals. Additionally,
messages are defined using the number of bytes (`dlc`), a message name (`name`), and the
internal signals (`signals`).

# Fields
- `dlc::UInt8`: the number of required bytes
- `name::String`: the name of the message
- `signals::Dict{String, Signals.NamedSignal}`: a mapping of string
"""
mutable struct Message
    frame_id::UInt32
    dlc::UInt8
    name::String
    signals::Dict{String, Signals.NamedSignal}

    function Message(frame_id::UInt32, dlc::UInt8, name::String,
                     signals::Dict{String, Signals.NamedSignal}; strict::Bool=false)
        if name == ""
            throw(DomainError(name, "name cannot be the empty string"))
        end

        if strict
            e1 = enumerate(values(signals))
            l = [Signals.overlap(v1,v2) for (i,v1) in e1 for (j,v2) in e1 if i < j]
            do_overlap = any(l)
            if do_overlap
                throw(DomainError(do_overlap, "signals overlap"))
            end

            for signal in values(signals)
                is_ok = Signals.check(signal, dlc)
                if !is_ok
                        throw(DomainError(is_ok, "not enough data"))
                end
            end
        end

        return new(frame_id, dlc, name, signals)
    end
end

function Message(frame_id::Integer, dlc::Integer, name::String,
                 signals::Signals.NamedSignal...; strict::Bool=false)
    frame_id = convert(UInt32, frame_id)
    dlc = convert(UInt8, dlc)

    sigs = Dict{String, Signals.NamedSignal}()
    for signal in signals
        signal_name = Signals.name(signal)
        if get(sigs, signal_name, nothing) != nothing
            throw(DomainError(signal_name, "signal with same name already defined"))
        else
            sigs[signal_name] = signal
        end
    end

    return Message(frame_id, dlc, name, sigs; strict=strict)
end

"""
"""
function frame_id(message::Message)::UInt32
    return message.frame_id & 0x7F_FF_FF_FF
end

"""
    dlc(message::Message) -> UInt8

Returns the number of bytes that the message requires and operates on.

# Arguments
- `message::Message`: the message
"""
function dlc(message::Message)::UInt8
    return message.dlc
end

"""
    name(message::Message) -> String

Returns the message name.

# Arguments
- `message::Message`: the message
"""
function name(message::Message)::String
    return message.name
end

"""
    Base.getindex(message::Message, index::String) -> Signals.NamedSignal

Returns the signal with the name `index` inside `message`.

# Arguments
- `message::Message`: the message
- `index::String`: the index, i.e., the name of the signal we want to retrieve

# Throws
- `KeyError`: the signal with the name `index` does not exist inside `message`
"""
function Base.getindex(message::Message, index::String)::Signals.NamedSignal
    return message.signals[index]
end

"""
    Base.get(message::Message, key::String, default)

Returns the signal with the name `key` inside `message` if a signal with such a name
exists, otherwise we return `default`.

# Arguments
- `message::Message`: the message
- `key::String`: the index, i.e., the name of the signal we want to retrieve
- `default`: a default value
"""
function Base.get(message::Message, key::String, default)
    return get(message.signals, key, default)
end

"""
    Base.iterate(iter::Message)

Enables the iteration over the inside dictionary `signals`.

# Arguments
- `iter::Message`: the message
"""
function Base.iterate(iter::Message)
    return iterate(iter.signals)
end

"""
    Base.iterate(iter::Message, state)

Enables the iteration over the inside dictionary `signals`.

# Arguments
- `iter::Message`: the message
- `state`: the state of the iterator
"""
function Base.iterate(iter::Message, state)
    return iterate(iter.signals, state)
end

export Message, frame_id, dlc, name
end
