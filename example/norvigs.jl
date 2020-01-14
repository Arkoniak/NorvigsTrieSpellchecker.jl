using NorvigsTrieSpellchecker
using BenchmarkTools

function testset(lines)
    return [(right, wrong)
            for (right, wrongs) in [split(line, ":") for line in lines]
            for wrong in split(wrongs)]
end

function spelltest(t, tests; verbose=false, silent=false)
    start = time()
    good, unknown = 0, 0
    n = 0
    for (right, wrong) in tests
        n += 1
        w = correction(t, wrong)
        good += (w == right)
        if w != right
            unknown += !haskey(t, right)
            # unknown += !(right in keys(WORDS))
            if verbose
                println("correction($wrong) => $(w) ($(WORDS[w])); expected $(right) ($(WORDS[right]))")
            end
        end
    end
    dt = time() - start
    if !silent
        println("$(round((good / n), digits=3)) of $(n) correct ($(round((unknown / n), digits=3)) unknown) at $(round((n / dt), digits=3)) words per second")
    end
end

const TRIE = load_text("big.txt")

@time spelltest(TRIE, testset(readlines(open("spell-testset1.txt"))))
@time spelltest(TRIE, testset(readlines(open("spell-testset2.txt"))))

ts1 = testset(readlines(open("spell-testset1.txt")))
ts2 = testset(readlines(open("spell-testset2.txt")))

b1 = @benchmark spelltest($TRIE, $ts1, silent = true)
b2 = @benchmark spelltest($TRIE, $ts2, silent = true)

println("Benchmark testset1, average speed: ", round(length(ts1)/(sum(b1.times)/length(b1.times)/10^6/10^3), digits=3), " words per second")
println("Benchmark testset2, average speed: ", round(length(ts2)/(sum(b2.times)/length(b2.times)/10^6/10^3), digits=3), " words per second")
