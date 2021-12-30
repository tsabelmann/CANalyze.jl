using CANTools.Signals
using CANTools.Messages
using CANTools.Databases

signal1 = Signals.NamedSignal("ABC", nothing, nothing, Signals.Float32Signal(start=0, byte_order=:little_endian))
signal2 = Signals.NamedSignal("ABCD", nothing, nothing, Signals.Unsigned(start=40, length=17, factor=2, offset=20, byte_order=:big_endian))
signal3 = Signals.NamedSignal("ABCDE", nothing, nothing, Signals.Unsigned(start=32, length=8, factor=2, offset=20, byte_order=:little_endian))

m1 = Messages.Message(0x1FE, 8, "ABC", signal1; strict=true)
m2 = Messages.Message(0x1FF, 8, "ABD", signal1, signal2, signal3; strict=true)

d = Databases.Database(m1, m2)
# println(d)

m = d["ABC"]
println(m)

m = d[0x1FF]
println(m)

m = get(d, 0x1FA)
println(m)
