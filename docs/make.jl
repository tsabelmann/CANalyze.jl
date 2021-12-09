using CANTools
using Documenter

DocMeta.setdocmeta!(CANTools, :DocTestSetup, :(using CANTools); recursive=true)

makedocs(;
    modules=[CANTools],
    authors="Tim Lucas Sabelmann",
    repo="https://github.com/tsabelmann/CANTools.jl/blob/{commit}{path}#{line}",
    sitename="CANTools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://tsabelmann.github.io/CANTools.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Documentation" => [
            "Utils" => "utils.md"
        ]
    ],
)

deploydocs(;
    repo="github.com/tsabelmann/CANTools.jl",
    devbranch="main",
    target="build"
)
