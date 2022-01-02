using CANalyze.Frames
using Test


@info "CANalyze.Frames tests..."
@testset "equal" begin
    @testset "equal_1" begin
        frame1 = CANFrame(0x14, Integer[]; is_extended=true)
        frame2 = CANFrame(0x14; is_extended=true)
        @test frame1 == frame2
    end

    @testset "equal_2" begin
        frame1 = CANFrame(0x14, Integer[]; is_extended=true)
        frame2 = CANFrame(0x15, Integer[]; is_extended=true)
        @test frame1 != frame2
    end

    @testset "equal_3" begin
        frame1 = CANFrame(0x14, Integer[]; is_extended=false)
        frame2 = CANFrame(0x14, Integer[]; is_extended=true)
        @test frame1 != frame2
    end

    @testset "equal_4" begin
        frame1 = CANFrame(0x14, Integer[]; is_extended=true)
        frame2 = CANFrame(0x15, Integer[]; is_extended=true)
        @test frame1 != frame2
    end

    @testset "equal_5" begin
        frame1 = CANFrame(0x14, Integer[1,2,3,4]; is_extended=true)
        frame2 = CANFrame(0x14, 1, 2, 3, 4; is_extended=true)
        @test frame1 == frame2
    end

    
end