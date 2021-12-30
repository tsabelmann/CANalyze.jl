using CANalyze.Utils
using Test

@info "convert tests..."
@testset "convert" begin
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
