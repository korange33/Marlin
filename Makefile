all: depends

depends:
	head -26 .travis.yml
	@echo after solving dependancies, try : make build-firmware

link-srcdir:
	ln -s Marlin src

clean-pde:
	rm src/Marlin.pde

kossel-cfg:
	echo cp Marlin/

build-firmware: link-srcdir clean-pde
	ino build -m mega2560

init:
	git checkout -- Marlin/Marlin.pde
	rm src

config:
	curl --silent --show-error -O https://raw.githubusercontent.com/MarlinFirmware/Marlin/Development/Marlin/example_configurations/delta/kossel_mini/Configuration.h
	curl --silent --show-error -O https://raw.githubusercontent.com/MarlinFirmware/Marlin/Development/Marlin/example_configurations/delta/kossel_mini/Configuration_adv.h
	sed -i s/'X_MIN_ENDSTOP_INVERTING = false'/'X_MIN_ENDSTOP_INVERTING = true'/g Configuration.h
	sed -i s/'Y_MIN_ENDSTOP_INVERTING = false'/'Y_MIN_ENDSTOP_INVERTING = true'/g Configuration.h
	sed -i s/'Z_MIN_ENDSTOP_INVERTING = false'/'Z_MIN_ENDSTOP_INVERTING = true'/g Configuration.h

.PHONY: clean

clean:
	rm -rf .build/
	rm -rf lib/
	rm src
	git checkout Marlin/Marlin.pde
