function load_text(path)
    words(text) = [m.match for m in eachmatch(r"\w+", lowercase(text))]
    dict = Dict{String, Int}()
    for w in words(read(open(path), String))
        dict[w] = get(dict, w, 0) + 1
    end
    sumwords =  sum(values(dict))
    P(word) = dict[word] / sumwords

    t = Trie{Tuple{String, Float64}}()
    for word in keys(dict)
        t[word] = (word, P(word))
    end

    t
end

function correction(t::Trie, word)
    if haskey(t, word) return word end
    res = correction(t, word, 1)
    if res == word
        return correction(t, word, 2)
    else
        return res
    end
end

function correction(t::Trie, word, tolerance)
    correct_recursive(t, word, 1, tolerance, (word, 0.0))[1]
end

function correct_recursive(t::Trie, word, idx, tolerance, found)
    if tolerance == 0
        res = get(t, word[idx:end], found)
        res[2] > found[2] ? (return res) : (return found)
    end

    res = found
    # no op
    if idx <= length(word) && (word[idx] in keys(t.children))
        res = correct_recursive(t.children[word[idx]], word, idx + 1, tolerance, res)
    end

    #deletion
    res = correct_recursive(t, word, idx + 1, tolerance - 1, res)

    # insertion
    for (k, v) in t.children
        res = correct_recursive(v, word, idx, tolerance - 1, res)
    end

    #replace
    for (k, v) in t.children
        res = correct_recursive(v, word, idx + 1, tolerance - 1, res)
    end

    #transpose
    if idx <= length(word) - 1
        if (word[idx + 1] in keys(t.children)) && (word[idx] in keys(t.children[word[idx + 1]].children))
            res = correct_recursive(t.children[word[idx + 1]].children[word[idx]], word, idx + 2, tolerance - 1, res)
        end
    end
    return res
end
