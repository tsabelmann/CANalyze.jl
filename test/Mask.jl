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

    @testset "full_mask_1" begin
        @test full_mask(UInt8) == UInt8(0xFF)
        @test full_mask(UInt16) == UInt16(0xFFFF)
        @test full_mask(UInt32) == UInt32(0xFFFFFFFF)
        @test full_mask(UInt64) == UInt64(0xFFFFFFFFFFFFFFFF)
        @test full_mask(UInt128) == UInt128(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
    end

    @testset "full_mask_2" begin
        @test mask(UInt8) == UInt8(0xFF)
        @test mask(UInt16) == UInt16(0xFFFF)
        @test mask(UInt32) == UInt32(0xFFFFFFFF)
        @test mask(UInt64) == UInt64(0xFFFFFFFFFFFFFFFF)
        @test mask(UInt128) == UInt128(0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
    end

    @testset "mask_1" begin
        @test mask(UInt8, UInt8(0)) == UInt8(0b0)
        @test mask(UInt8, UInt8(1)) == UInt8(0b1)
        @test mask(UInt8, UInt8(2)) == UInt8(0b11)
        @test mask(UInt8, UInt8(3)) == UInt8(0b111)
        @test mask(UInt8, UInt8(4)) == UInt8(0b1111)
        @test mask(UInt8, UInt8(5)) == UInt8(0b11111)
        @test mask(UInt8, UInt8(6)) == UInt8(0b111111)
        @test mask(UInt8, UInt8(7)) == UInt8(0b1111111)
        @test mask(UInt8, UInt8(8)) == UInt8(0b11111111)
    end

    @testset "mask_2" begin
        @test mask(UInt16, UInt8(0)) == UInt16(0b0)
        value = UInt16(2)
        for i in 1:16
            @test mask(UInt16, UInt8(i)) == (value - 1)
            value *= 2
        end
    end

    @testset "mask_3" begin
        @test mask(UInt32, UInt8(0)) == UInt32(0b0)
        value = UInt16(2)
        for i in 1:32
            @test mask(UInt32, UInt8(i)) == (value - 1)
            value *= 2
        end
    end

    @testset "mask_4" begin
        @test mask(UInt64, UInt8(0)) == UInt64(0b0)
        value = UInt64(2)
        for i in 1:64
            @test mask(UInt64, UInt8(i)) == (value - 1)
            value *= 2
        end
    end

    @testset "mask_5" begin
        @test mask(UInt128, UInt8(0)) == UInt128(0b0)
        value = UInt128(2)
        for i in 1:16
            @test mask(UInt128, UInt8(i)) == (value - 1)
            value *= 2
        end
    end
end
