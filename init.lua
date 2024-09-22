vim.g.python3_host_prog = "D:/SOFTWARE/WEBD/fastapi/test/venv/Scripts/python.exe"
-- vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
require("hitendra.core")
require("hitendra.lazy")

---- Globals ----
P = function(v)
	print(vim.inspect(v))
	return v
end
