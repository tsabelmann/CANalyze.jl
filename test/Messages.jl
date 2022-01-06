using CANalyze.Signals
using CANalyze.Messages
using Test

@info "CANalyze.Messages tests..."

@testset "message" begin
    @testset "message_1" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        @test_throws DomainError Messages.Message(0x1FF, 8, "", signal1, signal2, signal3; strict=true)
    end

    @testset "message_2" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
        @test true
    end

    @testset "message_3" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 9, 2, 20, :little_endian))

        @test_throws DomainError Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
    end

    @testset "message_4" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        @test_throws DomainError Messages.Message(0x1FF, 6, "ABC", signal1, signal2, signal3; strict=true)
    end

    @testset "message_4" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        @test_throws DomainError Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
    end

    @testset "frame_id_1" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
        @test frame_id(m) == 0x1FF
    end

    @testset "dlc_1" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
        @test Messages.dlc(m) == 8
    end

    @testset "name_1" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
        @test Messages.name(m) == "ABC"
    end

    @testset "get_1" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
        @test m["A"] == signal1
        @test m["B"] == signal2
        @test m["C"] == signal3
    end

    @testset "get_2" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
        @test_throws KeyError m["D"]
    end

    @testset "get_3" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))

        m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
        @test get(m, "A", nothing) == signal1
        @test get(m, "B", nothing) == signal2
        @test get(m, "C", nothing) == signal3
        @test get(m, "D", nothing) == nothing
    end

    @testset "iterate_1" begin
        signal1 = Signals.NamedSignal("A", nothing, nothing, Signals.Unsigned(0, 32, 1, 0, :little_endian))
        signal2 = Signals.NamedSignal("B", nothing, nothing, Signals.Unsigned(40, 17, 2, 20, :big_endian))
        signal3 = Signals.NamedSignal("C", nothing, nothing, Signals.Unsigned(32, 8, 2, 20, :little_endian))
        signals = [signal1, signal2, signal3]

        m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)
        for (n, sig) in m
            if sig in signals
                @test sig == m[n]
                @test sig == m[Signals.name(sig)]
            else
                @test false
            end
        end
    end
end
