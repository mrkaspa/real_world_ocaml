build:
	jbuilder build @install

run: build
	jbuilder exec real_world

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
