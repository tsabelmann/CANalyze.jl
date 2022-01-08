using Test

@info "CANalyze.Decode tests..."
@testset "bit" begin
    import CANalyze.Utils
    import CANalyze.Frames
    import CANalyze.Signals
    import CANalyze.Messages
    import CANalyze.Decode

    @testset "bit_1" begin
        for start=0:63
            m = Utils.mask(UInt64, 1, start)
            signal = Signals.Bit(start=start)
            frame = Frames.CANFrame(0x1FF, Utils.to_bytes(m))
            @test Decode.decode(signal, frame)
        end
    end

    @testset "bit_2" begin
        for start=1:63
            m = Utils.mask(UInt64, 1, start)
            signal = Signals.Bit(start=start-1)
            frame = Frames.CANFrame(0x1FF, Utils.to_bytes(m))
            @test !Decode.decode(signal, frame)
        end
    end

    @testset "bit_3" begin
        signal = Signals.Bit(start=8)
        frame = Frames.CANFrame(0x1FF, 1)
        @test_throws DomainError Decode.decode(signal, frame)
    end

    @testset "bit_4" begin
        signal = Signals.Bit(start=8)
        frame = Frames.CANFrame(0x1FF, 1)
        @test Decode.decode(signal, frame, nothing) == nothing
    end
end

@testset "unsigned" begin
    import CANalyze.Utils
    import CANalyze.Frames
    import CANalyze.Signals
    import CANalyze.Messages
    import CANalyze.Decode

    @testset "unsigned_1" begin
        for start=0:63
            for len=1:(64-start)
                m = Utils.mask(UInt64, len, start)
                signal = Signals.Unsigned{Float64}(start=start, length=len, factor=2.0,
                                                   offset=1337,
                                                   byte_order=:little_endian)
                frame = Frames.CANFrame(0x1FF, Utils.to_bytes(m))
                decode = Decode.decode(signal, frame)
                value = Utils.mask(UInt64, len) * Signals.factor(signal) + Signals.offset(signal)
                @test decode == value
            end
        end
    end

    @testset "unsigned_2" begin
        signal = Signals.Unsigned{Float64}(start=7, length=8, factor=2.0, offset=1337,
                                           byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, [i for i=1:8])
        decode = Decode.decode(signal, frame)
        value = 1 * Signals.factor(signal) + Signals.offset(signal)
        @test decode == value
    end

    @testset "unsigned_3" begin
        signal = Signals.Unsigned{Float64}(start=7, length=16, factor=2.0, offset=1337,
                                           byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0xAB, 0xCD)
        decode = Decode.decode(signal, frame)
        value = 0xABCD * Signals.factor(signal) + Signals.offset(signal)
        @test decode == value
    end

    @testset "unsigned_4" begin
        signal = Signals.Unsigned{Float64}(start=7, length=24, factor=2.0, offset=1337,
                                           byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0xAB, 0xCD, 0xEF)
        decode = Decode.decode(signal, frame)
        value = 0xABCDEF * Signals.factor(signal) + Signals.offset(signal)
        @test decode == value
    end

    @testset "unsigned_5" begin
        signal = Signals.Unsigned{Float64}(start=8, length=1, factor=2.0, offset=1337,
                                           byte_order=:little_endian)
        frame = Frames.CANFrame(0x1FF, 0x01)
        @test_throws DomainError Decode.decode(signal, frame)
    end

    @testset "unsigned_6" begin
        signal = Signals.Unsigned{Float64}(start=6, length=8, factor=2.0, offset=1337,
                                           byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0x01)
        @test_throws DomainError Decode.decode(signal, frame)
    end
end

@testset "signed" begin
    import CANalyze.Utils
    import CANalyze.Frames
    import CANalyze.Signals
    import CANalyze.Messages
    import CANalyze.Decode
    using Random

    @testset "signed_1" begin
        for start=0:62
            for len=1:(64-start)
                m = Utils.mask(UInt64, len-1, start)
                signal = Signals.Signed{Float64}(start=start, length=len, factor=2.0,
                                                 offset=1337,
                                                 byte_order=:little_endian)
                frame = Frames.CANFrame(0x1FF, Utils.to_bytes(m))
                decode = Decode.decode(signal, frame)
                value = Utils.mask(UInt64, len-1) * Signals.factor(signal) + Signals.offset(signal)
                @test decode == value
            end
        end
    end

    @testset "signed_2" begin
        for start=0:63
            for len=1:(64-start)
                m = Utils.mask(UInt64, len, start)
                signal = Signals.Signed{Float64}(start=start, length=len, factor=2.0,
                                                 offset=1337,
                                                 byte_order=:little_endian)
                frame = Frames.CANFrame(0x1FF, Utils.to_bytes(m))
                decode = Decode.decode(signal, frame)
                value = Utils.mask(Int64, len) + ~Utils.mask(Int64, len)
                value = value * Signals.factor(signal) + Signals.offset(signal)
                @test decode == value
            end
        end
    end

    @testset "signed_3" begin
        for len=1:64
            for choice=1:64-len
                m = Utils.bit_mask(Int64, len-1, rand(0:(len-1), choice)...)
                signal = Signals.Signed{Float64}(start=0, length=len, factor=2.0,
                                                 offset=1337,
                                                 byte_order=:little_endian)
                frame = Frames.CANFrame(0x1FF, Utils.to_bytes(m))
                decode = Decode.decode(signal, frame)
                value = m + ~Utils.mask(Int64, len)
                value = value * Signals.factor(signal) + Signals.offset(signal)
                @test decode == value
            end
        end
    end

    @testset "signed_4" begin
        signal = Signals.Signed{Float64}(start=7, length=8, factor=set=1337,
                                         byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0xFE)
        decode = Decode.decode(signal, frame)
        value = -2 * Signals.factor(signal) + Signals.offset(signal)
        @test decode == value
    end

    @testset "signed_5" begin
        signal = Signals.Signed{Float64}(start=8, length=1, factor=2.0, offset=1337,
                                         byte_order=:little_endian)
        frame = Frames.CANFrame(0x1FF, 0x01)
        @test_throws DomainError Decode.decode(signal, frame)
    end

    @testset "signed_6" begin
        signal = Signals.Signed{Float64}(start=6, length=8, factor=2.0, offset=1337,
                                         byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0x01)
        @test_throws DomainError Decode.decode(signal, frame)
    end
end


@testset "raw" begin
    import CANalyze.Utils
    import CANalyze.Frames
    import CANalyze.Signals
    import CANalyze.Messages
    import CANalyze.Decode

    @testset "raw_1" begin
        for start=0:63
            for len=1:(64-start)
                m = Utils.mask(UInt64, len, start)
                signal = Signals.Raw(start=start, length=len, byte_order=:little_endian)
                frame = Frames.CANFrame(0x1FF, Utils.to_bytes(m))
                decode = Decode.decode(signal, frame)
                value = Utils.mask(UInt64, len)
                @test decode == value
            end
        end
    end

    @testset "raw_2" begin
        signal = Signals.Raw(start=7, length=8, byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, [i for i=1:8])
        decode = Decode.decode(signal, frame)
        @test decode == 1
    end

    @testset "raw_3" begin
        signal = Signals.Raw(start=7, length=16, byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0xAB, 0xCD)
        decode = Decode.decode(signal, frame)
        @test decode == 0xABCD
    end

    @testset "raw_4" begin
        signal = Signals.Raw(start=7, length=24, byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0xAB, 0xCD, 0xEF)
        decode = Decode.decode(signal, frame)
        @test decode == 0xABCDEF
    end

    @testset "raw_5" begin
        signal = Signals.Raw(start=7, length=64, byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, [i for i=1:8])
        decode = Decode.decode(signal, frame)
        @test decode == 0x01_02_03_04_05_06_07_08
    end

    @testset "raw_6" begin
        signal = Signals.Raw(start=3, length=8, byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0x21, 0xAB)
        decode = Decode.decode(signal, frame)
        @test decode == 0x1A
    end

    @testset "raw_7" begin
        signal = Signals.Raw(start=3, length=16, byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0x21, 0xAB, 0xCD)
        decode = Decode.decode(signal, frame)
        @test decode == 0x1ABC
    end

    @testset "raw_8" begin
        signal = Signals.Raw(start=8, length=1, byte_order=:little_endian)
        frame = Frames.CANFrame(0x1FF, 0x01)
        @test_throws DomainError Decode.decode(signal, frame)
    end

    @testset "raw_9" begin
        signal = Signals.Raw(start=6, length=8, byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0x01)
        @test_throws DomainError Decode.decode(signal, frame)
    end
end

@testset "named_signal" begin
    import CANalyze.Utils
    import CANalyze.Frames
    import CANalyze.Signals
    import CANalyze.Messages
    import CANalyze.Decode

    @testset "named_signal_1" begin
        signal = Signals.Signed{Float64}(start=0,
                                         length=16,
                                         factor=2.0,
                                         offset=1337,
                                         byte_order=:little_endian)
        named_signal = Signals.NamedSignal("SIG", nothing, nothing, signal)
        frame = Frames.CANFrame(0x1FF, 0x01, 0x02)
        @test Decode.decode(signal, frame) == Decode.decode(named_signal, frame)
    end
end

@testset "message" begin
    @testset "message_1" begin
        sig1 = Signals.Signed{Float64}(start=0, length=8, byte_order=:little_endian)
        sig2 = Signals.Signed{Float64}(start=8, length=8, byte_order=:little_endian)
        sig3 = Signals.Signed{Float64}(start=16, length=8, byte_order=:little_endian)

        named_signal_1 = Signals.NamedSignal("A", nothing, nothing, sig1)
        named_signal_2 = Signals.NamedSignal("B", nothing, nothing, sig2)
        named_signal_3 = Signals.NamedSignal("C", nothing, nothing, sig3)
        signals = [named_signal_1, named_signal_2, named_signal_3]

        frame = Frames.CANFrame(0x1FF, 0x01, 0x02, 0x03)
        m = Messages.Message(0x1FF, 8, "M", named_signal_1, named_signal_2, named_signal_3)

        value = Decode.decode(m, frame)
        for signal in signals
            @test value[Signals.name(signal)] == Decode.decode(signal, frame)
        end
    end
end
