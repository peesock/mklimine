PREFIX = /usr/local
bindir = $(PREFIX)/bin
datarootdir = $(PREFIX)/share

install:
	mkdir -p -- $(DESTDIR)$(bindir) $(DESTDIR)$(datarootdir)/mklimine
	cp -f ./mklimine.conf ./extra-functions $(DESTDIR)$(datarootdir)/mklimine
	cp -f ./mklimine $(DESTDIR)$(bindir)
	chmod +x $(DESTDIR)$(bindir)/mklimine

clean:
	rm -- $(DESTDIR)$(datarootdir)/mklimine/mklimine.conf \
		$(DESTDIR)$(datarootdir)/mklimine/extra-functions \
		$(DESTDIR)$(bindir)/mklimine
	rmdir -- $(DESTDIR)$(datarootdir)/mklimine
