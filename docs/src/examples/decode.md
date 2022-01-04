```@meta
CurrentModule = CANalyze
```

# Decode

## Signal

```julia
using CANalyze.Frames
using CANalyze.Signals
using CANalyze.Decode

sig1 = Unsigned(start=0, length=8, factor=1.0, offset=-1337f0, byte_order=:little_endian)
sig2 = NamedSignal("A", nothing, nothing, Float32Signal(start=0, byte_order=:little_endian
frame = CANFrame(20, [1, 2, 3, 4, 5, 6, 7, 8])

value1 = decode(sig1, frame)
value2 = decode(sig2, frame)
```

## Message

```julia
using CANalyze.Frames
using CANalyze.Signals
using CANalyze.Messages
using CANalyze.Decode

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
frame = CANFrame(20, [1, 2, 3, 4, 5, 6, 7, 8])

value = decode(message, frame)
```
