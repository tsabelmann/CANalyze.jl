using CANalyze.Frames
using Test


@info "CANalyze.Frames tests..."
@testset "frames" begin
    @testset "equal" begin
        frame1 = CANFrame(0x14, []; is_extended=true)
        frame2 = CANFrame(0x14; is_extended=true)
        @test frame1 == frame2
    end
end