module StrMap:
  {
    type key = String.t;
    type t('a) = Map.Make(String).t('a);
    let empty: t('a);
    let is_empty: t('a) => bool;
    let mem: (key, t('a)) => bool;
    let add: (key, 'a, t('a)) => t('a);
    let singleton: (key, 'a) => t('a);
    let remove: (key, t('a)) => t('a);
    let merge:
      ((key, option('a), option('b)) => option('c), t('a), t('b)) => t('c);
    let compare: (('a, 'a) => int, t('a), t('a)) => int;
    let equal: (('a, 'a) => bool, t('a), t('a)) => bool;
    let iter: ((key, 'a) => unit, t('a)) => unit;
    let fold: ((key, 'a, 'b) => 'b, t('a), 'b) => 'b;
    let for_all: ((key, 'a) => bool, t('a)) => bool;
    let exists: ((key, 'a) => bool, t('a)) => bool;
    let filter: ((key, 'a) => bool, t('a)) => t('a);
    let partition: ((key, 'a) => bool, t('a)) => (t('a), t('a));
    let cardinal: t('a) => int;
    let bindings: t('a) => list((key, 'a));
    let min_binding: t('a) => (key, 'a);
    let max_binding: t('a) => (key, 'a);
    let choose: t('a) => (key, 'a);
    let split: (key, t('a)) => (t('a), option('a), t('a));
    let find: (key, t('a)) => 'a;
    let map: ('a => 'b, t('a)) => t('b);
    let mapi: ((key, 'a) => 'b, t('a)) => t('b);
  };
module StrSet:
  {
    type elt = String.t;
    type t = Set.Make(String).t;
    let empty: t;
    let is_empty: t => bool;
    let mem: (elt, t) => bool;
    let add: (elt, t) => t;
    let singleton: elt => t;
    let remove: (elt, t) => t;
    let union: (t, t) => t;
    let inter: (t, t) => t;
    let diff: (t, t) => t;
    let compare: (t, t) => int;
    let equal: (t, t) => bool;
    let subset: (t, t) => bool;
    let iter: (elt => unit, t) => unit;
    let fold: ((elt, 'a) => 'a, t, 'a) => 'a;
    let for_all: (elt => bool, t) => bool;
    let exists: (elt => bool, t) => bool;
    let filter: (elt => bool, t) => t;
    let partition: (elt => bool, t) => (t, t);
    let cardinal: t => int;
    let elements: t => list(elt);
    let min_elt: t => elt;
    let max_elt: t => elt;
    let choose: t => elt;
    let split: (elt, t) => (t, bool, t);
    let find: (elt, t) => elt;
    let of_list: list(elt) => t;
  };
type result('a, 'b) = Ok('a) | Error('b);
type opts = {
  presence: StrSet.t,
  bools: StrMap.t(bool),
  floats: StrMap.t(float),
  ints: StrMap.t(int),
  strings: StrMap.t(string),
  multi: StrMap.t(list(string)),
  rest: list(string),
};
let empty: opts;

let parse:
  (~alias: list((string, StrSet.elt))=?, ~presence: list(StrSet.elt)=?,
  ~bools: list(StrSet.elt)=?, ~floats: list(StrSet.elt)=?,
  ~ints: list(StrSet.elt)=?, ~strings: list(StrSet.elt)=?,
  ~multi: list(StrSet.elt)=?, list(string)) =>
  result(opts, [> `BadValue(StrSet.elt, string) | `Unknown(StrSet.elt) ]);
let get: (StrMap.t('a), StrMap.key) => option('a);
let multi: (StrMap.t(list('a)), StrMap.key) => list('a);
let fail: 'a => 'b;
let report: [< `BadValue(string, string) | `Unknown(string) ] => string;
let getParamOrFail: (StrMap.t('a), StrMap.key) => 'a;
