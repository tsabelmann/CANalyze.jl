using CANalyze
using Documenter

DocMeta.setdocmeta!(CANalyze, :DocTestSetup, :(using CANalyze); recursive=true)

makedocs(;
    modules=[CANalyze],
    authors="Tim Lucas Sabelmann",
    repo="https://github.com/tsabelmann/CANalyze.jl/blob/{commit}{path}#{line}",
    sitename="CANTools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://tsabelmann.github.io/CANalyze.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Documentation" => [
            "Frames" => "frames.md",
            "Utils" => "utils.md",
            "Signals" => "signals.md",
            "Messages" => "messages.md",
            "Decode" => "decode.md",
            "Encode" => "encode.md"
        ]
    ],
)

deploydocs(;
    repo="github.com/tsabelmann/CANalyze.jl",
    devbranch="main",
    target="build"
)
