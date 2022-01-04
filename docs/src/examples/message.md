```@meta
CurrentModule = CANalyze
```

# Message

```julia
using CANalyze.Signals
using CANalyze.Messages


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


message = Message(0x1FF, 8, "ABC", sig1, sig2, sig3; strict=true)
```
