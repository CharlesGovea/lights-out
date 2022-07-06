include("lights_out.jl")

println("---Lights Out---\n\nThe objective of the game is to turn off all the lights. Each light you toggle will toggle the adjacent lights as well!")
println("\n\n1. Play\n2. Solve\n")

mode = 0x00
while mode < 0x01 || mode > 0x02
    print(">Select a game mode[1/2]: ")
    try
	    global mode = parse(UInt8, readline())
    catch
	    continue
    end
end

if mode > 0x01
    while true
        print("Insert filename: ")
        try
            global file = open(readline(), "r")
            break
        catch
            println("Error! File not found!")
            continue
        end
    end

    lines = readlines(file)
    grid = []
    for line in lines
        push!(grid, map(n -> parse(UInt8, n), split(line, ',')))
    end

    n = convert(UInt8, length(grid))
    grid = mapreduce(permutedims, vcat, grid)

    run(`clear`)
    showGrid(grid, n)
else
    run(`clear`)
    initGame()
end
