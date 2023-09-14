package.path = package.path..";"..clink.get_env("CMDER_ROOT").."\\config\\?.lua"
local filters = require("filters")

local gitprompt = {}

local function get_git_dir(path)

    -- return parent path for specified entry (either file or directory)
    local function pathname(path)
        local prefix = ""
        local i = path:find("[\\/:][^\\/:]*$")
        if i then
            prefix = path:sub(1, i-1)
        end

        return prefix
    end

    -- Checks if provided directory contains git directory
    local function has_git_dir(dir)
        return clink.is_dir(dir..'/.git') and dir..'/.git'
    end

    local function has_git_file(dir)
        local gitfile = io.open(dir..'/.git')
        if not gitfile then return false end

        local git_dir = gitfile:read():match('gitdir: (.*)')
        gitfile:close()

        return git_dir and dir..'/'..git_dir
    end

    -- Set default path to current directory
    if not path or path == '.' then path = clink.get_cwd() end

    -- Calculate parent path now otherwise we won't be
    -- able to do that inside of logical operator
    local parent_path = pathname(path)

    return has_git_dir(path)
        or has_git_file(path)
        -- Otherwise go up one level and make a recursive call
        or (parent_path ~= path and get_git_dir(parent_path) or nil)
end

---
-- Find out current branch
-- @return {nil|git branch name}
---
local function get_git_branch(git_dir)
    git_dir = git_dir or get_git_dir()

    -- If git directory not found then we're probably outside of repo
    -- or something went wrong. The same is when head_file is nil
    local head_file = git_dir and io.open(git_dir..'/HEAD')
    if not head_file then return end

    local HEAD = head_file:read()
    head_file:close()

    -- if HEAD matches branch expression, then we're on named branch
    -- otherwise it is a detached commit
    local branch_name = HEAD:match('ref: refs/heads/(.+)')

    return branch_name or 'HEAD detached at '..HEAD:sub(1, 7)
end

local function get_number_of_modified_files()
    local hdl = io.popen("git status -s -uno | wc -l")
    return tonumber(hdl:read("*all"))  
end

local function get_number_of_untracked_files()
    local hdl = io.popen("git ls-files --others --exclude-standard | wc -l")
    return tonumber(hdl:read("*all"))
end

local function get_number_of_conflicts()
    local hdl = io.popen("git diff --name-only --diff-filter=U | wc -l")
    return tonumber(hdl:read("*all"))
end

function gitprompt.git_prompt_filter()

    -- Colors for git status
    local colors = {
        white = "\x1b[1;37;40m",
        red = "\x1b[1;37;31m",
        green = "\x1b[37;32m"
    }

    local git_dir = get_git_dir()
    if git_dir then
        -- if we're inside of git repo then try to detect current branch
        local branch = get_git_branch(git_dir)
        local color
        if branch then
            -- Has branch => therefore it is a git folder, now figure out status
            local numConflicts = get_number_of_conflicts()
            local numModFiles = get_number_of_modified_files()
            local numUntrackedFiles = get_number_of_untracked_files()

            local fileStatusMessages= {}
            color = colors.green

            if numModFiles > 0 then
                table.insert(fileStatusMessages, numModFiles .." MODIFIED")
            end

            if numUntrackedFiles > 0 then
                table.insert(fileStatusMessages, numUntrackedFiles .." UNTRACKED")
            end

            if numConflicts > 0 then
                table.insert(fileStatusMessages, numConflictsFiles .." CONFLICTS")
            end
            
            local message = "CLEAN"
            color = colors.green
            if #fileStatusMessages > 0 then
                color = colors.red
                message = table.concat(fileStatusMessages, ", ")
                
            end
            
            message = " >> [" ..message .."]"
            clink.prompt.value = string.gsub(clink.prompt.value, "{gitinfo}", colors.white .."("..filters.verbatim(branch)..")" ..color ..message ..colors.white)
            return false
        end
    end

    -- No git present or not in git file
    clink.prompt.value = string.gsub(clink.prompt.value, "{gitinfo}", "")
    return false
end

return gitprompt