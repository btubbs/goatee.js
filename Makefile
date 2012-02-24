# Make mustaches

# make a release
# TODO depend on test
release: args tag build-wrappers
	@echo Done!

args:
ifeq ($(version),)
	@echo "Usage make release version=x.y.z"
else
	@echo "Releasing: ${version}"
endif

tag:
	# splice in version
	sed -i.bak -e "s|%version%|${version}|" mustache.js package.json
	git commit -m 'Released ${version}' mustache.js package.json
	#  tag the version
	git tag ${version}
	# revert the version
	sed -i.bak -e 's|exports.version = "${version}"|exports.version = "%version%"|' mustache.js
	sed -i.bak -e 's|"version": "${version}"|"version": "%version%"|' package.json
	git commit -m 'Back to non-released version' mustache.js package.json
	rm *.bak

build-wrappers:
	#   from that tag:
	#     build all wrappers / minify
	git checkout $(version)
	build/wrappers.sh $(version)
	mkdir wrappers/mustache-$(version)
	cp mustache.js wrappers/mustache-$(version)/
	cp package.json wrappers/mustache-$(version)/

	git checkout gh-pages
	mkdir ${version}
	cp -r wrappers/mustache-* $(version)/
	cp wrappers/mustache-$(version)/* $(version)
	# update gh-pages with release links & travis
	# TODO: add $(version)/index.html page (from template)
	# update index.html to point to $(vesion)
	cat index.html.pre > index.html
	for release in `ls -p | grep '/'`; do echo "<li><a href=\"$(version)/\">$(version)</a></li>" >> index.html; done
	cat index.html.post >> index.html
	git add $(version)
	git commit -m 'Release $(version)' index.html $(version)
	git clean -fdx
	git checkout new-build-system
	#     update npm
	#     update cdnjs

# make test
test:
	rspec spec/mustache_spec.rb

PHONY: test release args tag build-wrappers