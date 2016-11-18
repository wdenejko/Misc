type Anagram(s1:string, s2:string) =
    let compareArrays = Array.compareWith (fun elem1 elem2 ->
        if elem1 > elem2 then 1
        elif elem1 < elem2 then -1
        else 0) 
    member this.AreEqual() =
        match compareArrays (Array.sort (s1.Replace(" ", "").ToLower().ToCharArray())) (Array.sort (s2.Replace(" ", "").ToLower().ToCharArray())) with
        | 1 -> printfn "Str1 is greater than Str2."
        | -1 -> printfn "Str1 is less than Str2."
        | 0 -> printfn "Str1 is equal to Str2."
        | _ -> failwith("Invalid comparison result.")

//Test
let test = new Anagram("aaab", "baaa")
test.AreEqual()
let test2 = new Anagram("ab", "bab")
test2.AreEqual()