backlight: make allow

make:
	go build backlight.go

allow: FORCE
	chmod a+x backlight
	sudo chown root:root backlight
	sudo chmod u+s backlight

FORCE: ;
