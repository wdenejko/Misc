open System.IO
open System
type Observation = { Label:string; Pixels: int[] }
type Distance = int[] * int[] -> int
type Classifier = int[] -> string
let toObservation(csvData:string) =
    let columns = csvData.Split(',')
    let label = columns.[0]
    let pixels = columns.[1..] |> Array.map int 
    { Label = label; Pixels = pixels }
let reader path =
    let data = File.ReadAllLines path
    data.[1..] 
    |> Array.map toObservation
let manhattanDistance(pixels1, pixels2) =
    Array.zip pixels1 pixels2
    |> Array.map (fun (x,y) -> abs (x-y))
    |> Array.sum
let euclideanDistance (pixels1, pixels2) =
    Array.zip pixels1 pixels2
    |> Array.map (fun (x,y) -> pown (x-y) 2)
    |> Array.sum
let train(trainingset:Observation[]) (dist: Distance) =
    let classify(pixels:int[]) =
        trainingset
        |> Array.minBy (fun x -> dist (x.Pixels, pixels))
        |> fun x -> x.Label 
    classify
let evaluate validationSet classifier =
    validationSet
    |> Array.averageBy (fun x -> 
        if classifier x.Pixels = x.Label then 1. else 0.)
    |> printfn "Correct: %.3f"
let trainingPath = __SOURCE_DIRECTORY__ + @"/trainingsample.csv"
let training = reader trainingPath    
let validationPath = __SOURCE_DIRECTORY__ + @"/validationsample.csv"
let validation = reader validationPath

let manhattanModel = train training manhattanDistance
let euclideanModel = train training euclideanDistance
printfn "Manhattan distance result: "
evaluate validation manhattanModel
printfn "Euclidean distance result: "
evaluate validation euclideanModel