BIN ?= oc-login
PREFIX ?= /usr/local

install:
        cp oc-login.sh $(PREFIX)/bin/$(BIN)

uninstall:
        rm -f $(PREFIX)/bin/$(BIN)

example.sh:
        ./example.sh

.PHONY: example.sh

