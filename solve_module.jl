include("play_module.jl")

function read_problem()
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
        len = length(lines[1])
        if len ∉ [9, 11, 13]
            println("Incorrect grid format!")
            exit()
        end

        grid = []
        for line ∈ lines
            if length(line) ≠ len
                println("Incorrect grid format!")
                exit()
            end
            push!(grid, map(n -> parse(UInt8, n), split(line, ',')))
        end

        n = convert(UInt8, length(grid))
        if n ∉ [0x05, 0x06, 0x07]
            println("Incorrect grid format!")
            exit()
        end
        grid = mapreduce(permutedims, vcat, grid)

        (grid, n)
end

function search_solution(grid::Matrix{UInt8}, row::UInt8, col::UInt8, n::UInt8)
    sleep(0.02)
    run(`clear`)
    showGrid(grid, n)
    sum(grid) == 0x00 && return true
    (row > n || col > n) && return false

    row > 0x01 && col > 0x01 && grid[row - 0x01, col - 0x01] == 0x01 && return false
    col == 0x01 && row > 0x02 && grid[row - 0x02, n - 0x01] == 0x01 && return false


    next_row, next_col = row, col + 0x01
    if next_col >= n
        next_row += 0x01
        next_col = 0x01
    end

    toggle(grid, [row, col], n)
    search_solution(grid, next_row, next_col, n) && return true

    toggle(grid, [row, col], n)
    return search_solution(grid, next_row, next_col, n)
end

export read_problem, search_solution
