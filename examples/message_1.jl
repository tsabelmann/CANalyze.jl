using CANalyze.Decode
using CANalyze.Frames
using CANalyze.Signals
using CANalyze.Messages


signal1 = Signals.NamedSignal("ABC", nothing, nothing, Signals.Float32Signal(start=0, byte_order=:little_endian))
signal2 = Signals.NamedSignal("ABCD", nothing, nothing, Signals.Unsigned(start=40, length=17, factor=2, offset=20, byte_order=:big_endian))
signal3 = Signals.NamedSignal("ABCDE", nothing, nothing, Signals.Unsigned(start=32, length=8, factor=2, offset=20, byte_order=:little_endian))

bits1 = Signals.Bits(signal1)
println(sort(Int64[bits1.bits...]))

bits1 = Signals.Bits(signal2)
println(sort(Int64[bits1.bits...]))

bits1 = Signals.Bits(signal3)
println(sort(Int64[bits1.bits...]))

frame = Frames.CANFrame(20, [1, 2, 0xFD, 4, 5, 6, 7, 8])
m = Messages.Message(0x1FF, 8, "ABC", signal1, signal2, signal3; strict=true)

d = Decode.decode(m, frame)
println(d)
