local NASM = "nasm "
local NASM_ARGS = " -f macho64 -g"

local LINKER = "ld"
local LINKER_ARGS = " -static"

local SOURCES = {
    "MAIN.ASM",
    "PRINT.ASM",
    "TRIANGLE.ASM",
    "EXIT.ASM"
}

local EXEC_FILE = "triangle.exec"

local function file_exists(file)
    if not io.open(file, "r") then return false else return true end
end

local function merge_stringarray(strarray, seperator)
    for i, value in ipairs(strarray) do
        strarray[i] = strarray[i] .. seperator
    end

    local str = strarray[1]
    for i, value in ipairs(strarray) do
        if i == 1 then goto continue end
        str = str .. value
        ::continue::
    end
    return str
end

if file_exists(EXEC_FILE) then os.remove(EXEC_FILE) end

for index, value in ipairs(SOURCES) do
    local nasmcmd = NASM .. value .. NASM_ARGS .. " -o " .. value .. ".o"
    print(nasmcmd)
    os.execute(nasmcmd)
end

local OBJECTS = merge_stringarray(SOURCES, ".o ")

local ldcmd = LINKER .. LINKER_ARGS .. " " .. OBJECTS .. " -o " .. EXEC_FILE
print(ldcmd)
os.execute(ldcmd)

local dumpfile = io.open("dump.asm", "w")
dumpfile:write(io.popen("objdump -x86-asm-syntax=intel -D " .. EXEC_FILE, "r"):read("a"))
dumpfile:close()

os.execute("rm -rf " .. OBJECTS)
