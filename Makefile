
#
# - Bloombox - bloombox-styles
#

BUILDBOT ?= 0
ENV ?= .env/
TARGET ?= target/
CREDENTIALS ?= 1
VERSION ?= 0.0.4

all: build
	@echo "bloombox-styles is ready."


#
## Build Flow
#

build: $(TARGET) $(ENV) dependencies
	@cp -frv ./*.html ./bower.json ./demo ./README.md $(TARGET)/;
	@echo "Project build complete."

quickbuild:
	@echo "Quickbuilding..."
	@cp -fr ./*.html ./bower.json ./demo ./README.md $(TARGET)/;

release: build
	@echo "Building release package..."
	@mkdir -p $(TARGET)/
	@cd $(TARGET) && tar -czvf ../$(VERSION).tar.gz *
	@echo "Release ready."

dependencies:
	@echo "Installing project dependencies..."
	@npm install
	@bower install
	@echo "Dependencies ready."

clean:
	@echo "Cleaning project..."
	@find . -name .DS_Store -delete
	@rm -frv $(TARGET) ./*.tar.gz

distclean: clean
	@echo "Resetting project..."
	@rm -frv $(TARGET) $(ENV)
	@git reset --hard

forceclean: distclean
	@echo "Sanitizing project..."
	@git clean -xdf

#
## Dependencies
#

$(ENV):
	@echo "Establishing envroot..."
	@mkdir -p $(ENV)

$(TARGET):
	@echo "Establishing buildroot..."
	@mkdir -p $(TARGET)


.PHONY: all build release dependencies clean distclean forceclean
