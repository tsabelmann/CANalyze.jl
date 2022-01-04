```@meta
CurrentModule = CANalyze
```

# Signals

Signals are the basic blocks of the CAN-bus data analysis, i.e., decoding or
encoding CAN-bus data.

## Bit

```julia
using CANalyze.Signals

bit1 = Bit(20)
bit2 = Bit(start=20)
```

## Unsigned

```julia
using CANalyze.Signals

sig1 = Unsigned{Float32}(0, 1)
sig2 = Unsigned{Float64}(start=0, length=8, factor=2, offset=20)
sig3 = Unsigned(0, 8, 1, 0, :little_endian)
sig4 = Unsigned(start=0, length=8, factor=1.0, offset=-1337f0, byte_order=:little_endian)
```

## Signed

```julia
using CANalyze.Signals

sig1 = Signed{Float32}(0, 1)
sig2 = Signed{Float64}(start=3, length=16, factor=2, offset=20, byte_order=:big_endian)
sig3 = Signed(0, 8, 1, 0, :little_endian)
sig4 = Signed(start=0, length=8, factor=1.0, offset=-1337f0, byte_order=:little_endian)
```

## FloatSignal
```julia
using CANalyze.Signals

sig1 = FloatSignal(0, 1.0, 0.0, :little_endian)
sig2 = FloatSignal(start=0, factor=1.0, offset=0.0, byte_order=:little_endian)
```

## Float16Signal
```julia
using CANalyze.Signals

sig1 = FloatSignal{Float16}(0)
sig2 = FloatSignal{Float16}(0, factor=1.0, offset=0.0, byte_order=:little_endian)
sig3 = FloatSignal{Float16}(start=0, factor=1.0, offset0.0, byte_order=:little_endian)
```

## Float32Signal
```julia
using CANalyzes

sig1 = FloatSignal{Float32}(0)
sig2 = FloatSignal{Float32}(0, factor=1.0, offset=0.0, byte_order=:little_endian)
sig3 = FloatSignal{Float32}(start=0, factor=1.0, offset0.0, byte_order=:little_endian)
```

## Float64Signal
```julia
using CANalyze.Signals

sig1 = FloatSignal{Float64}(0)
sig2 = FloatSignal{Float64}(0, factor=1.0, offset=0.0, byte_order=:little_endian)
sig3 = FloatSignal{Float64}(start=0, factor=1.0, offset=0.0, byte_order=:little_endian)
```

## Raw

```julia
using CANalyze.Signals

sig1 = Raw(0, 8, :big_endian)
sig2 = Raw(start=21, length=7, byte_order=:little_endian)
```

## NamedSignal
```julia
using CANalyze.Signals

sig1 = NamedSignal("ABC",
                   nothing,
                   nothing,
                   Float32Signal(start=0, byte_order=:little_endian))
sig2 = NamedSignal(name="ABC",
                   unit=nothing,
                   default=nothing,
                   signal=Float32Signal(start=0, byte_order=:little_endian))
```
