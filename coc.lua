--TODO: unshittify this, possibly by removing redundant/unnecessary plugins
--and splitting this into multiple modules
--maybe learning lua

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'
vim.opt.numberwidth = 3
vim.opt.fillchars:append { vert = '|' }
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.cursorline = false
vim.opt.laststatus = 2
vim.opt.termguicolors = true

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- Enable case-insensitive search and highlight matchesk
vim.opt.foldlevel = 99 -- This sets the default fold level to 99, effectively opening all folds
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.incsearch = true

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Enable mouse support
vim.o.mouse = 'a'
vim.opt.updatetime = 300
vim.opt.colorcolumn = ''
-- Enable autoread
vim.opt.autoread = true

-- Create an autocommand group
vim.api.nvim_create_augroup('CheckTimeOnCursorHold', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', {
  group = 'CheckTimeOnCursorHold',
  pattern = '*',
  command = 'checktime',
})

-- Toggle between absolute and relative line numbers with F2
vim.api.nvim_set_keymap('n', '<F7>', ':set relativenumber!<CR>', { noremap = true, silent = true })

-- Center the screen when moving half a page up or down
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true })

-- Remap window navigation keys
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })
-- Vertical split with Ctrl+v
vim.keymap.set('n', '<leader><A-e>', ':vsplit<CR>', { noremap = true, silent = true })

-- Horizontal split with Ctrl+h
vim.keymap.set('n', '<leader><A-o>', ':split<CR>', { noremap = true, silent = true })

-- Command-line mappings for history navigation
vim.api.nvim_set_keymap('c', '<C-p>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-n>', '<Down>', { noremap = true })

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('x', '<leader>p', '"_dP')

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' } -- Set markdown file types for the preview
    end,
    config = function()
      vim.keymap.set('n', '<Leader>mp', '<Plug>MarkdownPreview', { desc = 'Markdown Preview' }) -- Key mapping for Markdown Preview
    end,
  },
  { 'kkharji/sqlite.lua' },
  {
    'nvim-telescope/telescope-frecency.nvim',
    config = function()
      require('telescope').load_extension 'frecency'
    end,
  },

  { 'nvim-telescope/telescope-dap.nvim' },
  { 'fannheyward/telescope-coc.nvim' },

  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  }, -- Mason package manager
  { 'williamboman/mason-lspconfig.nvim' }, -- Mason LSP integration
  { 'fatih/vim-go', ft = 'go' },
  { 'nvim-lualine/lualine.nvim' }, -- Status line
  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      function _G.check_back_space()
        local col = vim.fn.col '.' - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
      end

      vim.api.nvim_create_augroup('CocGroup', {})
      vim.api.nvim_create_autocmd('CursorHold', {
        group = 'CocGroup',
        command = "silent call CocActionAsync('highlight')",
        desc = 'Highlight symbol under cursor on CursorHold',
      })

      -- Trigger completion with <C-space>
      vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { noremap = true, silent = true, expr = true })
      vim.api.nvim_set_keymap('n', '<leader>cd', ':CocList diagnostics<CR>', { noremap = true, silent = true }) -- Show diagnostics
      vim.api.nvim_set_keymap('n', '<space>p', ':<C-u>CocListResume<CR>', { noremap = true, silent = true })
    end,
  },
  { 'AndrewRadev/splitjoin.vim' },
  { 'akinsho/toggleterm.nvim', config = true }, -- Automatically load with default config
  --  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify' -- Set as the default notify handler
      require('notify').setup {
        stages = 'fade',
        timeout = 3000,
        background_colour = '#000000',
      }
    end,
    event = 'VeryLazy', -- Load after other plugins
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Ensure nvim-treesitter is loaded
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin (can be toggled on/off)
        max_lines = 3, -- How many lines the context window should show
        trim_scope = 'outer', -- Remove lines from outer context when exceeded
        min_window_height = 0, -- Only show context if the window is larger than this value
        mode = 'cursor', -- Line used to calculate context ('cursor' or 'topline')
        separator = '-', -- Separator for the context line
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- Callback when context is attached to buffer
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' }, -- For file icons
    config = function()
      vim.g.nvim_tree_respect_buf_cwd = 1
      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
      require('nvim-tree').setup {
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        -- Disable netrw, it conflicts with nvim-tree
        disable_netrw = true,
        hijack_netrw = true,

        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        -- View settings
        view = {
          width = 30, -- Width of the tree
          side = 'left', -- Positioning of the tree
          adaptive_size = true, -- Do not auto-resize the tree
          number = true, -- Show line numbers
          relativenumber = true, -- Use relative line numbers if you want
        },

        -- Add icons to the tree
        renderer = {
          highlight_git = true, -- Highlight Git status
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },

        -- Git integration settings
        git = {
          enable = true,
          ignore = false,
        },

        -- Filters
        filters = {
          dotfiles = false, -- Show dotfiles
          custom = { '.git', 'node_modules' }, -- Hide .git and node_modules
        },
      }
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<A-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<A-1>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<A-2>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<A-3>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<A-4>', function()
        harpoon:list():select(4)
      end)
      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { desc = 'Toggle UndoTree' })
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>', {})
      vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', { desc = 'Git Diff Split' })
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git Blame' })
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required dependency
    },
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '┃' }, -- Sign for added lines
          change = { text = '┃' }, -- Sign for changed lines
          delete = { text = '✖' }, -- Sign for deleted lines
          topdelete = { text = '✖' }, -- Sign for deleted lines at the top
          changedelete = { text = '≃' }, -- Sign for changed lines that were deleted
        },
        numhl = false, -- Highlight line numbers
        linehl = false, -- Highlight the entire line
        word_diff = false, -- Enable word diff for inline changes
        current_line_blame = false, -- Enable current line blame
        current_line_blame_opts = {
          delay = 200, -- Delay before displaying blame info
          virt_text_pos = 'eol', -- Position of virtual text at the end of the line
        },
      }
      vim.api.nvim_set_keymap('n', '<leader>hb', ":lua require'gitsigns'.blame_line()<CR>", { noremap = true, silent = true, desc = 'Blame line' })
    end,
  },
  {
    'szw/vim-maximizer',
    config = function()
      vim.keymap.set('n', '<M-CR>', ':MaximizerToggle<CR>', {})
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = 'hard' -- Options: 'hard', 'soft', 'medium'
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  -- {
  -- 	"folke/tokyonight.nvim",
  -- 	lazy = false,
  -- 	priority = 1000,
  -- 	opts = {},
  -- },

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim', -- Improves responsiveness
      'nvim-neotest/neotest-go', -- Go adapter
    },

    config = function()
      local neotest = require 'neotest'
      neotest.setup {
        adapters = {
          require 'neotest-go' {},
        },
      }

      -- Add keymaps for running tests
      vim.keymap.set('n', '<leader>tx', function()
        require('neotest').run.stop { strategy = 'all', interactive = true }
      end, { desc = 'Stop all Neotest tests' })
      vim.api.nvim_set_keymap('n', '<leader>tt', "<cmd>lua require('neotest').run.run()<CR>", { noremap = true, desc = 'Run nearest test' })
      vim.api.nvim_set_keymap(
        'n',
        '<leader>tf',
        "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
        { noremap = true, desc = 'Run all tests in file' }
      )
      vim.api.nvim_set_keymap(
        'n',
        '<leader>ta',
        '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',
        { noremap = true, silent = true, desc = 'Run all tests' }
      )
      vim.api.nvim_set_keymap('n', '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<CR>", { noremap = true, desc = 'Toggle sumary' })
      vim.api.nvim_set_keymap('n', '<leader>to', "<cmd>lua require('neotest').output_panel.toggle()<CR>", { noremap = true, desc = 'Toggle output panel' })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()
      require('dap-go').setup()

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>rc', dap.run_to_cursor)

      -- Set up your key mapping for evaluating an expression
      vim.keymap.set('n', '<leader>?', function()
        ui.eval(nil, { context = 'hover', enter = true, width = 50, height = 10 })
      end)

      vim.keymap.set('n', '<leader>dus', function()
        local widgets = require 'dap.ui.widgets'
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end, { desc = 'Open debugging sidebar' })

      vim.keymap.set('n', '<F1>', dap.continue)
      vim.keymap.set('n', '<F2>', dap.step_into)
      vim.keymap.set('n', '<F3>', dap.step_over)
      vim.keymap.set('n', '<F4>', dap.step_out)
      vim.keymap.set('n', '<F5>', dap.step_back)
      vim.keymap.set('n', '<F6>', function()
        require('dap').terminate()
        require('dapui').close()
      end, { desc = 'Stop debugging session' })

      vim.keymap.set('n', '<leader>dus', function()
        local widgets = require 'dap.ui.widgets'
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end, { desc = 'Open debugging sidebar' })

      vim.keymap.set('n', '<F13>', dap.restart)

      -- dap.listeners.before.attach.dapui_config = function()
      --   ui.open()
      -- end
      -- dap.listeners.before.launch.dapui_config = function()
      --   ui.open()
      -- end
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   ui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   ui.close()
      -- end
    end,
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader><A>', group = '[A]lternate', mode = { 'n' } },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Initialize telescope defaults
      local telescope_setup = {
        defaults = {
          file_ignore_patterns = { 'node_modules/*', '.git/*', 'vendor/*' },
          history = {
            path = '~/.local/share/nvim/telescope_history.sqlite3',
            limit = 200,
          },
          preview = {
            treesitter = true,
          },
          mappings = {
            n = {
              ['<S-p>'] = require('telescope.actions').cycle_history_prev,
              ['<S-n>'] = require('telescope.actions').cycle_history_next,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Store initial ignore patterns and state
      local current_ignore_patterns = telescope_setup.defaults.file_ignore_patterns
      _G.ignore_patterns_active = true -- Use _G to make it global

      -- Function to toggle ignore patterns globally
      function _G.toggle_ignore_patterns()
        -- Toggle the state of ignore patterns
        ignore_patterns_active = not ignore_patterns_active

        if ignore_patterns_active then
          current_ignore_patterns = telescope_setup.defaults.file_ignore_patterns
        else
          current_ignore_patterns = {}
        end

        -- Update Telescope defaults without a complete re-setup
        require('telescope').setup {
          defaults = {
            file_ignore_patterns = current_ignore_patterns,
            history = telescope_setup.defaults.history,
            mappings = telescope_setup.defaults.mappings,
            preview = telescope_setup.defaults.preview,
          },
          extensions = telescope_setup.extensions,
        }

        print('Telescope ignore patterns updated to:', vim.inspect(current_ignore_patterns))
      end

      -- Set up Telescope initially
      require('telescope').setup(telescope_setup)

      -- Key mapping to toggle ignore patterns
      vim.api.nvim_set_keymap('n', '<leader>ti', ':lua toggle_ignore_patterns()<CR>', { noremap = true, silent = true, desc = '[T]oggle [I]gnore patterns' })

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'coc')
      pcall(require('telescope').load_extension, 'smart_history')
      pcall(require('telescope').load_extension, 'dap')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

      -- Set key mappings for various CoC features

      vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope coc definitions<CR>', { noremap = true, silent = true, desc = '[G]oto [D]efinition' })
      vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope coc references<CR>', { noremap = true, silent = true, desc = '[G]oto [R]eferences' })
      vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope coc implementations<CR>', { noremap = true, silent = true, desc = '[G]oto [I]mplementations' })

      vim.api.nvim_set_keymap('n', '<leader>sb', '<cmd>Telescope dap list_breakpoints<CR>', { noremap = true, silent = true, desc = '[S]earch [B]reakpoints' })

      vim.api.nvim_set_keymap('n', '<leader>sd', '<cmd>Telescope coc diagnostics<CR>', { noremap = true, silent = true })

      vim.keymap.set('n', '<leader>sn', ':Telescope notify<CR>', { desc = '[S]earch [N]otify' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.api.nvim_set_keymap('n', '<leader>tc', ":lua require('nvim-tree.api').tree.collapse_all()<CR>", { noremap = true, silent = true })

      vim.keymap.set('n', '<leader>sr', function()
        -- Resume the last search
        require('telescope.builtin').resume()

        -- Switch to normal mode after a short delay
        vim.defer_fn(function()
          -- Get the current buffer number
          local bufnr = vim.api.nvim_get_current_buf()
          -- Check if the current buffer is a TelescopePrompt
          if vim.bo[bufnr].filetype == 'TelescopePrompt' then
            -- Force switch to normal mode
            vim.api.nvim_input '<Esc>'
          end
        end, 100) -- Adjust the delay as needed (100ms in this case)
      end, { desc = '[S]earch [R]esume' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'gofmt' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  {
    'xiyaowong/nvim-transparent',
    config = function()
      require('transparent').setup {
        enable = true, -- Enable transparency
        extra_groups = { -- Specify groups to make transparent
          'Normal',
          'Comment',
          'Constant',
          'Identifier',
          'Function',
          'Statement',
          'PreProc',
          'Type',
          'Special',
          'Underlined',
          'Error',
          'Todo',
          'TelescopeNormal',
          'TelescopeBorder',
          'TelescopePromptNormal',
          'TelescopePromptBorder',
          'TelescopeResultsNormal',
          'TelescopeResultsBorder',
          'TelescopePreviewNormal',
          'TelescopePreviewBorder',
        },
        exclude_groups = {}, -- Optionally exclude groups here
      }
    end,
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'go',
      },
      -- Autoinstall languages that are not installed
      --
      vim.api.nvim_set_keymap('n', 'K', '<nop>', { noremap = true, silent = true }),
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      folding = {
        enable = true,
        disable = {},
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require("kickstart.plugins.debug"),
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Initialize mason to manage external tools

require('toggleterm').setup {
  size = 12, -- Height of the bottom terminal split
  open_mapping = [[<F12>]], -- Key to toggle terminal
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = false,
  direction = 'horizontal', -- Horizontal split at the bottom
  close_on_exit = true,
  shell = vim.o.shell,
}

require('lualine').setup {
  options = {
    theme = 'auto',
    section_separators = '', -- Customize separators if needed
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' }, -- Shows the Git branch name
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}
require('ibl').setup()
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

vim.cmd [[
    autocmd BufWritePre *.go :silent !go fmt %  " Format Go files on save
]]

-- Bind <leader>gm to :Git mergetool
vim.keymap.set('n', '<leader>gm', ':Git mergetool<CR>', { noremap = true, silent = true })

-- Basic key mappings for Markdown
--vim.cmd.colorscheme("catppuccin-mocha")
--vim.cmd 'colorscheme tokyonight-night'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
