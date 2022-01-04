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
