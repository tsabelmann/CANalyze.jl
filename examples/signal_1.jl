using CANTools.Decode
using CANTools.Frames
using CANTools.Signals

frame = Frames.CANFrame(20, [1, 2, 0xFD, 4, 5, 6, 7, 8])
signal = Signals.Signal(34, 17, 1.0, 0.0; signed=true)

value = Decode.decode(signal,frame)
println(value)