using Test

@info "CANalyze.Utils tests..."
@testset "endian" begin
    using CANalyze.Utils

    @testset "is_little_or_big_endian" begin
        is_little = is_little_endian()
        is_big = is_big_endian()

        @test (is_little || is_big) == true
    end

    @testset "is_little_and_big_endian" begin
        is_little = is_little_endian()
        is_big = is_big_endian()

        @test (is_little && is_big) == false
    end
end

@testset "convert" begin
    using CANalyze.Utils

    @testset "to_bytes_1" begin
        value = 1337
        new_value = from_bytes(typeof(value), to_bytes(value))

        @test value == new_value
    end

    @testset "from_bytes_1" begin
        types = [UInt8, UInt16, UInt32, UInt64, UInt128]
        for (i, type) in enumerate(types)
            array = [UInt8(j) for j=1:2^(i-1)]
            new_array = to_bytes(from_bytes(type, array))

            @test array == new_array
        end
    end

    @testset "from_bytes_2" begin
        types = [Int8, Int16, Int32, Int64, Int128]
        for (i, type) in enumerate(types)
            array = [UInt8(j) for j=1:2^(i-1)]
            new_array = to_bytes(from_bytes(type, array))

            @test array == new_array
        end
    end

    @testset "from_bytes_4" begin
        types = [Float16, Float32, Float64]
        for (i, type) in enumerate(types)
            array = [UInt8(j) for j=1:2^i]
            new_array = to_bytes(from_bytes(type, array))

            @test array == new_array
        end
    end
end

@testset "mask" begin
    using CANalyze.Utils

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

    @testset "shifted_mask_1" begin
        for i in 0:8
            @test mask(UInt8, i, 0) == mask(UInt8, i)
        end
    end

    @testset "shifted_mask_2" begin
        for i in 0:16
            @test mask(UInt16, i, 0) == mask(UInt16, i)
        end
    end

    @testset "shifted_mask_3" begin
        for i in 0:32
            @test mask(UInt32, i, 0) == mask(UInt32, i)
        end
    end

    @testset "shifted_mask_4" begin
        for i in 0:64
            @test mask(UInt64, i, 0) == mask(UInt64, i)
        end
    end

    @testset "shifted_mask_5" begin
        for i in 0:128
            @test mask(UInt128, i, 0) == mask(UInt128, i)
        end
    end

    @testset "bit_mask_1" begin
        for T in [UInt8, UInt16, UInt32, UInt64, UInt128, Int8, Int16, Int32, Int64, Int128]
            s = 8*sizeof(T) - 1
            @test bit_mask(T, 0:s) == full_mask(T)
        end
    end

    @testset "bit_mask_2" begin
        for T in [UInt8, UInt16, UInt32, UInt64, UInt128, Int8, Int16, Int32, Int64, Int128]
            s = 8*sizeof(T) - 1
            @test bit_mask(T, s) == mask(T, 1, s)
        end
    end
end
