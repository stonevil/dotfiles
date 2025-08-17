return {
	"huggingface/llm.nvim",
	event = "VeryLazy",
	opts = {
		backend = "ollama",
		model = "codellama:13b-instruct",
		url = "http://localhost:11434", -- llm-ls uses "/api/generate"
		-- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
		fim = {
			enabled = true,
			prefix = "<｜fim▁begin｜>",
			suffix = "<｜fim▁hole｜>",
			middle = "<｜fim▁end｜>",
		},
		request_body = {
			-- Modelfile options for the model you use
			options = {
				temperature = 0.2,
				top_p = 0.95,
			},
		},
	},
}
