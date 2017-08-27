build:
	jbuilder build @install

run: build
	jbuilder exec real_world

run-web: build-all
	jbuilder exec wmain

test:
	jbuilder runtest

pin:
	opam pin add .

repin: build
	opam upgrade real_world

build-all:
	jbuilder build --workspace jbuild-workspace.dev @install

test-all:
	jbuilder build --workspace jbuild-workspace.dev @runtest

.PHONY: build test pin repin build-all test-all