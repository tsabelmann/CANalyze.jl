using CANTools
using Test

@testset "Endian" begin
    @testset "is_little_or_big_endian" begin
        is_little_endian = CANTools.is_little_endian()
        is_big_endian = CANTools.is_big_endian()

        @test (is_little_endian || is_big_endian) == true
    end

    @testset "is_little_and_big_endian" begin
        is_little_endian = CANTools.is_little_endian()
        is_big_endian = CANTools.is_big_endian()

        @test (is_little_endian && is_big_endian) == false
    end
end