local filters = {}

function filters.verbatim(s)
    s = string.gsub(s, "%%", "%%%%")
    return s
end

function filters.percent()
    clink.prompt.value = string.gsub(clink.prompt.value, "{percent}", "%%")
end

return filters