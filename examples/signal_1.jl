using CANTools.Decode
using CANTools.Frames
using CANTools.Signals

frame = Frames.CANFrame(20, [1, 2, 0xFD, 4, 5, 6, 7, 8])
signal = Signals.Signal(start=34, length=17, factor=1.0, offset=0.0; signed=true, byte_order=:big_endian)

value = Decode.decode(signal,frame)
println(value)