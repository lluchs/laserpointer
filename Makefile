
SIZES := 24 32 48

size = $(notdir $(basename $@))

cursors: pointer.in cursors.txt $(addprefix png/,$(addsuffix .png,$(SIZES)))
	rm -rf $@
	mkdir $@
	xcursorgen pointer.in cursors/pointer
	cd $@ && < ../cursors.txt xargs -n1 ln -rs pointer

png/%.png: pointer.svg
	mkdir -p png
	inkscape -o $@ --export-overwrite  --export-area-page --export-width=$(size) --export-height=$(size) $<

cursors.txt:
	find /usr/share/icons/Adwaita/cursors -type f ! -name pointer -printf '%f\n' > $@

install: cursors index.theme
	install -d $(DESTDIR)/usr/share/icons/laserpointer/cursors
	cp -a cursors/* $(DESTDIR)/usr/share/icons/laserpointer/cursors
	install -Dm644 index.theme $(DESTDIR)/usr/share/icons/laserpointer/index.theme

.PHONY: install
