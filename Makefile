#
# Global Settings
#

INSTALL = install -D -m0644
DESTDIR ?= ${HOME}

COMMON_FILES =	$(DESTDIR)/.bash_aliases \
		$(DESTDIR)/.bash_completion \
		$(DESTDIR)/.bash_functions \
		$(DESTDIR)/.bash_Linux \
		$(DESTDIR)/.bashrc \
		$(DESTDIR)/.bash_ssh-agent \
		$(DESTDIR)/.inputrc \
		$(DESTDIR)/.projectrc

Linux_FILES =	$(DESTDIR)/.bash_Linux \
		$(COMMON_FILES)

Cygwin_FILES =	$(DESTDIR)/.bash_CYGWIN_NT-6.1 \
		$(COMMON_FILES)

Darwin_FILES =	$(DESTDIR)/.bash_Darwin \
		$(COMMON_FILES)

HOST_FILES =	$(DESTDIR)/.bash_$(HOST) \
                $(DESTDIR)/.projectrc-$(HOST)

.PHONY : all env $(HOST) $(OS)

#
# Targets
#

$(HOST) : $(OS) $(HOST_FILES)

$(OS) : $($(OS)_FILES)

$(DESTDIR)/% : %
	$(INSTALL) $< $@

env:
	@echo OS : $(OS)
	@echo $(OS)_FILES: $($(OS)_FILES)
	@echo HOST : $(HOST)
	@echo HOST_FILES : $(HOST_FILES)

