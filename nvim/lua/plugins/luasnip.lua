-- TODO : Configurer cela de telle sorte que je puisse avoir des snipets pour les langages de programmation que j'utilise. Exemple :
-- Si j'ouvre un fichier c++ je veux que le int main soit deja preremplie par exemple ou que je puisse avoir une commande qui puisse le faire a ma place,
-- un peu comme le doctype prerempli avec emmet

local M = {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    config = true,
}

return M
