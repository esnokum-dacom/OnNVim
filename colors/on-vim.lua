local pc = dofile(os.getenv("HOME") .. "/.cache/wal/colors.lua")

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "on-vim"

C = {
    bg = pc.background,
    fg = pc.foreground,
    cinnamon = pc.colors.color0,
    red = pc.colors.color1,
    green = pc.colors.color2,
    blue = pc.colors.color3,
    magenta = pc.colors.color4,
    yellow = pc.colors.color5,
    cyan = pc.colors.color6,
    gray = pc.colors.color7,
    comment = pc.colors.color9,
    cursor = pc.colors.color8,
}

local hl = function(g, opts)
    vim.api.nvim_set_hl(0, g, opts)
end

hl("Normal", { fg = C.fg, bg = C.bg })
hl("NormalFloat", { fg = C.fg, bg = C.bg })
hl("Cursor", { fg = C.green, bg = C.red })
hl("LineNr", { fg = C.fg, bg = C.bg })
hl("CursorLine", { fg = C.fg, bg = C.red })
hl("CursorLineNr", { fg = C.cinnamon, bg = C.red })
hl("Comment", { fg = C.fg, bg = C.bg })
hl("Visual", { fg = C.comment, bg = C.green, bold = true })
hl("StatusLine", { fg = C.fg, bg = C.bg })

-- syntax

hl("Keyword", { fg = C.magenta, bold = true })
hl("FunCtion", { fg = C.blue })
hl("String", { fg = C.green })
hl("Number", { fg = C.yellow })
hl("Type", { fg = C.cyan })
hl("Constant", { fg = C.red })
hl("Operator", { fg = C.fg })
hl("Delimiter", { fg = C.fg })

-- LSP

hl("DiagnostiCError", { fg = C.red })
hl("DiagnostiCWarn", { fg = C.yellow })
hl("DiagnostiCInfo", { fg = C.blue })
hl("DiagnostiCHint", { fg = C.cyan })
hl("netrwDir", { fg = C.green })

-- ETC
hl("@variable", { fg = C.fg, italic = true })
hl("cInclude", { fg = C.fg, italic = true })
hl("@property", { fg = C.green })
hl("@type.builtin", { fg = C.cyan })
hl("@keyword.modifier", { fg = C.cyan })
hl("@keyword.import", { fg = C.magenta })
hl("@variable.builtin", { fg = C.red })
hl("@funCtion", { fg = C.blue })
hl("@funCtion.Call", { fg = C.blue })
hl("@keyword", { fg = C.magenta, bold = true })
hl("@string", { fg = C.green })
hl("@Comment", { fg = C.Comment })
hl("@type", { fg = C.cyan })
hl("@tag", { fg = C.red })
hl("@attribute", { fg = C.yellow })
hl("@punCtuation", { fg = C.green })
hl("@punCtuation.braCket", { fg = C.Cursor })
hl("@ConstruCtor", { fg = C.green })

hl("ModeMsg", { fg = C.red })
hl("MoreMsg", { fg = C.red })
hl("Question", { fg = C.red })

hl("Tag", { fg = C.red })
hl("SpeCial", { fg = C.red })
hl("SpeCialChar", { fg = C.red })
hl("SpeCialComment", { fg = C.red })
hl("Debug", { fg = C.red })

-- blink.cmp
hl("BlinkCmpMenu", { fg = C.red, bg = "NONE" })
hl("BlinkCmpMenuBorder", { fg = C.red, bg = "NONE" })
hl("BlinkCmpMenuSelectionMenuSelection", { fg = C.green, bg = C.red })
hl("BlinkCmpDoc", { fg = C.red, bg = "NONE" })
hl("BlinkCmpDocBorder", { fg = C.red, bg = "NONE" })
hl("BlinkCmpDocCursorLine", { fg = C.green, bg = C.red })
hl("BlinkCmpGhostText", { fg = C.gray })
