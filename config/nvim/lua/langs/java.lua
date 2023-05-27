local javaHome = ""
local configDir = ""
local cof_dir = vim.fn.stdpath("config")

if vim.fn.has("linux") then
	javaHome = "/usr/lib/jvm/default"
	configDir = "/config_linux"
elseif vim.fn.has("win32") then
	javaHome = "" -- TODO set windows jdk path
	configDir = "/config_win"
end

local jdtls_path = cof_dir .. "/bin/jdtls"

local function on_init(client)
  if client.config.settings then
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end
end

local cache_path = configDir .. "/cache/jdtls"
if vim.fn.isdirectory(cache_path) ~= 1 then
  vim.fn.mkdir(cache_path, 'p')
end


local config = {
	cmd = {
		javaHome .. '/bin/java',
		'-jar',  jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
  	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
  	'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
  	'-Dlog.protocol=true',
  	'-Dlog.level=ALL',
		--'-Djdk.internal.module.system.packages=jdk.incubator.*',
  	--'--add-modules=ALL-SYSTEM',
		--'--illegal-access=deny',
  	'--add-opens', 'java.base/java.util=ALL-UNNAMED',
  	'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  	'-configuration', jdtls_path .. configDir,
		'-data', cache_path
	},
	flags = {
    debounce_text_changes = 150,
    allow_incremental_sync = true
  },
	root_dir = function()
		return vim.fs.dirname(vim.fs.find({ 'pom.xml', '.gradlew', '.gitignore', 'mvnw', 'build.grade.kts' }, { upward = true })[1])
	end,
	settings = {
    java = {
      signatureHelp = {
				enabled = true
      },
      saveActions = {
        organizeImports = true
			},
      completion = {
        maxResults = 20,
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      },
			on_init = on_init,
      sources = {
        organizeImports = {
        	starThreshold = 9999,
        	staticStarThreshold = 9999
        }
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        }
      }
    }
  }
}

config.on_attach = function ()
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "*.java",
		desc = "Starting java language server",
		callback = function ()
			vim.api.nvim_create_autocmd("LspAttach", {
    		callback = function(args)
					local keymap = vim.keymap.set
      		local buff = args.buf
					keymap(
						"n",
						"<Leader>di",
						"<Cmd>lua require'jdtls'.organize_imports()<CR>",
  					{ buffer = buff, desc = "Organize Imports" }
					)
					keymap(
						"n",
    				"<leader>dt",
      			"<Cmd>lua require'jdtls'.test_class()<CR>",
    				{ buffer = buff, desc = "Test Class" }
					)
					keymap(
						{ "i", "n" },
						"<C-S-I>",
						"<cmd>lua vim.lsp.buf.formatting()<CR>",
						{ buffer = buff }
					)
					return true
    		end,
  		})
		end
	})
end


return config
