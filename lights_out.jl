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
end

function toggle(grid::Matrix{UInt8}, coord::Vector{UInt8})
	println(grid[coord[1], coord[2]])
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
run(`clear`)
showGrid(grid, n)

