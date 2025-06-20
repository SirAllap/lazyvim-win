local M = {}

local hexChars = "0123456789abcdef"

function M.hex_to_rgb(hex)
	hex = string.lower(hex:gsub("#", ""))
	local ret = {}
	for i = 0, 2 do
		local char1 = string.sub(hex, i * 2 + 1, i * 2 + 1)
		local char2 = string.sub(hex, i * 2 + 2, i * 2 + 2)
		local digit1 = string.find(hexChars, char1) - 1
		local digit2 = string.find(hexChars, char2) - 1
		ret[i + 1] = (digit1 * 16 + digit2) / 255.0
	end
	return ret[1], ret[2], ret[3]
end

function M.rgbToHsl(r, g, b)
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local h, s, l

	l = (max + min) / 2

	if max == min then
		h, s = 0, 0
	else
		local d = max - min
		if l > 0.5 then
			s = d / (2 - max - min)
		else
			s = d / (max + min)
		end
		if max == r then
			h = (g - b) / d
			if g < b then
				h = h + 6
			end
		elseif max == g then
			h = (b - r) / d + 2
		elseif max == b then
			h = (r - g) / d + 4
		end
		h = h / 6
	end

	return h * 360, s * 100, l * 100
end

function M.hslToRgb(h, s, l)
	local r, g, b
	h, s, l = h / 360, s / 100, l / 100

	if s == 0 then
		r, g, b = l, l, l
	else
		local function hue2rgb(p, q, t)
			if t < 0 then
				t = t + 1
			end
			if t > 1 then
				t = t - 1
			end
			if t < 1 / 6 then
				return p + (q - p) * 6 * t
			end
			if t < 1 / 2 then
				return q
			end
			if t < 2 / 3 then
				return p + (q - p) * (2 / 3 - t) * 6
			end
			return p
		end

		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q

		r = hue2rgb(p, q, h + 1 / 3)
		g = hue2rgb(p, q, h)
		b = hue2rgb(p, q, h - 1 / 3)
	end

	return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
end

function M.hexToHSL(hex)
	local r, g, b = M.hex_to_rgb(hex)
	local h, s, l = M.rgbToHsl(r, g, b)
	return string.format("hsl(%d, %d%%, %d%%)", math.floor(h + 0.5), math.floor(s + 0.5), math.floor(l + 0.5))
end

function M.hslToHex(h, s, l)
	local r, g, b = M.hslToRgb(h, s, l)
	return string.format("#%02x%02x%02x", r, g, b)
end

function M.replaceHexWithHSL()
	local line_number = vim.api.nvim_win_get_cursor(0)[1]
	local line_content = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]

	for hex in line_content:gmatch("#[0-9a-fA-F]{6}") do
		local hsl = M.hexToHSL(hex)
		line_content = line_content:gsub(hex, hsl, 1)
	end

	vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { line_content })
end

return M
