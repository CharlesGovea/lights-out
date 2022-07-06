function setSize(mode::UInt8)
    mode == 0x01 && return 0x05
    mode == 0x02 && return 0x06
    0x07
end

function showGrid(grid::Matrix{UInt8}, n::UInt8)
    for i ∈ 1:n
        for j ∈ 1:n
	    if grid[i, j] == 0x01
	        print("🌕 ")
	    else
	        print("🌑 ")
	    end
	end
	println()
    end
    println()
end

function toggle(grid::Matrix{UInt8}, coord::Vector{UInt8}, n::UInt8)
    grid[coord[1], coord[2]] = grid[coord[1], coord[2]] ⊻ 0x01

    if coord[1] > 0x01
        grid[coord[1] - 0x01, coord[2]] = grid[coord[1] - 0x01, coord[2]] ⊻ 0x01
    end
    if coord[1] + 0x01 <= n
        grid[coord[1] + 0x01, coord[2]] = grid[coord[1] + 0x01, coord[2]] ⊻ 0x01
    end
    if coord[2] > 0x01
        grid[coord[1], coord[2] - 0x01] = grid[coord[1], coord[2] - 0x01] ⊻ 0x01
    end
    if coord[2] + 0x01 <= n
        grid[coord[1], coord[2] + 0x01] = grid[coord[1], coord[2] + 0x01] ⊻ 0x01
    end

    grid
end

function gameMenu()
    n = 0x00

    println("---Play---\n\nSolve a randomly generated board of lights!\nSelect the level of difficulty:\n\n1. Classic (5x5)\n2. Deluxe (6x6)\n3. Hard (7x7)\n")
    while n < 0x01 || n > 0x03
        print(">Select a game mode[1/2/3]: ")
        try
            n = parse(UInt8, readline())
        catch
            continue
        end
    end

    n
end

function initGame()
    n = setSize(gameMenu())
    grid = rand((0x00, 0x01), n, n)

    while true
        run(`clear`)
        sum(grid) == 0 && break
        showGrid(grid, n)
        print("Insert coordinates[x,y]: ")
        try
            coord = parse.( UInt8, split(readline(), ',') )
            grid = toggle(grid, coord, n)
        catch
            continue
        end
    end
    println("\n🎉🎉 Success!! 🎉🎉")
end

export initGame, showGrid, toggle
