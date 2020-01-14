using Documenter, NorvigsTrieSpellchecker

makedocs(;
    modules=[NorvigsTrieSpellchecker],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/Arkoniak/NorvigsTrieSpellchecker.jl/blob/{commit}{path}#L{line}",
    sitename="NorvigsTrieSpellchecker.jl",
    authors="Andrey Oskin",
    assets=String[],
)

deploydocs(;
    repo="github.com/Arkoniak/NorvigsTrieSpellchecker.jl",
)
