using CANTools.Decode
using CANTools.Frames
using CANTools.Signals

frame = Frames.CANFrame(20, [1, 2, 0xFD, 4, 5, 6, 7, 8])

sig1 = Signals.Unsigned{Float32}(0, 1)
sig2 = Signals.Unsigned{Float64}(start=0, length=8, factor=2, offset=20)
sig3 = Signals.Unsigned(0, 8, 1, 0, :little_endian)
sig4 = Signals.Unsigned(start=0, length=8, factor=1.0, offset=-1337f0, byte_order=:little_endian)

sig5 = Signals.Signed{Float32}(0, 1)
sig6 = Signals.Signed{Float64}(start=0, length=8, factor=2, offset=20)
sig7 = Signals.Signed(0, 8, 1, 0, :little_endian)
sig8 = Signals.Signed(start=0, length=8, factor=1.0, offset=-1337f0, byte_order=:little_endian)

sig9    = Signals.Raw(0, 8, :big_endian)
sig10   = Signals.Raw(start=21, length=7, byte_order=:little_endian)

println(sig1)
println(sig2)
println(sig3)
println(sig4)

println(sig5)
println(sig6)
println(sig7)
println(sig8)

println(sig9)
println(sig10)

value = Decode.decode(sig9,frame)
println(value)