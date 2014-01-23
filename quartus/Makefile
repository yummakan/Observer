
NIOS_SHELL := /opt/altera/quartus-12.1_177/nios2eds/nios2_command_shell.sh

DEVICE_FAMILY="Cyclone IV E"
DEVICE=EP4CE115F29C7
DEVICE_SPEEDGRADE=7 
LOG_FILE=BUILD_$(shell date '+%d.%m.%y-%H_%M_%S').log


PROJECT_NAME=displaydriver
PROJECT_DIR=$(shell pwd)
OUTPUT_DIR=$(PROJECT_DIR)/$(PROJECT_NAME)
SYNTHESIS_DIR=$(OUTPUT_DIR)/synthesis

.PHONY: all
all:
	$(MAKE) qsys
	$(MAKE) quartus

.PHONY: qsys
qsys:
	@echo "---------------------------------------------" >> $(LOG_FILE)
	@echo "-                 QSYS                      -" >> $(LOG_FILE)
	@echo "---------------------------------------------" >> $(LOG_FILE)
	$(NIOS_SHELL) ip-generate \
	--project-directory=$(PROJECT_DIR)   \
	--output-directory=$(OUTPUT_DIR)     \
	--report-file=bsf:$(PROJECT_DIR)/$(PROJECT_NAME).bsf \
	--system-info=DEVICE_FAMILY=$(DEVICE_FAMILY) \
	--system-info=DEVICE=$(DEVICE) \
	--system-info=DEVICE_SPEEDGRADE=$(DEVICE_SPEEDGRADE) \
	--component-file=$(PROJECT_DIR)/$(PROJECT_NAME).qsys 2>&1 | tee -a $(LOG_FILE) 
	$(NIOS_SHELL) ip-generate \
	--project-directory=$(PROJECT_DIR) \
	--output-directory=$(SYNTHESIS_DIR) \
	--file-set=QUARTUS_SYNTH \
	--report-file=sopcinfo:$(PROJECT_DIR)/$(PROJECT_NAME).sopcinfo \
	--report-file=html:$(PROJECT_DIR)/$(PROJECT_NAME).html \
	--report-file=qip:$(SYNTHESIS_DIR)/$(PROJECT_NAME).qip \
	--report-file=cmp:$(PROJECT_DIR)/$(PROJECT_NAME).cmp \
	--system-info=DEVICE_FAMILY=$(DEVICE_FAMILY) \
	--system-info=DEVICE=$(DEVICE) \
	--system-info=DEVICE_SPEEDGRADE=$(DEVICE_SPEEDGRADE) \
	--component-file=$(PROJECT_DIR)/$(PROJECT_NAME).qsys 2>&1 | tee -a $(LOG_FILE) 

.PHONY: quartus
quartus:
	@echo ""
	@echo "---------------------------------------------" >> $(LOG_FILE)
	@echo "-                  QUARTUS                  -" >> $(LOG_FILE)
	@echo "---------------------------------------------" >> $(LOG_FILE)
	$(NIOS_SHELL) quartus_sh --flow compile displaydriver 2>&1 | tee -a $(LOG_FILE) 

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

