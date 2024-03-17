local keymap = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = ' '
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")



-- [[Best Keymaps EVER!]]

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-a>", ui.toggle_quick_menu)
-- Jupynium
-- Move to the next cell and execute it using Jupynium
vim.api.nvim_set_keymap('n', '<Leader>nx', [[:call search('# %%', 'W')<CR>:JupyniumExecuteSelectedCells<CR>]],
  { noremap = true, silent = true })

-- Move to the previous cell and execute it using Jupynium
vim.api.nvim_set_keymap('n', '<Leader>px', [[:call search('# %%', 'bW')<CR>:JupyniumExecuteSelectedCells<CR>]],
  { noremap = true, silent = true })



-- Harpoon baby
vim.keymap.set("n", "<C-q>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-w>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-e>", function() ui.nav_file(3) end)

-- Jupynium
vim.keymap.set('n', '<F5>', ':JupyniumStartAndAttachToServer<CR>',
  { silent = true, noremap = true, desc = 'Start and Attach Jupynium Server' })
vim.keymap.set('n', '<F6>', ':JupyniumStartSync<CR>',
  { silent = true, noremap = true, desc = 'Syncing the Server' })
vim.keymap.set('n', '<F7>', ':JupyniumLoadFromIpynbTab 2<CR>',
  { silent = true, noremap = true, desc = 'Load from IPYNB in Tab 2' })
vim.keymap.set('n', '<F8>', ':JupyniumLoadFromIpynbTab 3<CR>',
  { silent = true, noremap = true, desc = 'Load from IPYNB in Tab 3' })
vim.keymap.set('n', '<F9>', ':JupyniumLoadFromIpynbTab 4<CR>',
  { silent = true, noremap = true, desc = 'Load from IPYNB in Tab 4' })


-- [[ Basic Keymaps ]]



keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Centering after ctrl+d/u
keymap('n', '<C-d>', '<C-d>zz', { silent = true })
keymap('n', '<C-u>', '<C-u>zz', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})



-- [[WTF Keymaps]]

-- Git stuff
vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, { desc = '[p]roject [f]iles' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[g]it [f]iles' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })

-- [[Tmux stuff]]
-- Resize
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize +2<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize -2<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', { silent = true })
-- Right and bottom splits adjusted as per your recent configuration
--vim.api.nvim_set_keymap('n', '<leader>tv', ':rightbelow 30vsplit term://$SHELL<CR> :startinsert<CR>',
--  { silent = true, noremap = true })
--vim.api.nvim_set_keymap('n', '<leader>th', ':belowright 5split term://$SHELL<CR> :startinsert<CR>',
--  { silent = true, noremap = true })


local te_buf = nil
local te_win_id = nil

local v = vim
local fun = v.fn
local cmd = v.api.nvim_command
local gotoid = fun.win_gotoid
local getid = fun.win_getid

-- Function to open or toggle the terminal
local function openTerminal(size, direction)
  if fun.bufexists(te_buf) ~= 1 then
    cmd("au TermOpen * setlocal nonumber norelativenumber signcolumn=no")
    if direction == 'horizontal' then
      cmd("sp | winc J | res " .. size .. " | te")
    elseif direction == 'vertical' then
      cmd("vsp | winc L | vertical res " .. size .. " | te")
    end
    te_win_id = getid()
    te_buf = fun.bufnr('%')
  elseif gotoid(te_win_id) ~= 1 then
    if direction == 'horizontal' then
      cmd("sb " .. te_buf .. " | winc J | res " .. size)
    elseif direction == 'vertical' then
      cmd("sb " .. te_buf .. " | winc L | vertical res " .. size)
    end
    te_win_id = getid()
  end
  cmd("startinsert")
end

local function hideTerminal()
  if gotoid(te_win_id) == 1 then
    cmd("hide")
  end
end

function ToggleTerminal()
  if gotoid(te_win_id) == 1 then
    hideTerminal()
  else
    openTerminal('12', 'horizontal') -- Default size and direction if not specified
  end
end

-- Function to run the current Python file in the terminal
local function runPythonFileInTerminal()
  local file_path = vim.fn.expand('%') -- Get the current file path
  ToggleTerminal()                     -- Ensure the terminal is open
  -- Send the command to run the current Python file and press Enter
  vim.api.nvim_chan_send(vim.b.terminal_job_id, 'python3 ' .. file_path .. "\r")
end

-- Keymaps for opening and toggling terminal
vim.api.nvim_set_keymap('n', '<leader>tv', '',
  { silent = true, noremap = true, callback = function() openTerminal('30', 'vertical') end })
vim.api.nvim_set_keymap('n', '<Esc>', '', { silent = true, noremap = true, callback = ToggleTerminal })

-- Run current python file in terminal
vim.api.nvim_set_keymap('n', '`', '', { noremap = true, callback = runPythonFileInTerminal })
vim.api.nvim_set_keymap('n', '\\', '', { noremap = true, callback = function() vim.cmd('!g++ % -o %< && ./%<') end })



-- Telescope keybindings
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })


-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})


-- Register which-key hints for some custom mappings (if you're using which-key plugin)
require('which-key').register({
  ['<leader>'] = {
    ['?'] = 'Find recently opened files',
    ['<space>'] = 'Find existing buffers',
    ['/'] = 'Fuzzily search in current buffer',
    ['pf'] = 'Project files',
    ['gf'] = 'Git files',
    ['s/'] = 'Search in Open Files',
  }
})

-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
