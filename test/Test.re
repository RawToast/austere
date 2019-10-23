
open Austere;

let tests = ref(0);
let failures = ref(0);

let ensure = (bool, message) => {
  tests := tests^ + 1;
  if (!bool) {
    Js.log("Failed: " ++ message);
    failures := failures^ + 1;
  };
};

let report = () => {
  print_newline();
  if (failures^ == 0) {
    Js.log("Success! All " ++ string_of_int(tests^) ++ " tests passed");
    exit(0);
  } else {
    Js.log("Failures: " ++ string_of_int(failures^) ++ " / " ++ string_of_int(tests^));
    exit(1);
  }
};

let parse = Austere.parse(
  ~alias=[("party", "verbose")],
  ~presence=["verbose"],
  ~floats=["frobbles"],
  ~ints=["boops"],
  ~strings=["target"],
  ~multi=["rename"]
);

ensure(switch (parse(["--verbose"])) {
| Ok({presence}) when StrSet.mem("verbose", presence) => true
| _ => false
}, "straight parse");

ensure(switch (parse(["--party"])) {
| Ok({presence}) when StrSet.mem("verbose", presence) => true
| _ => false
}, "rename");

ensure(switch (parse(["--rename", "a=b", "--rename", "c=d"])) {
| Ok(opts) when multi(opts.multi, "rename") == ["c=d", "a=b"] => true
| _ => false
}, "multi");

ensure(switch (parse(["--boops", "10"])) {
| Ok({ints}) when get(ints, "boops") == Some(10) => true
| Error(err) => {Js.log(Austere.report(err)); false}
| _ => false
}, "int");

report();