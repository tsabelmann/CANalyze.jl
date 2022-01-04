```@meta
CurrentModule = CANalyze
```

# Database

```julia
using CANalyze.Signals
using CANalyze.Messages
using CANalyze.Databases

sig1 = NamedSignal("A", nothing, nothing, Float32Signal(start=0, byte_order=:little_endian))
sig2 = NamedSignal("B", nothing, nothing, Unsigned(start=40,
                                                   length=17,
                                                   factor=2,
                                                   offset=20,
                                                   byte_order=:big_endian))
sig3 = NamedSignal("C", nothing, nothing, Unsigned(start=32,
                                                   length=8,
                                                   factor=2,
                                                   offset=20,
                                                   byte_order=:little_endian))


message1 = Message(0x1FD, 8, "A", sig1; strict=true)
message1 = Message(0x1FE, 8, "B", sig1, sig2; strict=true)
message2 = Message(0x1FF, 8, "C", sig1, sig2, sig3; strict=true)

database = Database(message1, message2, message3)
```
