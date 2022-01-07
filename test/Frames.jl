using Test

@info "CANalyze.Frames tests..."
@testset "equal" begin
    using CANalyze.Frames

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

@testset "frame_id" begin
    using CANalyze.Frames

    @testset "frame_id_1" begin
        frame = CANFrame(0x0AFF, Integer[1,2,3,4]; is_extended=true)
        @test frame_id(frame) == (0x0AFF & 0x01_FF_FF_FF)
    end

    @testset "frame_id_1" begin
        frame = CANFrame(0x0AFF, Integer[1,2,3,4]; is_extended=false)
        @test frame_id(frame) == (0x0AFF & 0x7FF)
    end
end

@testset "data" begin
    using CANalyze.Frames

    for i=0:8
        frame = CANFrame(0x0AFF, Integer[j for j=1:i]; is_extended=true)
        @test data(frame) == UInt8[j for j=1:i]
    end
end

@testset "dlc" begin
    using CANalyze.Frames

    for i=0:8
        frame = CANFrame(0x0AFF, Integer[j for j=1:i]; is_extended=true)
        @test dlc(frame) == i
    end
end

@testset "is_extended" begin
    using CANalyze.Frames

    @testset "is_extended_1" begin
        frame = CANFrame(0x0AFF; is_extended=true)
        @test is_extended(frame) == true
        @test is_standard(frame) == false
    end

    @testset "is_extended_2" begin
        frame = CANFrame(0x0AFF; is_extended=false)
        @test is_extended(frame) == false
        @test is_standard(frame) == true
    end
end

@testset "max_size" begin
    using CANalyze.Frames

    @testset "max_size_1" begin
        frame = CANFrame(0x0AFF; is_extended=true)
        @test max_size(typeof(frame)) == 8
    end

    @testset "max_size_2" begin
        frame = CANFdFrame(0x0AFF; is_extended=true)
        @test max_size(typeof(frame)) == 64
    end
end

@testset "too_much_data" begin
    using CANalyze.Frames

    @testset "too_much_data_1" begin
        @test_throws DomainError CANFrame(0x0AFF, [i for i=1:9]; is_extended=true)
    end

    @testset "too_much_data_2" begin
        @test_throws DomainError CANFdFrame(0x0AFF, [i for i=1:65]; is_extended=true)
    end
end
