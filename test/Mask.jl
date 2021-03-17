using CANTools.Utils
using Test

@testset "Mask" begin
    @testset "zero_mask" begin
        @test zero_mask(UInt8) == zero(UInt8)
        @test zero_mask(UInt16) == zero(UInt16)
        @test zero_mask(UInt32) == zero(UInt32)
        @test zero_mask(UInt64) == zero(UInt64)
        @test zero_mask(UInt128) == zero(UInt128)
    end

    @testset "full_mask" begin
        @test full_mask(UInt8) == UInt8(0xFF)
        @test full_mask(UInt16) == UInt16(0xFFFF)
        @test full_mask(UInt32) == UInt32(0xFFFFFFFF)
        @test full_mask(UInt64) == UInt64(0xFFFFFFFFFFFFFFFF)
        @test full_mask(UInt128) == UInt128(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
    end
end
