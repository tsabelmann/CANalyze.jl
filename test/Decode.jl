import CANalyze.Utils
import CANalyze.Frames
import CANalyze.Signals
import CANalyze.Messages
import CANalyze.Decode
using Test

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
end
