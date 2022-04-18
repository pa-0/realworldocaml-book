(**
   Python-specific ATD annotations.

   This interface serves as a reference of which Python-specific
   ATD annotations are supported. Atdpy also honors JSON-related annotations
   defined in [Atdgen_emit.Json].
*)

(** Extract ["42"] from [<python default="42">].
    The provided default must be a well-formed Python immutable expression.
    Python lists are mutable so they won't work (since they're stored
    globally at the class level and they're not copied by the '__init__'
    function magically generated by '@dataclass').
*)
val get_python_default : Atd.Annot.t -> string option

(** Whether an association list of ATD type [(foo * bar) list]
    must be represented in Python as a list of pairs or as a dictionary.
    This is independent of the JSON representation.
*)
type assoc_repr =
  | List
  | Dict

(** Inspect annotations placed on lists of pairs such as
    [(string * foo) list <python repr="dict">].
    Permissible values for the [repr] field are ["dict"] and ["list"].
    The default is ["list"].
*)
val get_python_assoc_repr : Atd.Annot.t -> assoc_repr

(** Returns the list of class decorators as specified by the user without
    [@] e.g. [<python decorator="foo" decorator="bar(baz)">]
    gives [["foo"; "bar(baz)"]]. *)
val get_python_decorators : Atd.Annot.t -> string list

(** Returns text the user wants to be inserted at the beginning of the
    Python file such as imports. *)
val get_python_json_text : Atd.Annot.t -> string list