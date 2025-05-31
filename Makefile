scripts := build-os commit-os publish-repo generate-usb-img sync-repo
hooks := hooks/build-os/* hooks/build-os-post/*

check: $(scripts)
	shellcheck -x $(scripts)
	shellcheck -x $(hooks)

clean:
	rm -rf build-repo halo-*-usb-*

distclean: clean
	rm -rf roots repo
