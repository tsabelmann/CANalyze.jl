module Signals

    abstract type AbstractVariable end

    abstract type TypedVariable{T} <: AbstractVariable end

    struct SignedVariable <: TypedVariable{Float32}
        factor::Float32
        offset::Float32

    end

    struct NamedVariable <: AbstractVariable
        variable::TypedVariable
    end

    # abstract type NamedVariable <: AbstractVariable end
    #
    # abstract type UnnamedVariable <: AbstractVariable end
    #
    # abstract type Variable <: UnnamedVariable end
    #
    # abstract type MultiplexerVariable
    #
    # abstract type IntegerVariable <: UnnamedVariable end
    #
    # abstract type FloatingVariable <: UnnamedVariable end
end
