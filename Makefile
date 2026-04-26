FEAT ?= monaco-editor

lit:
	make -C templates/lit -f copaster.Makefile DESTINATION=../../$(FEAT)/lit ELEMENT=fanci-$(FEAT)