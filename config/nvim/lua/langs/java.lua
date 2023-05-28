local javaHome = ""
local osDir = ""
local conf_dir = vim.fn.stdpath("config")

if vim.fn.has("linux") then
	javaHome = "/usr/lib/jvm/default"
	osDir = "/config_linux"
elseif vim.fn.has("win32") then
	javaHome = "" -- TODO set windows jdk path
	osDir = "/config_win"
end

local jdtls_path = conf_dir .. "/bin/jdtls"

local cache_path = conf_dir .. "/cache/jdtls"
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
		'--illegal-access=deny',
  	'--add-opens', 'java.base/java.util=ALL-UNNAMED',
  	'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  	'-configuration', jdtls_path .. osDir,
		'-data', cache_path .. "/" ..  vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	},
	flags = {
    debounce_text_changes = 150,
    allow_incremental_sync = true
  },
	root_dir = function(fname)
		return require('lspconfig').util.root_pattern('pom.xml', 'gradle.build', '.git', 'mvnw', 'build.gradle.kts')(fname) or vim.fn.getcwd()
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
  },
	on_attach = function (_, buf)
		local keymap = vim.api.nvim_buf_set_keymap
		keymap(
			buf,
			"n",
			"<LEADER>ca",
			"<cmd>:LspSaga code_action<CR>"
		)
	end,
}

return config
