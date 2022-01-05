using CANalyze.Signals
using Test

@info "CANalyze.Signals tests..."

@testset "bit_signal" begin
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
    @testset "float16_signal_1" begin
        signal = Signals.Float16Signal(0)
        @test true
    end

    @testset "float16_signal_2" begin
        signal = Signals.Float16Signal(start=0, factor=1.0, offset=0.0, 
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
    @testset "float32_signal_1" begin
        signal = Signals.Float32Signal(0)
        @test true
    end

    @testset "float32_signal_2" begin
        signal = Signals.Float32Signal(start=0, factor=1.0, offset=0.0, 
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
    @testset "float64_signal_1" begin
        signal = Signals.Float64Signal(0)
        @test true
    end

    @testset "float64_signal_2" begin
        signal = Signals.Float64Signal(start=0, factor=1.0, offset=0.0, 
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


@testset "raw_signal" begin
    @testset "raw_signal_1" begin
        signal = Signals.Raw(0, 8, :little_endian)
        @test true
    end

    @testset "raw_signal_2" begin
        signal = Signals.Raw(start=0, length=8, byte_order=:little_endian)
        @test true
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