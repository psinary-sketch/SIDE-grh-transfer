/-
  SIDE-grh-transfer · Voice3bVendored.lean
  ===========================================

  Attribution-vendored from SIDE-kernel/Kernel/Voice3b.lean
  (SIDE-kernel main HEAD 2c49ae6, file unchanged since
  pre-audit-arc baseline 2026-04-30, Phase S.5b chorus
  extension context).  Vendored content is the trimmed
  subset needed for the (χ, χbar)-paired reformulation
  of the Cauchy-Riemann codimension voice:

    • `zero_codimension`
    • `cr_minimal_codim`
    • `cr_minimal_iff`
    • `cr_forces_half`
  Skipped (not used by `paired_cr_minimal_codim_axis_iff`):

    • `codim_on_line`, `codim_off_line` (auxiliary lemmas;
      cr_minimal_iff proves the if/else case directly via
      by_contra + omega without these)
    • `cr_at_half` (corollary, folded inline)
    • `cr_not_minimal_off_line` (contrapositive wrapper)
    • `determination_bridge` (D-principle application,
      not needed for the paired theorem)
    • `Voice3bDerivation` (structure form)
  Note: Voice3b's `zero_codimension` is the SAME algebraic
  content as Voice2's codim-counting (`codim_on_line`,
  `codim_off_line`, `on_line_less_exceptional` from
  Voice2.lean, deferred in v0.2.0 per LV-H-6 spec).
  Vendoring Voice3b here transitively covers Voice2's
  codim content via the same algebra.

  The vendor-with-attribution pattern follows the PLACE TO
  STAND federation principle (each kernel independent;
  no Lake cross-dependency on SIDE-kernel).  The original
  is `SIDE-kernel/Kernel/Voice3b.lean::cr_minimal_iff`;
  this file reproduces only what is needed locally.

  Original author: J. York Seale.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace SIDEGRHTransfer
/-- **Codimension at σ for ξ zeros.** At σ = 1/2 (real-valued ξ),
    a zero condition is codim 1 (one real equation); off σ = 1/2
    (complex-valued ξ), it's codim 2 (Re and Im both vanish).
    The Cauchy-Riemann constraint ensures this is sharp. -/
noncomputable def zero_codimension (sigma : Real) : Nat :=
  if sigma = 1 / 2 then 1 else 2

/-- **Minimal codimension predicate.** σ has minimal (= 1) zero
    codimension iff σ = 1/2. -/
def cr_minimal_codim (sigma : Real) : Prop :=
  zero_codimension sigma = 1
/-- **Cauchy-Riemann minimal codimension characterization.**
    σ has minimal codimension iff σ = 1/2.  This is Voice3b's
    `cr_minimal_iff` vendored from `SIDE-kernel/Kernel/Voice3b.lean`. -/
theorem cr_minimal_iff (sigma : Real) :
    cr_minimal_codim sigma ↔ sigma = 1 / 2 := by
  unfold cr_minimal_codim zero_codimension
  constructor
  · intro h
    by_contra h_ne
    rw [if_neg h_ne] at h
    omega
  · intro h
    rw [h]
    simp
/-- Forward direction: minimal codimension forces σ = 1/2. -/
theorem cr_forces_half (sigma : Real) :
    cr_minimal_codim sigma → sigma = 1 / 2 :=
  (cr_minimal_iff sigma).mp

end SIDEGRHTransfer
