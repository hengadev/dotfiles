local map = require("utils.map").set_prefix("Telescope")

return function()
    map("<leader>th", function()
        require("telescope").extensions.themes.themes_picker()
    end, "Toggle [TH]eme Picker for NVChad themes")

    map("<leader>sp", function()
        require("telescope").extensions.provider.provider_picker({
            previewer = false,
        })
    end, "[S]et Avante [P]rovider")
end
