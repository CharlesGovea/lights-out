include("play_module.jl")
include("solve_module.jl")

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
    grid, n = read_problem()

    run(`clear`)
    println("---Solving---\n\n")
    showGrid(grid, n)
    print("In 3...")
    sleep(1)
    print("2...")
    sleep(1)
    print("1...")
    sleep(1)

    if search_solution(grid, 0x01, 0x01, n)
        println("Solution found! 🎉🎉🎉")
    else
        println("🚫No results found!🚫")
    end
else
    run(`clear`)
    initGame()
end
