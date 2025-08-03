html:
	markdown-it index.md -o index.html

pdf-q:
	node make-pdf.js

pdf:
	make pdf-q && code index.pdf

run:
	vite

install:
	npm install -g nodemon

watch:
	nodemon --watch index.md --exec "make html"