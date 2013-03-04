# Pivotal Workstation [![Build Status](https://secure.travis-ci.org/pivotal/pivotal_workstation.png)](http://travis-ci.org/pivotal/pivotal_workstation)

A repeatable, documented, decomposable, shareable and iterative OSX (ruby) development environment


Features
--------
Pivotal Workstation automates the process of installing common applications such as Google Chrome, Firefox, homebrew, and RubyMine.  Pivotal Workstation also sets OSX preferences such as dock hiding or key repeat rate.  Finally, Pivotal Workstation configures command line tools such as git and ssh.


Installation
------------

```bash
cat > ~/Cheffile <<EOF
site 'http://community.opscode.com/api/v1'

cookbook 'pivotal_workstation',
  :git => 'git://github.com/pivotal/pivotal_workstation.git'
EOF

cat > ~/soloistrc <<EOF
recipes:
- pivotal_workstation::meta_osx_base
- pivotal_workstation::meta_osx_development
- pivotal_workstation::meta_ruby_development
EOF
sudo gem install soloist
soloist
```

Configuration
-------------
You may want to change the default applications or preferences.  For example, you might want to install only Chrome and Sublime Text.  In that case, your `soloistrc` would look like this:

```yaml
recipes:
- pivotal_workstation::chrome
- pivotal_workstation::sublime_text
```


Configuration Interfaces
------------------------
There are two online tools you can use to generate `soloistrc` files:

- [SoloWizard](http://www.solowizard.com)

	This is the easiest way to get started, and it only involves cutting-and-pasting one line.  Many thanks to [Tom Hallett](https://github.com/tommyh).

- [soloistrc builder](http://soloistrc-builder.herokuapp.com)

	Soloistrc Builder can be pointed at any cookbook and will help you build a soloistrc. Many thanks to [Winston Teo](https://github.com/winston).


Background
----------
Traditionally, Pivotal Labs relied on imaging workstations from a gold master image which was updated as time allowed.  Pivotal Workstation creates a development environment with almost no effort.  See the [recipes folder](https://github.com/pivotal/pivotal_workstation/tree/master/recipes) for a complete list of possible recipes for your `~/soloistrc` file.

Many recipes require [homebrew](https://github.com/mxcl/homebrew).  Other recipes will overwrite your `.bash_profile`.  `chef-solo` runs as root and may make system-wide changes.


Contributing
------------
* Fork the project
* Make your feature addition or bug fix
* Send me a pull request; bonus points for topic branches
* If you submit several recipes, break them into several pull requests

Maintainers
-----------
 * [Abhi Hiremagalur](https://github.com/hiremaga)
 * [Brian Cunnie](https://github.com/cunnie)

Authors
-------
 * [Matthew Kocher](https://github.com/mkocher) & [Steve Conover](https://github.com/sconover)
 * [Brian Cunnie](https://github.com/cunnie)
 * [Doc Ritezel](https://github.com/ohrite)

Thanks
------
 * [Roderik van der Veer](https://github.com/roderik)
 * [Patrick Connolly](https://github.com/patcon)
 * [Winston Teo](https://github.com/winston)
 * [Tom Hallett](https://github.com/tommyh)


Copyright
---------
Copyright &copy; Pivotal Labs. See [LICENSE.txt](https://raw.github.com/pivotal/pivotal_workstation/master/LICENSE.txt) for details.
