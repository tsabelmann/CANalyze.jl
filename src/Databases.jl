module Databases
    import Base
    import ..Messages

    struct Database
        frame_id_index::Dict{UInt32, Ref{Messages.Message}}
        name_index::Dict{String, Ref{Messages.Message}}

        function Database(messages::Set{Messages.Message})
            v = [messages...]
            e = enumerate(v)
            l1 = [Messages.name(m1) == Messages.name(m2) for (i, m1) in e for (j, m2) in e if i < j]
            l2 = [Messages.frame_id(m1) == Messages.frame_id(m2) for (i, m1) in e for (j, m2) in e if i < j]
            a1 = any(l1)
            a2 = any(l2)

            if a1
                throw(DomainError(a1, "messages with the same name"))
            end

            if a2
                throw(DomainError(a2, "messages with the same frame_id"))
            end

            frame_id_index = Dict{UInt32, Ref{Messages.Message}}()
            name_index = Dict{String, Ref{Messages.Message}}()

            for message in messages
                m = Ref(message)
                frame_id_index[Messages.frame_id(message)] = m
                name_index[Messages.name(message)] = m
            end

            new(frame_id_index, name_index)
        end
    end

    function Database(messages::Messages.Message...)
        s = Set(messages)
        return Database(s)
    end

    function Base.getindex(db::Database, index::String)
        m_ref = db.name_index[index]
        return m_ref[]
    end

    function Base.getindex(db::Database, index::UInt32)
        m_ref = db.frame_id_index[index]
        return m_ref[]
    end

    function Base.getindex(db::Database, index::Integer)
        index = convert(UInt32, index)
        return db[index]
    end

    function Base.get(db::Database, key::String, default=nothing)
        try
            value = db[key]
            return value
        catch
            return default
        end
    end

    function Base.get(db::Database, key::UInt32, default=nothing)
        try
            value = db[key]
            return value
        catch
            return default
        end
    end

    function Base.get(db::Database, key::Integer, default=nothing)
        key = convert(UInt32, key)
        return get(db, key, default)
    end

    export Database
end
