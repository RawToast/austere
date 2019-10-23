# Austere

A no-frills cli argument parser for reason. Forked from [minimist.re](https://github.com/jaredly/minimist.re), 
which is inspired by [minimist](https://www.npmjs.com/package/minimist) and [yargs](https://www.npmjs.com/package/yargs).

Unlike [minimist.re](https://github.com/jaredly/minimist.re), this only targets Javascript/Node and has no bs-native dependency.

## Example

```reason
let parse = Austere.parse(~alias=[("h", "help")], ~presence=["help"], ~multi=["rename"], ~strings=["base"]);

let help = {|
# pack.re - a simple js bundler for reason

Usage: pack.re [options] entry-file.js > bundle.js

  --base (default: current directory)
      expected to contain node_modules
  --rename newName=realName (can be defined multiple times)
      maps `require("newName")` to a node_module called "realName"
  -h, --help
      print this help
|};

let fail = (msg) => {
  Js.log(msg);
  Js.log(help);
  exit(1);
};

let args = List.tl(Array.to_list(Sys.argv));
/* Some example args for you */
let args = ["--base", "awesome", "some-entry.js"];

switch (parse(args)) {
| Austere.Error(err) => fail(Austere.report(err))
| Ok(opts) =>
if (Austere.StrSet.mem("help", opts.presence)) {
  Js.log(help); exit(0);
} else switch (opts.rest) {
  | [] => fail("Expected entry file as final argument")
  | [entry] => {
    let base = Austere.get(opts.strings, "base");
    let renames = Austere.multi(opts.multi, "rename");
    Js.log("All good!")
  }
  | _ => fail("Only one entry file allowed")
}
};
```
