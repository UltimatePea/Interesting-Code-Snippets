# Remarks on Computational Type Theories (Harper, OPLSS 2018)

1. True by definition vs. true by fact

```
If (17; "17") (tt) \in Nat
`` 
is true by fact, not true by definition. 

As in PFPL, Section 11.3.2, in order for `if(e1;e2)(e)` to have type `tao`, both `e1` and `e2` have to have type `tao`. 
