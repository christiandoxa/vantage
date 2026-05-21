.PHONY: install uninstall

install:
	chmod +x ./install.sh
	./install.sh 
	cp ./icon.png /usr/share/icons/hicolor/scalable/apps/vantage.png
	cp ./vantage.desktop /usr/share/applications/vantage.desktop
	cp ./vantage.sh /usr/bin/vantage
	chmod a+rx /usr/bin/vantage
	install -m 755 ./lenovo-vantage-charge-refresh /usr/local/sbin/lenovo-vantage-charge-refresh
	install -m 644 ./lenovo-vantage-charge-refresh.service /etc/systemd/system/lenovo-vantage-charge-refresh.service
	install -m 644 ./99-lenovo-vantage-charge-refresh.rules /etc/udev/rules.d/99-lenovo-vantage-charge-refresh.rules
	install -m 755 ./lenovo-vantage-charge-refresh.sleep /usr/lib/systemd/system-sleep/lenovo-vantage-charge-refresh
	systemctl daemon-reload
	udevadm control --reload-rules
	systemctl enable --now lenovo-vantage-charge-refresh.service

uninstall:
	systemctl disable --now lenovo-vantage-charge-refresh.service || true
	rm -f /usr/share/icons/hicolor/scalable/apps/vantage.png
	rm -f /usr/share/applications/vantage.desktop
	rm -f /usr/bin/vantage
	rm -f /usr/local/sbin/lenovo-vantage-charge-refresh
	rm -f /etc/systemd/system/lenovo-vantage-charge-refresh.service
	rm -f /etc/udev/rules.d/99-lenovo-vantage-charge-refresh.rules
	rm -f /usr/lib/systemd/system-sleep/lenovo-vantage-charge-refresh
	systemctl daemon-reload
	udevadm control --reload-rules
