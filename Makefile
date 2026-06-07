EXTENSION_UUID := ideapad@laurento.frittella
EXTENSION_BUNDLE := /tmp/$(EXTENSION_UUID).shell-extension.zip
EXTENSION_USER_DIR := $(HOME)/.local/share/gnome-shell/extensions/$(EXTENSION_UUID)

.PHONY: install uninstall install-extension uninstall-extension

install:
	chmod +x ./install.sh
	./install.sh 
	cp ./icon.png /usr/share/icons/hicolor/scalable/apps/vantage.png
	cp ./vantage.desktop /usr/share/applications/vantage.desktop
	cp ./vantage.sh /usr/bin/vantage
	chmod a+rx /usr/bin/vantage

uninstall:
	rm -f /usr/share/icons/hicolor/scalable/apps/vantage.png
	rm -f /usr/share/applications/vantage.desktop
	rm -f /usr/bin/vantage

install-extension:
	gnome-extensions disable $(EXTENSION_UUID) || true
	rm -rf $(EXTENSION_USER_DIR)
	rm -f $(EXTENSION_BUNDLE)
	gnome-extensions pack --force --out-dir /tmp ./gnome-shell-extension-ideapad
	gnome-extensions install --force $(EXTENSION_BUNDLE)
	python3 ./scripts/set-gnome-extension-state $(EXTENSION_UUID) enable
	gnome-extensions enable $(EXTENSION_UUID) || true
	@echo "Restart GNOME Shell or log out/in if the extension does not appear immediately."

uninstall-extension:
	gnome-extensions disable $(EXTENSION_UUID) || true
	python3 ./scripts/set-gnome-extension-state $(EXTENSION_UUID) disable
	rm -rf $(EXTENSION_USER_DIR)
