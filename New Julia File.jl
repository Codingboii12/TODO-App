using DataStructures
using REPL.TerminalMenus

function lineNumber(arr:: Array)
    var = 1
    arr1 = String[]
    for i in arr
        push!(arr1, "$(var): $(i)")
        var += 1
    end
    return arr1
end

printstyled("Welcome to TODO App :D", "\n\n", color = :light_blue, bold = true)
options = ["Display", "Add", "Delete" ,"Complete", "Update", "Empty" ,"Quit", "Clear Screen"]
file1 = open("local.txt", "r")
tasks = readlines(file1)
TerminalMenus.config(
    cursor= '→',
    up_arrow = '↑',
    down_arrow = '↓',
)
while true
    menu = RadioMenu(options, pagesize = 8)
    user = request("\nEnter a Command: ", menu)
    print("\n")

    if user == 7
        printstyled("Byeeee", color = :light_magenta)
        file = open("local.txt", "w")
        len = length(tasks)
        for i in 1:len
            if i != len
                print(file, "$(tasks[i])\n")
            else
                print(file, tasks[i])
            end
        end
        break

    elseif user == 8
        print("\033c")
        printstyled("Welcome to TODO App :D", "\n\n", color = :light_blue, bold = true)

    elseif user == 3
        if tasks == []
            printstyled("No Tasks!\n\n", underline = true)
        else
            delMenu = MultiSelectMenu(lineNumber(tasks))
            delNo = request("Choose the Task to be Deleted: ", delMenu)
            for i in delNo
                printstyled("This task will be deleted: $(tasks[i])\n", color = :red)
                deleteat!(tasks, i)
            end

            if tasks == []
                printstyled("No Tasks!\n\n", underline = true)
            else
                print("Current Tasks: ")
                for j in lineNumber(tasks)
                    print(j)
                end
            end
        end

    elseif user == 4
        if tasks == []
            printstyled("No Tasks!\n\n", underline = true)
        else
            compMenu = MultiSelectMenu(lineNumber(tasks), pagesize = 4)
            compNo = request("Choose the task that you have completed: ", compMenu)
            for i in compNo
                printstyled("Congratulations, you have completed this task successfully: $(tasks[i])\n", color = :light_green)
                deleteat!(tasks, i)
            end
            if tasks == []
                printstyled("No Tasks!\n\n", underline = true)
            else
                print("Current Tasks: ")
                for j in lineNumber(tasks)
                    print(j, "\n")
                end
            end
        end
        
    elseif user == 5
        if tasks == []
            printstyled("No Tasks!\n\n", underline = true)
        else
            updMenu = RadioMenu(lineNumber(tasks), pagesize = 4)
            updNo = request("Choose the task you want to update: ", updMenu)
            print("What do you want to update it to: ")
            upd1 = readline()
            printstyled("$(tasks[updNo]) has been updated to $(upd1)\n\n", color = :light_yellow)
            tasks[updNo] = upd1
            if tasks == []
                printstyled("No Tasks!\n\n", underline = true)
            else
                print("Current Tasks: ")
                for i in lineNumber(tasks)
                    print(i, "\n")
                end
            end
        end

    elseif user == 2
        print("Enter the Task: ")
        add = readline()
        push!(tasks, add)
        print("Current Tasks: ")
        for i in lineNumber(tasks)
            print(i, "\n")
        end

    elseif user == 6 
        if tasks == []
            printstyled("No Tasks!\n\n", underline = true)
        else
            printstyled("No Tasks Anymore! Add one now!\n", color = :light_black)
            empty!(tasks)
        end
    elseif user == 1
        if tasks == []
            print("No Tasks!")
        else
            print("Current Tasks: ")
            for i in lineNumber(tasks)
                print(i, "\n")
            end
        end
    else
        print("Invalid Option\n")
    end
end