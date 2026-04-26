ELEMENT ?= NewFanciElement
DESTINATION ?= ../buffer/target

main:
	rsync -av --exclude 'node_modules' --exclude 'copaster.Makefile' ./ $(DESTINATION)
	cd $(DESTINATION) && ncu -u
	cd $(DESTINATION) && npm install
	replace -f $(DESTINATION) MyElement `pascaled $(ELEMENT)`
	replace -f $(DESTINATION) my-element `kebabed $(ELEMENT)`