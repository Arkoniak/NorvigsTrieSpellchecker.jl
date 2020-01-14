using NorvigsTrieSpellchecker
using DataStructures
using Test

@testset "NorvigsTrieSpellchecker.jl" begin
    t = Trie{Tuple{String, Float64}}()
    t["abc"] = ("abc", 1.0)

    # delete
    @test correction(t, "abdc") == "abc"
    # insert
    @test correction(t, "ac") == "abc"
    # replace
    @test correction(t, "adc") == "abc"
    # transpose
    @test correction(t, "bac") =="abc"
    # replace 2
    @test correction(t, "dbe") == "abc"
    # insert 2
    @test correction(t, "a") == "abc"
    # transpose + delete
    @test correction(t, "ba") =="abc"
    # known
    @test correction(t, "abc") == "abc"
    # unknown
    @test correction(t, "quintessential") == "quintessential"
    # end insert
    @test correction(t, "ab") == "abc"
    # end replace
    @test correction(t, "abd") == "abc"
    # end transpose
    @test correction(t, "acb") == "abc"
    # end delete
    @test correction(t, "abcd") == "abc"
    # begin insert
    @test correction(t, "bc") == "abc"

    t = Trie{Tuple{String, Float64}}()
    t["abcd"] = ("abcd", 0.5)
    t["abc"] = ("abc", 1.0)
    @test correction(t, "abce") == "abc"

    t = Trie{Tuple{String, Float64}}()
    t["inst"] = ("inst", 0.5)
    t["nut"] = ("nut", 1.0)
    @test correction(t, "inut") == "nut"

    t = Trie{Tuple{String, Float64}}()
    t["trees"] = ("trees", 0.5)
    t["these"] = ("these", 1.0)
    @test correction(t, "thees") == "these"
end
