

#NIOS_SHELL := /opt/altera/quartus-12.1_177/nios2eds/nios2_command_shell.sh
#NIOS_SHELL := /home/sanker/altera/12.1/nios2eds/nios2_command_shell.sh

DEVICE_FAMILY="Cyclone IV E"
DEVICE=EP4CE115F29C7
DEVICE_SPEEDGRADE=7 

PROJECT_NAME=InvariantObserver
PROJECT_DIR=$(shell pwd)
OUTPUT_DIR=$(PROJECT_DIR)/$(PROJECT_NAME)
SYNTHESIS_DIR=$(OUTPUT_DIR)/synthesis
LOG_DIR=$(PROJECT_DIR)/log
LOG_FILE=$(LOG_DIR)/BUILD_$(shell date '+%d.%m.%y-%H_%M_%S').log

.PHONY: all
all:
	$(MAKE) quartus


.PHONY: quartus
quartus:
	@echo ""
	@echo "---------------------------------------------" >> $(LOG_FILE)
	@echo "-                  QUARTUS                  -" >> $(LOG_FILE)
	@echo "---------------------------------------------" >> $(LOG_FILE)
	$(NIOS_SHELL) quartus_sh --flow compile InvariantObserver 2>&1 | tee -a $(LOG_FILE) 

.PHONY: download
download:
	$(NIOS_SHELL) quartus_pgm -m jtag -o"p;output_files/"$(PROJECT_NAME)".sof"

.PHONY: install
install:
	$(MAKE) download

.PHONY: clean
clean:
	rm -f $(PROJECT_NAME).sopcinfo
	rm -f $(PROJECT_NAME).html
	rm -f $(PROJECT_NAME).cmp
	rm -f *.rpt
	rm -f *.qws
	rm -fr $(OUTPUT_DIR)
	rm -fr output_files
	rm -fr db
	rm -f *.bsf
	rm -f *.dpf
	rm -f *.srf
	rm -fr incremental_db
	rm -f *.jdi

