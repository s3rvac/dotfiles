-- Display a tabline only if there are at least two tabs.
vim.opt.showtabline = 1

-- Use a custom function that displays tab numbers in the tabline.
-- Based on http://superuser.com/a/477221.
vim.cmd([[
function! MyTabLine()
	let s = ''
	let wn = ''
	let t = tabpagenr()
	let i = 1
	while i <= tabpagenr('$')
		let buflist = tabpagebuflist(i)
		let winnr = tabpagewinnr(i)
		let s .= '%' . i . 'T'
		let s .= (i == t ? '%1*' : '%2*')
		let s .= ' '
		let wn = tabpagewinnr(i,'$')
		let s .= '%#TabNum#'
		let s .= i
		let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
		let bufnr = buflist[winnr - 1]
		let file = bufname(bufnr)
		let buftype = getbufvar(bufnr, 'buftype')
		if buftype == 'nofile'
			if file =~ '\/.'
				let file = substitute(file, '.*\/\ze.', '', '')
			endif
		else
			" Shorten file name to include only first letters of each
			" directory.
			let file = pathshorten(file)
		endif
		if file == ''
			let file = '[No Name]'
		endif
		let s .= ' ' . file . ' '
		let i = i + 1
		" Add '[+]' if one of the buffers in the tab page is modified.
		for bufnr in buflist
			if getbufvar(bufnr, '&modified')
				let s .= '[+]'
				break
			endif
		endfor
	endwhile
	let s .= '%T%#TabLineFill#%='
	return s
endfunction
set tabline=%!MyTabLine()
]])
