FEAT ?= monaco-editor

lit:
	dotnet run --project templates/copaster/here/play -- here --from=../../../lit --to=../../../../$(FEAT)/lit