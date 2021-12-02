local NASM = "nasm "
local NASM_ARGS = " -f macho64 -g"

local LINKER = "ld"
local LINKER_ARGS = " -static"

local SOURCE_FILE = "CHECK_TRIANGLE.ASM"
local OBJECT_FILE = "triangle.o"
local EXEC_FILE = "triangle.exec"

local function file_exists(file)
    if not io.open(file, "r") then return false else return true end
end

if file_exists(OBJECT_FILE) then os.remove(OBJECT_FILE) end
if file_exists(EXEC_FILE) then os.remove(EXEC_FILE) end

local nasmcmd = NASM .. SOURCE_FILE .. NASM_ARGS .. " -o " .. OBJECT_FILE
print(nasmcmd)
os.execute(nasmcmd)

local ldcmd = LINKER .. LINKER_ARGS .. " " .. OBJECT_FILE .. " -o " .. EXEC_FILE
print(ldcmd)
os.execute(ldcmd)

local dumpfile = io.open("dump.asm", "w")
dumpfile:write(io.popen("objdump -x86-asm-syntax=intel -D " .. EXEC_FILE, "r"):read("a"))
dumpfile:close()
