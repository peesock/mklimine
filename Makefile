PREFIX = /usr/local
bindir = $(PREFIX)/bin
datarootdir = $(PREFIX)/share

install:
	mkdir -p -- $(DESTDIR)$(bindir) $(DESTDIR)$(datarootdir)/mklimine
	cp -f ./mklimine.conf $(DESTDIR)$(datarootdir)/mklimine/mklimine.conf
	cp -f ./mklimine $(DESTDIR)$(bindir)/mklimine
	chmod +x $(DESTDIR)$(bindir)/mklimine

clean:
	rm -- $(DESTDIR)$(datarootdir)/mklimine/mklimine.conf $(DESTDIR)$(bindir)/mklimine
	rmdir -- $(DESTDIR)$(datarootdir)/mklimine
