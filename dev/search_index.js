var documenterSearchIndex = {"docs":
[{"location":"examples/decode/","page":"Decode","title":"Decode","text":"CurrentModule = CANalyze","category":"page"},{"location":"examples/decode/#Decode","page":"Decode","title":"Decode","text":"","category":"section"},{"location":"examples/decode/#Signal","page":"Decode","title":"Signal","text":"","category":"section"},{"location":"examples/decode/","page":"Decode","title":"Decode","text":"using CANalyze.Frames\nusing CANalyze.Signals\nusing CANalyze.Decode\n\nsig1 = Unsigned(start=0, length=8, factor=1.0, offset=-1337f0, byte_order=:little_endian)\nsig2 = NamedSignal(\"A\", nothing, nothing, Float32Signal(start=0, byte_order=:little_endian\nframe = CANFrame(20, [1, 2, 3, 4, 5, 6, 7, 8])\n\nvalue1 = decode(sig1, frame)\nvalue2 = decode(sig2, frame)","category":"page"},{"location":"examples/decode/#Message","page":"Decode","title":"Message","text":"","category":"section"},{"location":"examples/decode/","page":"Decode","title":"Decode","text":"using CANalyze.Frames\nusing CANalyze.Signals\nusing CANalyze.Messages\nusing CANalyze.Decode\n\nsig1 = NamedSignal(\"A\", nothing, nothing, Float32Signal(start=0, byte_order=:little_endian))\nsig2 = NamedSignal(\"B\", nothing, nothing, Unsigned(start=40,\n                                                   length=17,\n                                                   factor=2,\n                                                   offset=20,\n                                                   byte_order=:big_endian))\nsig3 = NamedSignal(\"C\", nothing, nothing, Unsigned(start=32,\n                                                   length=8,\n                                                   factor=2,\n                                                   offset=20,\n                                                   byte_order=:little_endian))\n\n\nmessage = Message(0x1FF, 8, \"ABC\", sig1, sig2, sig3; strict=true)\nframe = CANFrame(20, [1, 2, 3, 4, 5, 6, 7, 8])\n\nvalue = decode(message, frame)","category":"page"},{"location":"messages/","page":"Messages","title":"Messages","text":"CurrentModule = CANalyze","category":"page"},{"location":"messages/#CANalyze.Messages","page":"Messages","title":"CANalyze.Messages","text":"","category":"section"},{"location":"messages/","page":"Messages","title":"Messages","text":"Modules = [CANalyze.Messages]","category":"page"},{"location":"messages/#CANalyze.Messages","page":"Messages","title":"CANalyze.Messages","text":"The module provides the Message type that bundles signals.\n\n\n\n\n\n","category":"module"},{"location":"messages/#CANalyze.Messages.Message","page":"Messages","title":"CANalyze.Messages.Message","text":"Message\n\nMessages model bundles of signals and enable the decoding of multiple signals. Additionally, messages are defined using the number of bytes (dlc), a message name (name), and the internal signals (signals).\n\nFields\n\ndlc::UInt8: the number of required bytes\nname::String: the name of the message\nsignals::Dict{String, Signals.NamedSignal}: a mapping of string\n\n\n\n\n\n","category":"type"},{"location":"messages/#Base.get-Tuple{CANalyze.Messages.Message, String, Any}","page":"Messages","title":"Base.get","text":"Base.get(message::Message, key::String, default)\n\nReturns the signal with the name key inside message if a signal with such a name exists, otherwise we return default.\n\nArguments\n\nmessage::Message: the message\nkey::String: the index, i.e., the name of the signal we want to retrieve\ndefault: a default value\n\n\n\n\n\n","category":"method"},{"location":"messages/#Base.getindex-Tuple{CANalyze.Messages.Message, String}","page":"Messages","title":"Base.getindex","text":"Base.getindex(message::Message, index::String) -> Signals.NamedSignal\n\nReturns the signal with the name index inside message.\n\nArguments\n\nmessage::Message: the message\nindex::String: the index, i.e., the name of the signal we want to retrieve\n\nThrows\n\nKeyError: the signal with the name index does not exist inside message\n\n\n\n\n\n","category":"method"},{"location":"messages/#Base.iterate-Tuple{CANalyze.Messages.Message, Any}","page":"Messages","title":"Base.iterate","text":"Base.iterate(iter::Message, state)\n\nEnables the iteration over the inside dictionary signals.\n\nArguments\n\niter::Message: the message\nstate: the state of the iterator\n\n\n\n\n\n","category":"method"},{"location":"messages/#Base.iterate-Tuple{CANalyze.Messages.Message}","page":"Messages","title":"Base.iterate","text":"Base.iterate(iter::Message)\n\nEnables the iteration over the inside dictionary signals.\n\nArguments\n\niter::Message: the message\n\n\n\n\n\n","category":"method"},{"location":"messages/#CANalyze.Messages.dlc-Tuple{CANalyze.Messages.Message}","page":"Messages","title":"CANalyze.Messages.dlc","text":"dlc(message::Message) -> UInt8\n\nReturns the number of bytes that the message requires and operates on.\n\nArguments\n\nmessage::Message: the message\n\n\n\n\n\n","category":"method"},{"location":"messages/#CANalyze.Messages.frame_id-Tuple{CANalyze.Messages.Message}","page":"Messages","title":"CANalyze.Messages.frame_id","text":"\n\n\n\n","category":"method"},{"location":"messages/#CANalyze.Messages.name-Tuple{CANalyze.Messages.Message}","page":"Messages","title":"CANalyze.Messages.name","text":"name(message::Message) -> String\n\nReturns the message name.\n\nArguments\n\nmessage::Message: the message\n\n\n\n\n\n","category":"method"},{"location":"frames/","page":"Frames","title":"Frames","text":"CurrentModule = CANalyze","category":"page"},{"location":"frames/#CANalyze.Frames","page":"Frames","title":"CANalyze.Frames","text":"","category":"section"},{"location":"frames/","page":"Frames","title":"Frames","text":"Modules = [CANalyze.Frames]","category":"page"},{"location":"frames/#CANalyze.Frames.AbstractCANFrame","page":"Frames","title":"CANalyze.Frames.AbstractCANFrame","text":"\n\n\n\n","category":"type"},{"location":"frames/#CANalyze.Frames.CANFdFrame","page":"Frames","title":"CANalyze.Frames.CANFdFrame","text":"\n\n\n\n","category":"type"},{"location":"frames/#CANalyze.Frames.CANFdFrame-Tuple{Integer, Vararg{Integer}}","page":"Frames","title":"CANalyze.Frames.CANFdFrame","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.CANFdFrame-Union{Tuple{A}, Tuple{Integer, A}} where A<:(AbstractArray{<:Integer})","page":"Frames","title":"CANalyze.Frames.CANFdFrame","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.CANFrame","page":"Frames","title":"CANalyze.Frames.CANFrame","text":"\n\n\n\n","category":"type"},{"location":"frames/#CANalyze.Frames.CANFrame-Tuple{Integer, Vararg{Integer}}","page":"Frames","title":"CANalyze.Frames.CANFrame","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.CANFrame-Tuple{Integer}","page":"Frames","title":"CANalyze.Frames.CANFrame","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.CANFrame-Union{Tuple{A}, Tuple{Integer, A}} where A<:(AbstractArray{<:Integer})","page":"Frames","title":"CANalyze.Frames.CANFrame","text":"\n\n\n\n","category":"method"},{"location":"frames/#Base.:==-Tuple{CANalyze.Frames.AbstractCANFrame, CANalyze.Frames.AbstractCANFrame}","page":"Frames","title":"Base.:==","text":"\n\n\n\n","category":"method"},{"location":"frames/#Base.:==-Tuple{CANalyze.Frames.CANFrame, CANalyze.Frames.CANFrame}","page":"Frames","title":"Base.:==","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.data-Tuple{CANalyze.Frames.AbstractCANFrame}","page":"Frames","title":"CANalyze.Frames.data","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.dlc-Tuple{CANalyze.Frames.AbstractCANFrame}","page":"Frames","title":"CANalyze.Frames.dlc","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.frame_id-Tuple{CANalyze.Frames.AbstractCANFrame}","page":"Frames","title":"CANalyze.Frames.frame_id","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.is_extended-Tuple{CANalyze.Frames.AbstractCANFrame}","page":"Frames","title":"CANalyze.Frames.is_extended","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.is_standard-Tuple{CANalyze.Frames.AbstractCANFrame}","page":"Frames","title":"CANalyze.Frames.is_standard","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.max_size-Tuple{Type{CANalyze.Frames.AbstractCANFrame}}","page":"Frames","title":"CANalyze.Frames.max_size","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.max_size-Tuple{Type{CANalyze.Frames.CANFdFrame}}","page":"Frames","title":"CANalyze.Frames.max_size","text":"\n\n\n\n","category":"method"},{"location":"frames/#CANalyze.Frames.max_size-Tuple{Type{CANalyze.Frames.CANFrame}}","page":"Frames","title":"CANalyze.Frames.max_size","text":"\n\n\n\n","category":"method"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"CurrentModule = CANalyze","category":"page"},{"location":"examples/signal/#Signals","page":"Signal","title":"Signals","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"Signals are the basic blocks of the CAN-bus data analysis, i.e., decoding or encoding CAN-bus data.","category":"page"},{"location":"examples/signal/#Bit","page":"Signal","title":"Bit","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyze.Signals\n\nbit1 = Bit(20)\nbit2 = Bit(start=20)","category":"page"},{"location":"examples/signal/#Unsigned","page":"Signal","title":"Unsigned","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyze.Signals\n\nsig1 = Unsigned{Float32}(0, 1)\nsig2 = Unsigned{Float64}(start=0, length=8, factor=2, offset=20)\nsig3 = Unsigned(0, 8, 1, 0, :little_endian)\nsig4 = Unsigned(start=0, length=8, factor=1.0, offset=-1337f0, byte_order=:little_endian)","category":"page"},{"location":"examples/signal/#Signed","page":"Signal","title":"Signed","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyze.Signals\n\nsig1 = Signed{Float32}(0, 1)\nsig2 = Signed{Float64}(start=3, length=16, factor=2, offset=20, byte_order=:big_endian)\nsig3 = Signed(0, 8, 1, 0, :little_endian)\nsig4 = Signed(start=0, length=8, factor=1.0, offset=-1337f0, byte_order=:little_endian)","category":"page"},{"location":"examples/signal/#FloatSignal","page":"Signal","title":"FloatSignal","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyze.Signals\n\nsig1 = FloatSignal(0, 1.0, 0.0, :little_endian)\nsig2 = FloatSignal(start=0, factor=1.0, offset=0.0, byte_order=:little_endian)","category":"page"},{"location":"examples/signal/#Float16Signal","page":"Signal","title":"Float16Signal","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyze.Signals\n\nsig1 = FloatSignal{Float16}(0)\nsig2 = FloatSignal{Float16}(0, factor=1.0, offset=0.0, byte_order=:little_endian)\nsig3 = FloatSignal{Float16}(start=0, factor=1.0, offset0.0, byte_order=:little_endian)","category":"page"},{"location":"examples/signal/#Float32Signal","page":"Signal","title":"Float32Signal","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyzes\n\nsig1 = FloatSignal{Float32}(0)\nsig2 = FloatSignal{Float32}(0, factor=1.0, offset=0.0, byte_order=:little_endian)\nsig3 = FloatSignal{Float32}(start=0, factor=1.0, offset0.0, byte_order=:little_endian)","category":"page"},{"location":"examples/signal/#Float64Signal","page":"Signal","title":"Float64Signal","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyze.Signals\n\nsig1 = FloatSignal{Float64}(0)\nsig2 = FloatSignal{Float64}(0, factor=1.0, offset=0.0, byte_order=:little_endian)\nsig3 = FloatSignal{Float64}(start=0, factor=1.0, offset=0.0, byte_order=:little_endian)","category":"page"},{"location":"examples/signal/#Raw","page":"Signal","title":"Raw","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyze.Signals\n\nsig1 = Raw(0, 8, :big_endian)\nsig2 = Raw(start=21, length=7, byte_order=:little_endian)","category":"page"},{"location":"examples/signal/#NamedSignal","page":"Signal","title":"NamedSignal","text":"","category":"section"},{"location":"examples/signal/","page":"Signal","title":"Signal","text":"using CANalyze.Signals\n\nsig1 = NamedSignal(\"ABC\",\n                   nothing,\n                   nothing,\n                   Float32Signal(start=0, byte_order=:little_endian))\nsig2 = NamedSignal(name=\"ABC\",\n                   unit=nothing,\n                   default=nothing,\n                   signal=Float32Signal(start=0, byte_order=:little_endian))","category":"page"},{"location":"examples/message/","page":"Message","title":"Message","text":"CurrentModule = CANalyze","category":"page"},{"location":"examples/message/#Message","page":"Message","title":"Message","text":"","category":"section"},{"location":"examples/message/","page":"Message","title":"Message","text":"using CANalyze.Signals\nusing CANalyze.Messages\n\n\nsig1 = NamedSignal(\"A\", nothing, nothing, Float32Signal(start=0, byte_order=:little_endian))\nsig2 = NamedSignal(\"B\", nothing, nothing, Unsigned(start=40,\n                                                   length=17,\n                                                   factor=2,\n                                                   offset=20,\n                                                   byte_order=:big_endian))\nsig3 = NamedSignal(\"C\", nothing, nothing, Unsigned(start=32,\n                                                   length=8,\n                                                   factor=2,\n                                                   offset=20,\n                                                   byte_order=:little_endian))\n\n\nmessage = Message(0x1FF, 8, \"ABC\", sig1, sig2, sig3; strict=true)","category":"page"},{"location":"utils/","page":"Utils","title":"Utils","text":"CurrentModule = CANalyze","category":"page"},{"location":"utils/#CANalyze.Utils","page":"Utils","title":"CANalyze.Utils","text":"","category":"section"},{"location":"utils/","page":"Utils","title":"Utils","text":"Modules = [CANalyze.Utils]","category":"page"},{"location":"utils/#CANalyze.Utils","page":"Utils","title":"CANalyze.Utils","text":"The module provides utilities to convert numbers into and from byte representations, functions to check whether the system is little-endian or big-endian, and functions to create bitmasks.\n\n\n\n\n\n","category":"module"},{"location":"utils/#CANalyze.Utils.from_bytes-Union{Tuple{T}, Tuple{Type{T}, AbstractArray{UInt8}}} where T<:Number","page":"Utils","title":"CANalyze.Utils.from_bytes","text":"from_bytes(type::Type{T}, array::AbstractArray{UInt8}) where {T <: Number} -> T\n\nCreates a value of type T constituted by the byte-array array. If the array length is smaller than the size of T, array is filled with enough zeros.\n\nArguments\n\ntype::Type{T}: the type to which the byte-array is transformed\narray::AbstractArray{UInt8}: the byte array\n\nReturns\n\nT: the value constructed from the byte sequence\n\nExamples\n\nusing CANalyze.Utils\nbytes = Utils.from_bytes(UInt16, UInt8[0xFF, 0xAA])\n\n# output\n0xaaff\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.full_mask-Union{Tuple{Type{T}}, Tuple{T}} where T<:Integer","page":"Utils","title":"CANalyze.Utils.full_mask","text":"full_mask(::Type{T}) where {T <: Integer} -> T\n\nCreates a full mask of type T with 8sizeof(T) bits.\n\nArguments\n\nType{T}: the type of the mask\n\nReturns\n\nT: the full mask\n\nExamples\n\nusing CANalyze.Utils\nm = Utils.full_mask(Int8)\n\n# output\n-1\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.is_big_endian-Tuple{}","page":"Utils","title":"CANalyze.Utils.is_big_endian","text":"is_big_endian() -> Bool\n\nReturns whether the system has big-endian byte-order\n\nReturns\n\nBool: The system has big-endian byte-order\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.is_little_endian-Tuple{}","page":"Utils","title":"CANalyze.Utils.is_little_endian","text":"is_little_endian() -> Bool\n\nReturns whether the system has little-endian byte-order\n\nReturns\n\nBool: The system has little-endian byte-order\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.mask-Union{Tuple{Type{T}}, Tuple{T}} where T<:Integer","page":"Utils","title":"CANalyze.Utils.mask","text":"mask(::Type{T}) where {T <: Integer} -> T\n\nCreates a full mask of type T with 8sizeof(T) bits.\n\nArguments\n\nType{T}: the type of the mask\n\nReturns\n\nT: the full mask\n\nExamples\n\nusing CANalyze.Utils\nm = Utils.mask(UInt64)\n\n# output\n0xffffffffffffffff\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.mask-Union{Tuple{T}, Tuple{Type{T}, Integer, Integer}} where T<:Integer","page":"Utils","title":"CANalyze.Utils.mask","text":"mask(::Type{T}, length::Integer, shift::Integer) where {T <: Integer} -> T\n\nCreates a mask of type T with length number of bits and right-shifted by shift number of bits.\n\nArguments\n\nType{T}: the type of the mask\nlength::Integer: the number of bits\nshift::Integer: the right-shift\n\nReturns\n\nT: the mask defined by length and shift\n\nExamples\n\nusing CANalyze.Utils\nm = Utils.mask(UInt64, 32, 16)\n\n# output\n0x0000ffffffff0000\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.mask-Union{Tuple{T}, Tuple{Type{T}, Integer}} where T<:Integer","page":"Utils","title":"CANalyze.Utils.mask","text":"mask(::Type{T}, length::Integer) where {T <: Integer} -> T\n\nCreates a mask of type T with length number of bits.\n\nArguments\n\nType{T}: the type of the mask\nlength::Integer: the number of bits\n\nReturns\n\nT: the mask defined by length\n\nExamples\n\nusing CANalyze.Utils\nm = Utils.mask(UInt64, 32)\n\n# output\n0x00000000ffffffff\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.mask-Union{Tuple{T}, Tuple{Type{T}, UInt8, UInt8}} where T<:Integer","page":"Utils","title":"CANalyze.Utils.mask","text":"mask(::Type{T}, length::UInt8, shift::UInt8) where {T <: Integer} -> T\n\nCreates a mask of type T with length number of bits and right-shifted by shift number of bits.\n\nArguments\n\nType{T}: the type of the mask\nlength::UInt8: the number of bits\nshift::UInt8: the right-shift\n\nReturns\n\nT: the mask defined by length and shift\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.mask-Union{Tuple{T}, Tuple{Type{T}, UInt8}} where T<:Integer","page":"Utils","title":"CANalyze.Utils.mask","text":"mask(::Type{T}, length::UInt8) where {T <: Integer} -> T\n\nCreates a mask of type T with length number of bits.\n\nArguments\n\nType{T}: the type of the mask\nlength::UInt8: the number of bits\n\nReturns\n\nT: the mask defined by length\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.to_bytes-Tuple{Number}","page":"Utils","title":"CANalyze.Utils.to_bytes","text":"to_bytes(num::Number) -> Vector{UInt8}\n\nCreates the byte representation of the number num.\n\nArguments\n\nnum::Number: the number from which we retrieve the bytes.\n\nReturns\n\nVector{UInt8}: the bytes representation of the number num\n\nExamples\n\nusing CANalyze.Utils\nbytes = Utils.to_bytes(UInt16(0xAAFF))\n\n# output\n2-element Vector{UInt8}:\n 0xff\n 0xaa\n\n\n\n\n\n","category":"method"},{"location":"utils/#CANalyze.Utils.zero_mask-Union{Tuple{Type{T}}, Tuple{T}} where T<:Integer","page":"Utils","title":"CANalyze.Utils.zero_mask","text":"zero_mask(::Type{T}) where {T <: Integer} -> T\n\nCreates a zero mask of type T where every bit is unset.\n\nArguments\n\nType{T}: the type of the mask\n\nReturns\n\nT: the zero mask\n\nExamples\n\nusing CANalyze.Utils\nm = Utils.zero_mask(UInt8)\n\n# output\n0x00\n\n\n\n\n\n","category":"method"},{"location":"encode/","page":"Encode","title":"Encode","text":"CurrentModule = CANalyze","category":"page"},{"location":"encode/#CANalyze.Encode","page":"Encode","title":"CANalyze.Encode","text":"","category":"section"},{"location":"encode/","page":"Encode","title":"Encode","text":"Modules = [CANalyze.Encode]","category":"page"},{"location":"encode/#CANalyze.Encode","page":"Encode","title":"CANalyze.Encode","text":"\n\n\n\n","category":"module"},{"location":"examples/database/","page":"Database","title":"Database","text":"CurrentModule = CANalyze","category":"page"},{"location":"examples/database/#Database","page":"Database","title":"Database","text":"","category":"section"},{"location":"examples/database/","page":"Database","title":"Database","text":"using CANalyze.Signals\nusing CANalyze.Messages\nusing CANalyze.Databases\n\nsig1 = NamedSignal(\"A\", nothing, nothing, Float32Signal(start=0, byte_order=:little_endian))\nsig2 = NamedSignal(\"B\", nothing, nothing, Unsigned(start=40,\n                                                   length=17,\n                                                   factor=2,\n                                                   offset=20,\n                                                   byte_order=:big_endian))\nsig3 = NamedSignal(\"C\", nothing, nothing, Unsigned(start=32,\n                                                   length=8,\n                                                   factor=2,\n                                                   offset=20,\n                                                   byte_order=:little_endian))\n\n\nmessage1 = Message(0x1FD, 8, \"A\", sig1; strict=true)\nmessage1 = Message(0x1FE, 8, \"B\", sig1, sig2; strict=true)\nmessage2 = Message(0x1FF, 8, \"C\", sig1, sig2, sig3; strict=true)\n\ndatabase = Database(message1, message2, message3)","category":"page"},{"location":"decode/","page":"Decode","title":"Decode","text":"CurrentModule = CANalyze","category":"page"},{"location":"decode/#CANTools.Decode","page":"Decode","title":"CANTools.Decode","text":"","category":"section"},{"location":"decode/","page":"Decode","title":"Decode","text":"Modules = [CANalyze.Decode]","category":"page"},{"location":"decode/#CANalyze.Decode.decode-Tuple{CANalyze.Signals.Bit, CANalyze.Frames.CANFrame}","page":"Decode","title":"CANalyze.Decode.decode","text":"\n\n\n\n","category":"method"},{"location":"decode/#CANalyze.Decode.decode-Tuple{CANalyze.Signals.Raw, CANalyze.Frames.CANFrame}","page":"Decode","title":"CANalyze.Decode.decode","text":"\n\n\n\n","category":"method"},{"location":"decode/#CANalyze.Decode.decode-Union{Tuple{D}, Tuple{T}, Tuple{CANalyze.Signals.UnnamedSignal{T}, CANalyze.Frames.CANFrame, D}} where {T, D}","page":"Decode","title":"CANalyze.Decode.decode","text":"\n\n\n\n","category":"method"},{"location":"decode/#CANalyze.Decode.decode-Union{Tuple{T}, Tuple{CANalyze.Signals.FloatSignal{T}, CANalyze.Frames.CANFrame}} where T","page":"Decode","title":"CANalyze.Decode.decode","text":"\n\n\n\n","category":"method"},{"location":"decode/#CANalyze.Decode.decode-Union{Tuple{T}, Tuple{CANalyze.Signals.NamedSignal{T}, CANalyze.Frames.CANFrame}} where T","page":"Decode","title":"CANalyze.Decode.decode","text":"\n\n\n\n","category":"method"},{"location":"decode/#CANalyze.Decode.decode-Union{Tuple{T}, Tuple{CANalyze.Signals.Unsigned{T}, CANalyze.Frames.CANFrame}} where T","page":"Decode","title":"CANalyze.Decode.decode","text":"\n\n\n\n","category":"method"},{"location":"signals/","page":"Signals","title":"Signals","text":"CurrentModule = CANalyze","category":"page"},{"location":"signals/#CANalyze.Signals","page":"Signals","title":"CANalyze.Signals","text":"","category":"section"},{"location":"signals/","page":"Signals","title":"Signals","text":"Modules = [CANalyze.Signals]","category":"page"},{"location":"signals/#CANalyze.Signals","page":"Signals","title":"CANalyze.Signals","text":"The module provides signals, a mechanism that models data retrievable from or written to CAN-bus data. A signal models one data entity, e.g., one variable inside the CAN-bus data.\n\n\n\n\n\n","category":"module"},{"location":"signals/#CANalyze.Signals.AbstractFloatSignal","page":"Signals","title":"CANalyze.Signals.AbstractFloatSignal","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.AbstractIntegerSignal","page":"Signals","title":"CANalyze.Signals.AbstractIntegerSignal","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.AbstractSignal","page":"Signals","title":"CANalyze.Signals.AbstractSignal","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.Bit","page":"Signals","title":"CANalyze.Signals.Bit","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.Bit-Tuple{Integer}","page":"Signals","title":"CANalyze.Signals.Bit","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Bit-Tuple{}","page":"Signals","title":"CANalyze.Signals.Bit","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Bits","page":"Signals","title":"CANalyze.Signals.Bits","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.Bits-Tuple{Vararg{Integer}}","page":"Signals","title":"CANalyze.Signals.Bits","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Bits-Union{Tuple{CANalyze.Signals.AbstractFloatSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.Bits","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Bits-Union{Tuple{CANalyze.Signals.AbstractIntegerSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.Bits","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.FloatSignal","page":"Signals","title":"CANalyze.Signals.FloatSignal","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.FloatSignal-Tuple{Integer, Union{AbstractFloat, Integer}, Union{AbstractFloat, Integer}, Symbol}","page":"Signals","title":"CANalyze.Signals.FloatSignal","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.FloatSignal-Tuple{}","page":"Signals","title":"CANalyze.Signals.FloatSignal","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.FloatSignal-Union{Tuple{Integer}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.FloatSignal","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.NamedSignal","page":"Signals","title":"CANalyze.Signals.NamedSignal","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.NamedSignal-Union{Tuple{String}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.NamedSignal","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.NamedSignal-Union{Tuple{}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.NamedSignal","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Raw","page":"Signals","title":"CANalyze.Signals.Raw","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.Raw-Tuple{Integer, Integer, Symbol}","page":"Signals","title":"CANalyze.Signals.Raw","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Raw-Union{Tuple{}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.Raw","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Signed-Tuple{Integer, Integer, Union{AbstractFloat, Integer}, Union{AbstractFloat, Integer}, Symbol}","page":"Signals","title":"CANalyze.Signals.Signed","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Signed-Tuple{}","page":"Signals","title":"CANalyze.Signals.Signed","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Signed-Union{Tuple{T}, Tuple{Integer, Integer}} where T","page":"Signals","title":"CANalyze.Signals.Signed","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Signed-Union{Tuple{}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.Signed","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.UnnamedSignal","page":"Signals","title":"CANalyze.Signals.UnnamedSignal","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.Unsigned","page":"Signals","title":"CANalyze.Signals.Unsigned","text":"\n\n\n\n","category":"type"},{"location":"signals/#CANalyze.Signals.Unsigned-Tuple{Integer, Integer, Union{AbstractFloat, Integer}, Union{AbstractFloat, Integer}, Symbol}","page":"Signals","title":"CANalyze.Signals.Unsigned","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Unsigned-Tuple{}","page":"Signals","title":"CANalyze.Signals.Unsigned","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Unsigned-Union{Tuple{T}, Tuple{Integer, Integer}} where T","page":"Signals","title":"CANalyze.Signals.Unsigned","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.Unsigned-Union{Tuple{}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.Unsigned","text":"\n\n\n\n","category":"method"},{"location":"signals/#Base.:==-Tuple{CANalyze.Signals.Bit, CANalyze.Signals.Bit}","page":"Signals","title":"Base.:==","text":"\n\n\n\n","category":"method"},{"location":"signals/#Base.:==-Union{Tuple{F}, Tuple{T}, Tuple{F, F}} where {T, F<:CANalyze.Signals.AbstractFloatSignal{T}}","page":"Signals","title":"Base.:==","text":"\n\n\n\n","category":"method"},{"location":"signals/#Base.length-Tuple{CANalyze.Signals.Bit}","page":"Signals","title":"Base.length","text":"\n\n\n\n","category":"method"},{"location":"signals/#Base.length-Tuple{CANalyze.Signals.Raw}","page":"Signals","title":"Base.length","text":"\n\n\n\n","category":"method"},{"location":"signals/#Base.length-Union{Tuple{CANalyze.Signals.Signed{T}}, Tuple{T}} where T","page":"Signals","title":"Base.length","text":"\n\n\n\n","category":"method"},{"location":"signals/#Base.length-Union{Tuple{CANalyze.Signals.Unsigned{T}}, Tuple{T}} where T","page":"Signals","title":"Base.length","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.byte_order-Tuple{CANalyze.Signals.Bit}","page":"Signals","title":"CANalyze.Signals.byte_order","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.byte_order-Tuple{CANalyze.Signals.Raw}","page":"Signals","title":"CANalyze.Signals.byte_order","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.byte_order-Union{Tuple{CANalyze.Signals.FloatSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.byte_order","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.byte_order-Union{Tuple{CANalyze.Signals.Signed{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.byte_order","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.byte_order-Union{Tuple{CANalyze.Signals.Unsigned{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.byte_order","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.check-Union{Tuple{T}, Tuple{CANalyze.Signals.NamedSignal{T}, UInt8}} where T","page":"Signals","title":"CANalyze.Signals.check","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.default-Union{Tuple{CANalyze.Signals.NamedSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.default","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.factor-Union{Tuple{CANalyze.Signals.FloatSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.factor","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.factor-Union{Tuple{CANalyze.Signals.Signed{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.factor","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.factor-Union{Tuple{CANalyze.Signals.Unsigned{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.factor","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.name-Union{Tuple{CANalyze.Signals.NamedSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.name","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.offset-Union{Tuple{CANalyze.Signals.FloatSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.offset","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.offset-Union{Tuple{CANalyze.Signals.Signed{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.offset","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.offset-Union{Tuple{CANalyze.Signals.Unsigned{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.offset","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.overlap-Union{Tuple{S}, Tuple{R}, Tuple{CANalyze.Signals.AbstractSignal{R}, CANalyze.Signals.AbstractSignal{S}}} where {R, S}","page":"Signals","title":"CANalyze.Signals.overlap","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.share_bits-Tuple{CANalyze.Signals.Bits, CANalyze.Signals.Bits}","page":"Signals","title":"CANalyze.Signals.share_bits","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.signal-Union{Tuple{CANalyze.Signals.NamedSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.signal","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.start-Tuple{CANalyze.Signals.Bit}","page":"Signals","title":"CANalyze.Signals.start","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.start-Tuple{CANalyze.Signals.Raw}","page":"Signals","title":"CANalyze.Signals.start","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.start-Union{Tuple{CANalyze.Signals.FloatSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.start","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.start-Union{Tuple{CANalyze.Signals.Signed{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.start","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.start-Union{Tuple{CANalyze.Signals.Unsigned{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.start","text":"\n\n\n\n","category":"method"},{"location":"signals/#CANalyze.Signals.unit-Union{Tuple{CANalyze.Signals.NamedSignal{T}}, Tuple{T}} where T","page":"Signals","title":"CANalyze.Signals.unit","text":"\n\n\n\n","category":"method"},{"location":"#CANalyze.jl","page":"Home","title":"CANalyze.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: Build status) (Image: codecov) (Image: Documentation) (Image: Code Style: Blue)","category":"page"},{"location":"","page":"Home","title":"Home","text":"Julia package for analyzing CAN-bus data using messages and variables","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Start julia and open the package mode by entering ]. Then enter","category":"page"},{"location":"","page":"Home","title":"Home","text":"add CANalyze","category":"page"},{"location":"","page":"Home","title":"Home","text":"This will install the packages CANalyze.jl and all its dependencies.","category":"page"},{"location":"#License-/-Terms-of-Usage","page":"Home","title":"License / Terms of Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The source code of this project is licensed under the MIT license. This implies that you are free to use, share, and adapt it. However, please give appropriate credit by citing the project.","category":"page"},{"location":"#Contact","page":"Home","title":"Contact","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"If you have problems using the software, find mistakes, or have general questions please use the issue tracker to contact us.","category":"page"},{"location":"#Contributors","page":"Home","title":"Contributors","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Tim Lucas Sabelmann","category":"page"}]
}
