local headlines = require "headlines"
if not headlines then return end

local options = {
    query = vim.treesitter.query.parse(
        "markdown",
        [[
            (atx_heading [
                (atx_h1_marker)
                (atx_h2_marker)
                (atx_h3_marker)
                (atx_h4_marker)
                (atx_h5_marker)
                (atx_h6_marker)
            ] @headline)

            (thematic_break) @dash

            (fenced_code_block) @codeblock

            (block_quote_marker) @quote
            (block_quote (paragraph (inline (block_continuation) @quote)))
            (block_quote (paragraph (block_continuation) @quote))
            (block_quote (block_continuation) @quote)
        ]]
    ),
    headline_highlights = { "Headline" },
    bullet_highlights = {
        "@text.title.1.marker.markdown",
        "@text.title.2.marker.markdown",
        "@text.title.3.marker.markdown",
        "@text.title.4.marker.markdown",
        "@text.title.5.marker.markdown",
        "@text.title.6.marker.markdown",
    },
    bullets = { "◉", "○", "✸", "✿" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = false,
    fat_headline_upper_string = "▃",
    fat_headline_lower_string = "🬂",
}

headlines.setup {
    markdown = options,
    rmd = options,
    norg = options,
    org = options,
}

local highlights = {
    CodeBlock = "CursorLine",
    markdownCode = "CursorLine",
    -- "@markup.raw.markdown_inline = { bg = "CursorLine", fg = "markdownCode"},
}

for k, v in pairs(highlights) do
    vim.api.nvim_set_hl(0, k, { link = v })
end
