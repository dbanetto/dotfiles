return {
    strategies = {
        chat = { adapter = "granite4_7b", },
        inline = { adapter = "granite4_7b", },
        cmd = { adapter = "granite4_7b", }
    },
    adapters = {
        http = {
            granite4_7b = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "granite4_7b",
                    opts = {
                        vision = true,
                        stream = true,
                    },
                    schema = {
                        model = {
                            default = "granite4:7b-a1b-h",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        think = {
                            default = false,
                        },
                        keep_alive = {
                            default = "5m",
                        },
                    },
                })
            end,
            qwen38b = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "qwen38b", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    opts = {
                        vision = true,
                        stream = true,
                    },
                    schema = {
                        model = {
                            default = "qwen3:8b",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        think = {
                            default = false,
                        },
                        keep_alive = {
                            default = "5m",
                        },
                    },
                })
            end,
            gemma34b = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "gemma34b", -- Give this adapter a different name to differentiate it from the default ollama adapter
                    opts = {
                        vision = true,
                        stream = true,
                    },
                    schema = {
                        model = {
                            default = "gemma3:4b",
                        },
                        num_ctx = {
                            default = 16384,
                        },
                        think = {
                            default = false,
                        },
                        keep_alive = {
                            default = "5m",
                        },
                    },
                })
            end,

        },
    },
}
