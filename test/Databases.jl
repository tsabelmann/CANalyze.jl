using CANalyze.Signals
import CANalyze.Messages
import CANalyze.Databases
using Test

@info "CANalyze.Databases tests..."

@testset "database" begin
    @testset "database_1" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m1 = Messages.Message(0xA, 8, "A", signal1, signal2, signal3; strict=true)
        m2 = Messages.Message(0xB, 8, "B", signal1, signal2, signal3; strict=true)
        d = Databases.Database(m1, m2)

        @test true
    end

    @testset "database_2" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m1 = Messages.Message(0xA, 8, "A", signal1, signal2, signal3; strict=true)
        m2 = Messages.Message(0xB, 8, "A", signal1, signal2, signal3; strict=true)
        @test_throws DomainError Databases.Database(m1, m2)
    end

    @testset "database_3" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m1 = Messages.Message(0xA, 8, "A", signal1, signal2, signal3; strict=true)
        m2 = Messages.Message(0xA, 8, "B", signal1, signal2, signal3; strict=true)
        @test_throws DomainError Databases.Database(m1, m2)
    end

    @testset "get_1" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m1 = Messages.Message(0xA, 8, "A", signal1, signal2, signal3; strict=true)
        m2 = Messages.Message(0xB, 8, "B", signal1, signal2, signal3; strict=true)
        d = Databases.Database(m1, m2)

        @test d["A"] == m1
        @test d["B"] == m2
    end

    @testset "get_2" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m1 = Messages.Message(0xA, 8, "A", signal1, signal2, signal3; strict=true)
        m2 = Messages.Message(0xB, 8, "B", signal1, signal2, signal3; strict=true)
        d = Databases.Database(m1, m2)

        @test_throws KeyError d["C"]
    end

    @testset "get_3" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m1 = Messages.Message(0xA, 8, "A", signal1, signal2, signal3; strict=true)
        m2 = Messages.Message(0xB, 8, "B", signal1, signal2, signal3; strict=true)
        d = Databases.Database(m1, m2)

        @test d[0xA] == m1
        @test d[0xB] == m2
    end

    @testset "get_4" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m1 = Messages.Message(0xA, 8, "A", signal1, signal2, signal3; strict=true)
        m2 = Messages.Message(0xB, 8, "B", signal1, signal2, signal3; strict=true)
        d = Databases.Database(m1, m2)

        @test_throws KeyError d[0xC]
    end

    @testset "get_5" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m1 = Messages.Message(0xA, 8, "A", signal1, signal2, signal3; strict=true)
        m2 = Messages.Message(0xB, 8, "B", signal1, signal2, signal3; strict=true)
        d = Databases.Database(m1, m2)

        @test get(d, "A", nothing) == m1
        @test get(d, "B", nothing) == m2
        @test get(d, "C", nothing) == nothing
        @test get(d, 0xA, nothing) == m1
        @test get(d, 0xB, nothing) == m2
        @test get(d, 0xC, nothing) == nothing
    end
end
