# NorvigsTrieSpellchecker

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Arkoniak.github.io/NorvigsTrieSpellchecker.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Arkoniak.github.io/NorvigsTrieSpellchecker.jl/dev)
[![Build Status](https://travis-ci.com/Arkoniak/NorvigsTrieSpellchecker.jl.svg?branch=master)](https://travis-ci.com/Arkoniak/NorvigsTrieSpellchecker.jl)

Trie implementation of [Norvig's spellchecker](https://norvig.com/spell-correct.html) based on this [discussion](https://discourse.julialang.org/t/implementation-of-norvigs-spellchecker-code-critique-performance-help/33038). Performance test is in `example` directory, on my laptop (Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz) get following results

```
> julia norvigs.jl

0.748 of 270 correct (0.056 unknown) at 5382.885 words per second
  0.426627 seconds (1.21 M allocations: 52.142 MiB, 7.34% gc time)
0.675 of 400 correct (0.108 unknown) at 3664.988 words per second
  0.109498 seconds (475.77 k allocations: 14.612 MiB, 33.29% gc time)
Benchmark testset1, average speed: 5929.07 words per second
Benchmark testset2, average speed: 5665.096 words per second
```
