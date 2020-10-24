# c2lina

a collection of scripts to get cultris 2 running on catalina

## installation

1. download one of the [custom versions of cultris 2 by DEF](http://gewaltig.net/Forums/Thread.aspx?pageid=1&t=996~1)
2. run `./1_setup_java.sh`
2. run `./2_setup_cultris.sh "$HOME/Downloads/unblurred 60Hz.rar"`, switch out unblurred 60Hz.rar with the filename of the version you downloaded. 
    * if this file is somewhere else and you're unsure how to point to it from the terminal, you can type `./2_setup_cultris.sh ` (with a space at the end) and drag the file from finder into the terminal where you typed this and run the resulting command.
3. run `./run.sh`

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
provide a starting point, though these are built explicitly for 32-bit
systems. extracting the `cultris2.jar` file from a desired package,
one can simply pair that with native libraries (`libbass` and `lwjgl`)
and an *old* version of java (1.6) to enable running cultris2 on
catalina.

## contributors

* [zDEFz](https://github.com/zDEFz)
* [chinatsu](https://github.com/chinatsu)