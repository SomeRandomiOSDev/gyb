# GYB (Generate Your Boilerplate)

A simple package for wrapping Apple's `gyb` tool. I take no credit for developing this tool and am simply re-packaging it for convenience and portability. See ATTRIBUTIONS for additional details and the accompanying license.

The remainder of the code in this package is licensed under the MIT license. See the `LICENSE` file for more info. 

## Installation

### Swift Package Manager

#### Package.swift

To install to a Swift Package that uses a `Package.swift` file, simply add the following line to your `Package.swift` file's dependencies:

```swift
.package(url: "https://github.com/SomeRandomiOSDev/gyb", from: "0.1.0")
```

This will download `gyb` to a local cache in the Derived Data folder for your package. That can be found here: `~/Library/Developer/Xcode/DerivedData/<package identifier>/SourcePackages/checkouts/gyb`

#### Xcode

To install to an Xcode project open your project's 'Package Dependencies' and add a remote package with the following URL: https://github.com/SomeRandomiOSDev/gyb

This will download `dyb` to a local cache in the Derived Data folder for your project. You can now invoke it with the following script in your Script Build Phase:

```bash
DERIVED_DATA_DIR="$(dirname "$(dirname "$(xcodebuild -project "$PROJECT_FILE_PATH" -showBuildSettings | grep -m 1 "BUILD_DIR" | grep -oEi "\/.*")")")"

"$DERIVED_DATA_DIR/SourcePackages/checkouts/gyb/gyb" <arguments>
```

### CocoaPods

To install via CocoaPods, first add the following line to your Podfile:

```ruby
pod `gyb`
```

This will download the sources/scripts to the `Pods/` directory during your next invocation of `pod install` and will allow you to invoke it via `${PODS_ROOT}/gyb/gyb` in your Script Build Phase.

--------

Regardless of the method with which you install it, given that `gyb` generates source files it should be run *before* your Compile Sources Build Phase or before you build your package so as to ensure your source files are generated prior to compilation.

## Usage

(Copied from the output of running `gyb -h`)

```bash
usage: gyb [-h] [-D NAME=VALUE] [-o TARGET] [--test] [--verbose-test] [--dump]
           [--line-directive LINE_DIRECTIVE]
           [file]

positional arguments:
  file                  Path to GYB template file (defaults to stdin)

optional arguments:
  -h, --help            show this help message and exit
  -D NAME=VALUE         Bindings to be set in the template's execution context
  -o TARGET             Output file (defaults to stdout)
  --test                Run a self-test
  --verbose-test        Run a verbose self-test
  --dump                Dump the parsed template to stdout
  --line-directive LINE_DIRECTIVE
                        Line directive format string, which will be provided 2
                        substitutions, `%(line)d` and `%(file)s`. Example:
                        `#sourceLocation(file: "%(file)s", line: %(line)d)`
                        The default works automatically with the `line-
                        directive` tool, which see for more information.

    A GYB template consists of the following elements:

      - Literal text which is inserted directly into the output

      - %% or $$ in literal text, which insert literal '%' and '$'
        symbols respectively.

      - Substitutions of the form ${<python-expression>}.  The Python
        expression is converted to a string and the result is inserted
        into the output.

      - Python code delimited by %{...}%.  Typically used to inject
        definitions (functions, classes, variable bindings) into the
        evaluation context of the template.  Common indentation is
        stripped, so you can add as much indentation to the beginning
        of this code as you like

      - Lines beginning with optional whitespace followed by a single
        '%' and Python code.  %-lines allow you to nest other
        constructs inside them.  To close a level of nesting, use the
        "%end" construct.

      - Lines beginning with optional whitespace and followed by a
        single '%' and the token "end", which close open constructs in
        %-lines.

    Example template:

          - Hello -
        %{
             x = 42
             def succ(a):
                 return a+1
        }%

        I can assure you that ${x} < ${succ(x)}

        % if int(y) > 7:
        %    for i in range(3):
        y is greater than seven!
        %    end
        % else:
        y is less than or equal to seven
        % end

    When run with "gyb -Dy=9", the output is

          - Hello -

        I can assure you that 42 < 43

        y is greater than seven!
        y is greater than seven!
        y is greater than seven!
``` 
