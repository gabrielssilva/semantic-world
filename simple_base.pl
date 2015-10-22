% object does action, which_results_on addition/remotion attribute/object
%% object does action on object, which_results_on addition/remotion attribute/object

object has attribute.
attibute does action.
object does action.

pen is_a object.
point is_a attribute.
ink is_a attribute.
pen has point.
pen has ink.

knife is_a object.
blade is_a attribute.
knife has blade.

hammer is_a object.
hammer is_a hurts.

hurts is_a action.
blade does hurts.
point does hurts.
pen does write.

action has consequence.

write is_a action.
write has out_of_ink.

consquence is_a type.
consquence has attribute.

out_of_ink is_a consequence.
out_of_ink is_a bad.
out_of_ink has ink.