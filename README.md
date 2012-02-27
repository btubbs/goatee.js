# goatee.js - A pointy-bearded fork of mustache.js

goatee.js is my fork of mustache.js.  The major changes:

- Instead of {{ and }} delimiters, goatee templates use <% and %>.  This is to
  make them easier to work with if you're using Django or Jinja templates,
  which already try to parse {{ and }} in the backend.
- Since I seem to *always* be using jQuery these days, I have pre-applied
  mustache.js's jQuery wrapper, so you have  $.goatee and $().goatee functions
  available.
- The Rakefile, tests, and Travis CI integration have all been removed.  If you
  want to port them to work with Goatee you're welcome to, but I'm not
  volunteering to take that on just yet.

For the full credits, documentation, etc, go to http://mustache.github.com/.
Just substitute <% and %> wherever you see {{ and }}.
