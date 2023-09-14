package.path = package.path..";"..clink.get_env("CMDER_ROOT").."\\config\\?.lua"

local filters = require("filters")
local gitprompt = require("gitprompt")


local function fancy_prompt()
    -- get_cwd() is differently encoded than the clink.prompt.value, so everything other than
    -- pure ASCII will get garbled. So try to parse the current directory from the original prompt
    -- and only if that doesn't work, use get_cwd() directly.
    -- The matching relies on the default prompt which ends in X:\PATH\PATH>
    -- (no network path possible here!)
    local old_prompt = clink.prompt.value
    local cwd = old_prompt:match('.*(.:[^>]*)>')
    if cwd == nil then cwd = clink.get_cwd() end

    -- environment systems like pythons virtualenv change the PROMPT and usually
    -- set some variable. But the variables are differently named and we would never
    -- get them all, so try to parse the env name out of the PROMPT.
    -- envs are usually put in round or square parentheses and before the old prompt
    local env = old_prompt:match('.*%(([^%)]+)%).+:')
    -- also check for square brackets
    if env == nil then env = old_prompt:match('.*%[([^%]]+)%].+:') end

	local me = "will"
	local host = clink.get_env("COMPUTERNAME")
    -- {gitinfo} is subbed in later in the function `git_prompt_filter`
	local cmder_prompt = "\x1b[1;34;40m{me}@{host} \x1b[1;32;40m{cwd} {gitinfo} \n\x1b[1;31;40m{venvinfo}\x1b[0m"
    cmder_prompt = string.gsub(cmder_prompt, "{cwd}", filters.verbatim(cwd))
	cmder_prompt = string.gsub(cmder_prompt, "{me}", filters.verbatim(me))
	cmder_prompt = string.gsub(cmder_prompt, "{host}", filters.verbatim(host))

    if env ~= nil then
        venvinfo = "("..env..") "
    else
        venvinfo = ""
    end
    clink.prompt.value = string.gsub(cmder_prompt, "{venvinfo}", filters.verbatim(venvinfo))
end


-- insert the set_prompt at the very beginning so that it runs first
clink.prompt.register_filter(fancy_prompt, 1)
clink.prompt.register_filter(gitprompt.git_prompt_filter, 50)
clink.prompt.register_filter(filters.percent, 51)