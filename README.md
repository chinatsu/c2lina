# c2lina

**unmaintained note:** i no longer use a mac. i'm unable to continue ensuring that cultris 2 runs on newer versions of macOS. feel free to fork and fix if you run into issues :)

a collection of scripts to get cultris 2 running on catalina (and big sur)

## installation

1. run `./1_setup_java.sh`
2. (optional) download one of the [custom versions of cultris 2 by DEF](http://gewaltig.net/Forums/Thread.aspx?pageid=1&t=996~1)
3. run `./2_setup_cultris.sh "$HOME/Downloads/unblurred 60Hz.rar"`, switch out unblurred 60Hz.rar with the filename of the version you downloaded. 
    * if this file is somewhere else and you're unsure how to point to it from the terminal, you can type `./2_setup_cultris.sh ` (with a space at the end) and drag the file from finder into the terminal where you typed this and run the resulting command.
    * if you want to use the official client, you can simply run `./2_setup_cultris.sh` without any additional arguments and answer `y` to the question that is asked once you run it.
4. execute `./run.sh`

## why?

current alternatives involve using compatibility layers such as
crossover, wine, and other such software.

it is technically possible to simply run cultris 2 on a native
installation of java, so hopefully this repository can help you
get such a setup.

in order to instill some kind of trust around what we're doing here,
the scripts are open source with comments to explain each relevant line
of code. binaries and libraries are downloaded from trusted sources,
and are not present by themselves in this repository.

## how?

[DEF's patches](http://gewaltig.net/Forums/Thread.aspx?pageid=1&t=996~1)
provide good a starting point, though these are built explicitly for 32-bit
systems. extracting the `cultris2.jar` file from a desired package,
one can simply pair that with native libraries (`libbass` and `lwjgl`)
and an *old* version of java (1.6) to enable running cultris2 on
catalina.

## known issues

* i updated and i get an error like `/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/bin/java: No such file or directory`
    * run `./1_setup_java.sh` again to reinstall java and try to run the game afterwards (step 1 and step 4 in [installation](#installation))

## contributors

* [zDEFz](https://github.com/zDEFz)
* [chinatsu](https://github.com/chinatsu)
