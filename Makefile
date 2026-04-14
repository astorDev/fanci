FEAT ?= monaco-editor

lit:
	rm -rf templates/lit/node_modules templates/lit/package-lock.json
	mkdir -p $(FEAT)/lit
	cp -R templates/lit/* $(FEAT)/lit