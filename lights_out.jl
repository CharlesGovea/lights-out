function setSize(mode::UInt8)
    mode == 0x01 && return 0x05
    mode == 0x02 && return 0x06
    0x07
end

function showGrid(grid::Matrix{UInt8}, n::UInt8)
    for i ∈ 1:n
        for j ∈ 1:n
	    print(grid[i, j], ' ')
	end
	println()
    end
    println()
end

function toggle(light::UInt8)
    light == 0x00 && return 0x01
    light >> 1
end

function toggle(grid::Matrix{UInt8}, coord::Vector{UInt8}, n::UInt8)
    grid[coord[1], coord[2]] = toggle(grid[coord[1], coord[2]])
    adjacent = []
    coord[1] > 0x01 && push!(adjacent, (coord[1] - 0x01, coord[2]))
    coord[1] + 0x01 <= n && push!(adjacent, (coord[1] + 0x01, coord[2]))
    coord[2] > 0x01 && push!(adjacent, (coord[1], coord[2] - 0x01))
    coord[2] + 0x01 <= n && push!(adjacent, (coord[1], coord[2] + 0x01))
    for xy ∈ adjacent
        grid[xy[1], xy[2]] = toggle(grid[xy[1], xy[2]])
    end
    grid
end

#------------Main-------------
n = 0x00

println("---Lights Out---\n\nThe objective of the game is to turn off all the lights. Each light you toggle will toggle the adjacent lights as well!\n\n1. Classic (5x5)\n2. Deluxe (6x6)\n3. Hard (7x7)\n")
while n < 0x01 || n > 0x03
    print(">Select a game mode[1/2/3]: ")
    try
	global n = parse(UInt8, readline())
    catch
	continue
    end
end

n = setSize(n)
grid = rand((0x00, 0x01), n, n)

while true
    run(`clear`)
    sum(grid) == 0 && break
    showGrid(grid, n)
    print("Insert coordinates[x,y]: ")
    try
        coord = parse.( UInt8, split(readline(), ',') )
	global grid = toggle(grid, coord, n)
    catch
        continue
    end
end
println("\n🎉🎉 Success!! 🎉🎉")
