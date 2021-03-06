using Test

@info "CANalyze.Signals tests..."
@testset "bit_signal" begin
    using CANalyze.Signals

    @testset "bit_signal_1" begin
        signal = Bit(20)
        @test true
    end

    @testset "bit_signal_2" begin
        signal = Bit(start=20)
        @test true
    end

    @testset "start_1" begin
        signal = Bit(start=20)
        @test start(signal) == 20
    end

    @testset "byte_order_1" begin
        signal = Bit(start=20)
        @test byte_order(signal) == :little_endian
    end

    @testset "length_1" begin
        signal = Bit(start=20)
        @test length(signal) == 1
    end
end

@testset "unsigned_signal" begin
    using CANalyze.Signals

    @testset "unsigned_signal_1" begin
        signal = Signals.Unsigned(0, 8, 1.0, 0.0, :little_endian)
        @test true
    end

    @testset "unsigned_signal_2" begin
        signal = Signals.Unsigned(start=0, length=8, factor=1.0, offset=0.0,
                                  byte_order=:little_endian)
        @test true
    end

    @testset "unsigned_signal_3" begin
        signal = Signals.Unsigned{Float16}(0, 8)
        @test true
    end

    @testset "unsigned_signal_4" begin
        signal = Signals.Unsigned{Float16}(start=0, length=8)
        @test true
    end

    @testset "unsigned_signal_5" begin
        @test_throws DomainError Signals.Unsigned{Float16}(start=0, length=0)
    end

    @testset "unsigned_signal_6" begin
        @test_throws DomainError Signals.Unsigned{Float16}(start=0, length=0,
                                                           byte_order=:mixed_endian)
    end

    @testset "start_1" begin
        signal = Signals.Unsigned(23, 8, 1.0, 0.0, :little_endian)
        @test start(signal) == 23
    end

    @testset "length_1" begin
        signal = Signals.Unsigned(0, 8, 1.0, 0.0, :little_endian)
        @test length(signal) == 8
    end

    @testset "factor_1" begin
        signal = Signals.Unsigned(0, 8, 1.0, 0.0, :little_endian)
        @test factor(signal) == 1
    end

    @testset "offset_1" begin
        signal = Signals.Unsigned(0, 8, 1.0, 1337, :little_endian)
        @test offset(signal) == 1337
    end

    @testset "byte_order_1" begin
        signal = Signals.Unsigned(0, 8, 1.0, 0.0, :little_endian)
        @test byte_order(signal) == :little_endian
    end

    @testset "byte_order_2" begin
        signal = Signals.Unsigned(0, 8, 1.0, 0.0, :big_endian)
        @test byte_order(signal) == :big_endian
    end
end

@testset "signed_signal" begin
    using CANalyze.Signals

    @testset "signed_signal_1" begin
        signal = Signals.Signed(0, 8, 1.0, 0.0, :little_endian)
        @test true
    end

    @testset "signed_signal_2" begin
        signal = Signals.Signed(start=0, length=8, factor=1.0, offset=0.0,
                                  byte_order=:little_endian)
        @test true
    end

    @testset "signed_signal_3" begin
        signal = Signals.Signed{Float16}(0, 8)
        @test true
    end

    @testset "signed_signal_4" begin
        signal = Signals.Signed{Float16}(start=0, length=8)
        @test true
    end

    @testset "signed_signal_5" begin
        @test_throws DomainError Signals.Signed{Float16}(start=0, length=0)
    end

    @testset "signed_signal_6" begin
        @test_throws DomainError Signals.Signed{Float16}(start=0, length=0,
                                                         byte_order=:mixed_endian)
    end

    @testset "start_1" begin
        signal = Signals.Signed(23, 8, 1.0, 0.0, :little_endian)
        @test start(signal) == 23
    end

    @testset "length_1" begin
        signal = Signals.Signed(0, 8, 1.0, 0.0, :little_endian)
        @test length(signal) == 8
    end

    @testset "factor_1" begin
        signal = Signals.Signed(0, 8, 1.0, 0.0, :little_endian)
        @test factor(signal) == 1
    end

    @testset "offset_1" begin
        signal = Signals.Signed(0, 8, 1.0, 1337, :little_endian)
        @test offset(signal) == 1337
    end

    @testset "byte_order_1" begin
        signal = Signals.Signed(0, 8, 1.0, 0.0, :little_endian)
        @test byte_order(signal) == :little_endian
    end

    @testset "byte_order_2" begin
        signal = Signals.Signed(0, 8, 1.0, 0.0, :big_endian)
        @test byte_order(signal) == :big_endian
    end
end

@testset "float16_signal" begin
    using CANalyze.Signals

    @testset "float16_signal_1" begin
        signal = Signals.Float16Signal(0)
        @test true
    end

    @testset "float16_signal_2" begin
        signal = Signals.Float16Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test true
    end

    @testset "float16_signal_3" begin
        signal = Signals.Float16Signal(start=0, factor=1, offset=0,
                                       byte_order=:little_endian)
        @test true
    end

    @testset "start_1" begin
        signal = Signals.Float16Signal(start=42, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test start(signal) == 42
    end

    @testset "length_1" begin
        signal = Signals.Float16Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test length(signal) == 16
    end

    @testset "factor_1" begin
        signal = Signals.Float16Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test factor(signal) == 1
    end

    @testset "offset_1" begin
        signal = Signals.Float16Signal(start=0, factor=1.0, offset=1337,
                                       byte_order=:little_endian)
        @test offset(signal) == 1337
    end

    @testset "byte_order_1" begin
        signal = Signals.Float16Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test byte_order(signal) == :little_endian
    end

    @testset "byte_order_2" begin
        signal = Signals.Float16Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:big_endian)
        @test byte_order(signal) == :big_endian
    end
end

@testset "float32_signal" begin
    using CANalyze.Signals

    @testset "float32_signal_1" begin
        signal = Signals.Float32Signal(0)
        @test true
    end

    @testset "float32_signal_2" begin
        signal = Signals.Float32Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test true
    end

    @testset "float32_signal_3" begin
        signal = Signals.Float32Signal(start=0, factor=1, offset=0,
                                       byte_order=:little_endian)
        @test true
    end

    @testset "start_1" begin
        signal = Signals.Float32Signal(start=42, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test start(signal) == 42
    end

    @testset "length_1" begin
        signal = Signals.Float32Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test length(signal) == 32
    end

    @testset "factor_1" begin
        signal = Signals.Float32Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test factor(signal) == 1
    end

    @testset "offset_1" begin
        signal = Signals.Float32Signal(start=0, factor=1.0, offset=1337,
                                       byte_order=:little_endian)
        @test offset(signal) == 1337
    end

    @testset "byte_order_1" begin
        signal = Signals.Float32Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test byte_order(signal) == :little_endian
    end

    @testset "byte_order_2" begin
        signal = Signals.Float32Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:big_endian)
        @test byte_order(signal) == :big_endian
    end
end

@testset "float64_signal" begin
    using CANalyze.Signals

    @testset "float64_signal_1" begin
        signal = Signals.Float64Signal(0)
        @test true
    end

    @testset "float64_signal_2" begin
        signal = Signals.Float64Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test true
    end

    @testset "float64_signal_3" begin
        signal = Signals.Float64Signal(start=0, factor=1, offset=0,
                                       byte_order=:little_endian)
        @test true
    end

    @testset "start_1" begin
        signal = Signals.Float64Signal(start=42, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test start(signal) == 42
    end

    @testset "length_1" begin
        signal = Signals.Float64Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test length(signal) == 64
    end

    @testset "factor_1" begin
        signal = Signals.Float64Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test factor(signal) == 1
    end

    @testset "offset_1" begin
        signal = Signals.Float64Signal(start=0, factor=1.0, offset=1337,
                                       byte_order=:little_endian)
        @test offset(signal) == 1337
    end

    @testset "byte_order_1" begin
        signal = Signals.Float64Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:little_endian)
        @test byte_order(signal) == :little_endian
    end

    @testset "byte_order_2" begin
        signal = Signals.Float64Signal(start=0, factor=1.0, offset=0.0,
                                       byte_order=:big_endian)
        @test byte_order(signal) == :big_endian
    end
end


@testset "float_signal" begin
    using CANalyze.Signals

    @testset "float_signal_1" begin
        signal = Signals.FloatSignal(start=0, factor=2, offset=-1337,
                                     byte_order=:big_endian)
        @test true
    end


end

@testset "raw_signal" begin
    using CANalyze.Signals

    @testset "raw_signal_1" begin
        signal = Signals.Raw(0, 8, :little_endian)
        @test true
    end

    @testset "raw_signal_2" begin
        signal = Signals.Raw(start=0, length=8, byte_order=:little_endian)
        @test true
    end

    @testset "raw_signal_3" begin
        @test_throws DomainError Signals.Raw(start=0, length=0, byte_order=:little_endian)
    end

    @testset "raw_signal_4" begin
        @test_throws DomainError Signals.Raw(start=0, length=1, byte_order=:mixed_endian)
    end

    @testset "start_1" begin
        signal = Signals.Raw(start=42, length=8, byte_order=:little_endian)
        @test start(signal) == 42
    end

    @testset "length_1" begin
        signal = Signals.Raw(start=0, length=23, byte_order=:little_endian)
        @test length(signal) == 23
    end

    @testset "byte_order_1" begin
        signal = Signals.Raw(start=0, length=8, byte_order=:little_endian)
        @test byte_order(signal) == :little_endian
    end

    @testset "byte_order_2" begin
        signal = Signals.Raw(start=0, length=8, byte_order=:big_endian)
        @test byte_order(signal) == :big_endian
    end
end


@testset "named_signal" begin
    using CANalyze.Signals

    @testset "named_signal_1" begin
        s = Signals.Raw(0, 8, :little_endian)
        signal = Signals.NamedSignal("ABC", nothing, nothing, s)
        @test true
    end

    @testset "named_signal_2" begin
        s = Signals.Raw(0, 8, :little_endian)
        signal = Signals.NamedSignal(name="ABC", unit=nothing, default=nothing,
                                     signal=s)
        @test true
    end

    @testset "named_signal_3" begin
        s = Signals.Raw(0, 8, :little_endian)
        @test_throws DomainError Signals.NamedSignal(name="",
                                                     unit=nothing,
                                                     default=nothing,
                                                     signal=s)
    end

    @testset "name_1" begin
        s = Signals.Raw(0, 8, :little_endian)
        signal = Signals.NamedSignal(name="ABC", unit=nothing, default=nothing,
                                     signal=s)
        @test name(signal) == "ABC"
    end

    @testset "unit_1" begin
        s = Signals.Raw(0, 8, :little_endian)
        signal = Signals.NamedSignal(name="ABC", unit=nothing, default=nothing,
                                     signal=s)
        @test unit(signal) == nothing
    end

    @testset "unit_2" begin
        s = Signals.Raw(0, 8, :little_endian)
        signal = Signals.NamedSignal(name="ABC", unit="Ah", default=nothing,
                                     signal=s)
        @test unit(signal) == "Ah"
    end

    @testset "default_1" begin
        s = Signals.Raw(0, 8, :little_endian)
        signal = Signals.NamedSignal(name="ABC", unit="Ah", default=nothing,
                                     signal=s)
        @test default(signal) == nothing
    end

    @testset "default_2" begin
        s = Signals.Raw(0, 8, :little_endian)
        signal = Signals.NamedSignal(name="ABC", unit="Ah", default=UInt(1337),
                                     signal=s)
        @test default(signal) == 1337
    end

    @testset "signal_1" begin
        s = Signals.Raw(0, 8, :little_endian)
        signal = Signals.NamedSignal(name="ABC", unit="Ah", default=nothing,
                                     signal=s)
        @test Signals.signal(signal) == s
    end
end

@testset "bits" begin
    using CANalyze.Signals

    @testset "bit_1" begin
        signal = Bit(42)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(42)
    end

    @testset "unsigned_1" begin
        signal = Signals.Unsigned(7, 5, 1.0, 0.0, :little_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(7, 8, 9, 10, 11)
    end

    @testset "unsigned_2" begin
        signal = Signals.Unsigned(7, 5, 1.0, 0.0, :big_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(7, 6, 5, 4, 3)
    end

    @testset "signed_1" begin
        signal = Signals.Signed(7, 5, 1.0, 0.0, :little_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(7, 8, 9, 10, 11)
    end

    @testset "signed_2" begin
        signal = Signals.Signed(3, 5, 1.0, 0.0, :big_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(3, 2, 1, 0, 15)
    end

    @testset "float16_1" begin
        signal = Signals.Float16Signal(0; byte_order=:little_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(Set{UInt16}([i for i=0:15]))
    end

    @testset "float16_2" begin
        signal = Signals.Float16Signal(0; byte_order=:big_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(0, 15, 14, 13, 12, 11, 10, 9, 8, 23, 22, 21, 20, 19, 18, 17)
    end

    @testset "float32_1" begin
        signal = Signals.Float32Signal(0; byte_order=:little_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(Set{UInt16}([i for i=0:31]))
    end

    @testset "float32_2" begin
        signal = Signals.Float32Signal(39; byte_order=:big_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(Set{UInt16}([i for i=32:63]))
    end

    @testset "float64_1" begin
        signal = Signals.Float64Signal(0; byte_order=:little_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(Set{UInt16}([i for i=0:63]))
    end

    @testset "float64_2" begin
        signal = Signals.Float64Signal(7; byte_order=:big_endian)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(Set{UInt16}([i for i=0:63]))
    end

    @testset "named_signal_1" begin
        s = Signals.Float64Signal(7; byte_order=:big_endian)
        signal = Signals.NamedSignal("ABC", nothing, nothing, s)
        bits = Signals.Bits(signal)
        @test bits == Signals.Bits(Set{UInt16}([i for i=0:63]))
    end

end

@testset "share_bits" begin
    using CANalyze.Signals

    @testset "share_bits_1" begin
        sig1 = Signals.Float16Signal(0; byte_order=:little_endian)
        sig2 = Signals.Float16Signal(0; byte_order=:little_endian)

        bits1 = Signals.Bits(sig1)
        bits2 = Signals.Bits(sig2)
        @test Signals.share_bits(bits1, bits2)
    end

    @testset "share_bits_2" begin
        sig1 = Signals.Float16Signal(0; byte_order=:little_endian)
        sig2 = Signals.Float16Signal(16; byte_order=:little_endian)

        bits1 = Signals.Bits(sig1)
        bits2 = Signals.Bits(sig2)
        @test !Signals.share_bits(bits1, bits2)
    end
end

@testset "overlap" begin
    using CANalyze.Signals

    @testset "overlap_1" begin
        sig1 = Signals.Float16Signal(0; byte_order=:little_endian)
        sig2 = Signals.Float16Signal(0; byte_order=:little_endian)

        @test Signals.overlap(sig1, sig2)
    end

    @testset "overlap_2" begin
        sig1 = Signals.Float16Signal(0; byte_order=:little_endian)
        sig2 = Signals.Float16Signal(16; byte_order=:little_endian)

        @test !Signals.overlap(sig1, sig2)
    end
end

@testset "check" begin
    using CANalyze.Signals

    @testset "bit_1" begin
        signal = Signals.Bit(0)
        @test Signals.check(signal, UInt8(1))
    end

    @testset "bit_2" begin
        signal = Signals.Bit(8)
        @test !Signals.check(signal, UInt8(1))
    end

    @testset "unsigned_1" begin
        signal = Signals.Unsigned(7, 5, 1.0, 0.0, :little_endian)
        @test Signals.check(signal, UInt8(2))
    end

    @testset "unsigned_2" begin
        signal = Signals.Unsigned(7, 9, 1.0, 0.0, :big_endian)
        @test Signals.check(signal, UInt8(2))
    end

    @testset "signed_1" begin
        signal = Signals.Signed(7, 5, 1.0, 0.0, :little_endian)
        @test Signals.check(signal, UInt8(2))
    end

    @testset "signed_2" begin
        signal = Signals.Signed(7, 9, 1.0, 0.0, :big_endian)
        @test Signals.check(signal, UInt8(2))
    end

    @testset "float16_1" begin
        signal = Signals.Float16Signal(0; byte_order=:little_endian)
        @test Signals.check(signal, UInt8(2))
    end

    @testset "float16_2" begin
        signal = Signals.Float16Signal(0; byte_order=:big_endian)
        @test !Signals.check(signal, UInt8(2))
    end

    @testset "float32_1" begin
        signal = Signals.Float32Signal(0; byte_order=:little_endian)
        @test Signals.check(signal, UInt8(4))
    end

    @testset "float32_2" begin
        signal = Signals.Float32Signal(0; byte_order=:big_endian)
        @test !Signals.check(signal, UInt8(4))
    end

    @testset "float64_1" begin
        signal = Signals.Float64Signal(0; byte_order=:little_endian)
        @test Signals.check(signal, UInt8(8))
    end

    @testset "float64_2" begin
        signal = Signals.Float64Signal(0; byte_order=:big_endian)
        @test !Signals.check(signal, UInt8(8))
    end

    @testset "raw_1" begin
        signal = Signals.Raw(0, 64, :little_endian)
        @test Signals.check(signal, UInt8(8))
    end

    @testset "raw_2" begin
        signal = Signals.Raw(0, 64, :big_endian)
        @test Signals.check(signal, UInt8(9))
    end

    @testset "named_signal_1" begin
        s = Signals.Raw(0, 64, :big_endian)
        signal = Signals.NamedSignal("ABC", nothing, nothing, s)
        @test Signals.check(signal, UInt8(9))
    end
end

@testset "equal" begin
    using CANalyze.Signals

    @testset "bit_1" begin
        bit1 = Signals.Bit(20)
        bit2 = Signals.Bit(20)
        @test bit1 == bit2
    end

    @testset "bit_2" begin
        bit1 = Signals.Bit(20)
        bit2 = Signals.Bit(21)
        @test !(bit1 == bit2)
    end

    @testset "unsigned_1" begin
        sig1 = Signals.Unsigned(0, 8, 1, 0, :little_endian)
        sig2 = Signals.Unsigned(0, 8, 1, 0, :little_endian)
        @test sig1 == sig2
    end

    @testset "unsigned_2" begin
        sig1 = Signals.Unsigned(0, 8, 1, 0, :little_endian)
        sig2 = Signals.Unsigned(1, 8, 1, 0, :little_endian)
        @test !(sig1 == sig2)
    end

    @testset "unsigned_3" begin
        sig1 = Signals.Unsigned(0, 8, 1, 0, :little_endian)
        sig2 = Signals.Unsigned(0, 9, 1, 0, :little_endian)
        @test !(sig1 == sig2)
    end

    @testset "unsigned_4" begin
        sig1 = Signals.Unsigned(0, 8, 1, 0, :little_endian)
        sig2 = Signals.Unsigned(0, 8, 2, 0, :little_endian)
        @test !(sig1 == sig2)
    end

    @testset "unsigned_5" begin
        sig1 = Signals.Unsigned(0, 8, 1, 0, :little_endian)
        sig2 = Signals.Unsigned(0, 8, 1, -1, :little_endian)
        @test !(sig1 == sig2)
    end

    @testset "unsigned_6" begin
        sig1 = Signals.Unsigned(0, 8, 1, 0, :little_endian)
        sig2 = Signals.Unsigned(0, 8, 1, 0, :big_endian)
        @test !(sig1 == sig2)
    end
end
