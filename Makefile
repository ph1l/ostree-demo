scripts := build-os commit-os publish-repo generate-usb-img sync-repo
hooks := hooks/build-os/* hooks/build-os-post/*

all:
	sudo ./build-os
	sudo ./commit-os
	./publish-repo

check: $(scripts)
	shellcheck -x $(scripts)
	shellcheck -x $(hooks)

clean:
	sudo rm -rf roots build-repo

distclean: clean
	rm -rf repo
