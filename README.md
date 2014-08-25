Remus Lazar's Emacs Setup
=========================

This is my Emacs Setup for the various programming languages I'm
working with. My preferences do differ according to the specific
language (e.g. the indenting/tab width for HTML-Files is only 2 char)

Currently I'm using TABs only for PHP and TS (TypoScript) files.  In
general I do prefer plain spaces over TABs for indending :-)

Setup
-----

Checkout this repository in `$HOME/.emacs.d`:

```
cd $HOME
git clone http://github.com/remuslazar/.emacs.d.git
```

Then run emacs, the missing packages from MELPA being automagically
installed on first run:

* markdown-mode
* jade-mode
* stylus-mode
* php-mode
* smart-tabs-mode
* auto-complete
* expand-region
* web-mode
* autopair

References
----------

1. [http://www.emacswiki.org/SmartTabs](Emacs and Smart Tabs)
2. [http://melpa.milkbox.net/](MELPA : Milkypostman’s Emacs Lisp Package Archive)
3. [http://www.philnewton.net/guides/emacs-as-a-php-editor/](Emacs as an PHP Editor)
