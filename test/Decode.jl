import CANalyze.Utils
import CANalyze.Frames
import CANalyze.Signals
import CANalyze.Messages
import CANalyze.Decode
using Test
using Random

@info "CANalyze.Decode tests..."

@testset "bit" begin
    for start=0:63
        m = Utils.mask(UInt64, 1, start)
        signal = Signals.Bit(start=start)
        frame = Frames.CANFrame(0x1FF, Utils.to_bytes(m))
        @test Decode.decode(signal, frame)
    end
end

@testset "unsigned" begin
    @testset "unsigned_1" begin
        for start=0:63
            for len=1:(64-start)
                m = Utils.mask(UInt64, len, start)
                signal = Signals.Unsigned{Float64}(start=start,
                                                   length=len,
                                                   factor=2.0,
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
        signal = Signals.Unsigned{Float64}(start=7,
                                           length=8,
                                           factor=2.0,
                                           offset=1337,
                                           byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, [i for i=1:8])
        decode = Decode.decode(signal, frame)
        value = 1 * Signals.factor(signal) + Signals.offset(signal)
        @test decode == value
    end

    @testset "unsigned_3" begin
        signal = Signals.Unsigned{Float64}(start=7,
                                           length=16,
                                           factor=2.0,
                                           offset=1337,
                                           byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0xAB, 0xCD)
        decode = Decode.decode(signal, frame)
        value = 0xABCD * Signals.factor(signal) + Signals.offset(signal)
        @test decode == value
    end

    @testset "unsigned_4" begin
        signal = Signals.Unsigned{Float64}(start=7,
                                           length=24,
                                           factor=2.0,
                                           offset=1337,
                                           byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0xAB, 0xCD, 0xEF)
        decode = Decode.decode(signal, frame)
        value = 0xABCDEF * Signals.factor(signal) + Signals.offset(signal)
        @test decode == value
    end
end

@testset "signed" begin
    @testset "signed_1" begin
        for start=0:62
            for len=1:(64-start)
                m = Utils.mask(UInt64, len-1, start)
                signal = Signals.Signed{Float64}(start=start,
                                                 length=len,
                                                 factor=2.0,
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
                signal = Signals.Signed{Float64}(start=start,
                                                 length=len,
                                                 factor=2.0,
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
        signal = Signals.Signed{Float64}(start=7, length=8, factor=set=1337,
                                         byte_order=:big_endian)
        frame = Frames.CANFrame(0x1FF, 0xFE)
        decode = Decode.decode(signal, frame)
        value = -2 * Signals.factor(signal) + Signals.offset(signal)
        @test decode == value
    end
end


@testset "raw" begin
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
end
