module Messages
    import Base
    import ..Signals

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

    function Message(frame_id::Integer, dlc::Integer, name::String,
                     signal::Signals.NamedSignal; strict::Bool=false)
        frame_id = convert(UInt32, frame_id)
        dlc = convert(UInt8, dlc)
        signals = Dict(Signals.name(signal) => signal)
        return Message(frame_id, dlc, name, signals; strict=strict)
    end

    function frame_id(message::Message)::UInt32
        return message.frame_id & 0x7F_FF_FF_FF
    end

    function dlc(message::Message)::UInt8
        return message.dlc
    end

    function name(message::Message)::String
        return message.name
    end

    function Base.getindex(message::Message, index::String)::Signals.NamedSignal
        return message.signals[index]
    end

    function Base.get(message::Message, key::String, default)
        return get(message.signals, key, default)
    end

    function Base.iterate(iter::Message)
        return iterate(iter.signals)
    end

    function Base.iterate(iter::Message, state)
        return iterate(iter.signals, state)
    end
end
