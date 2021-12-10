using CANTools.Utils
using Test

@info "endian tests..."
@testset "endian" begin
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
