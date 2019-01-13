DIST_DIR := dist

ADDON_ID := $(shell python -c "import xml.etree.ElementTree; print(xml.etree.ElementTree.parse('addon.xml').getroot().attrib['id']);")
ADDON_VERSION := $(shell python -c "import xml.etree.ElementTree; print(xml.etree.ElementTree.parse('addon.xml').getroot().attrib['version']);")

package: init-submodules
	rm -rf $(DIST_DIR); \
	rm -rf $(ADDON_ID); \
	mkdir $(ADDON_ID) && \
	rsync -arv --exclude=$(ADDON_ID) * $(ADDON_ID) && \
	mkdir $(DIST_DIR) && \
	zip -r $(DIST_DIR)/$(ADDON_ID)-$(ADDON_VERSION).zip $(ADDON_ID)/* && \
	rm -rf $(ADDON_ID)

init-submodules:
	git submodule update --init --recursive