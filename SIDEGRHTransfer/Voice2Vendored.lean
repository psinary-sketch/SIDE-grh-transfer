/-
  SIDE-grh-transfer · Voice2Vendored.lean
  ==========================================

  Attribution-vendored from SIDE-kernel/Kernel/Voice2.lean
  (SIDE-kernel main HEAD 2c49ae6, file unchanged since
  pre-audit-arc baseline 2026-04-30, Phase S.5b LV-H-6 context).
  Vendored content is the trimmed subset needed for the
  (χ, χbar)-paired reformulation of the Conjugation voice:

    • `conjugate_re`
    • `reflect_re`
    • `symmetries_agree_iff`
    • `symmetries_agree_forward`
  Skipped (not used by `paired_conjugation_real_axis_agree_iff`):

    • `symmetries_agree_at_half` (corollary, folded inline if needed)
    • `symmetries_disagree_off_line` (contrapositive wrapper)
    • `codimension`, `codim_on_line`, `codim_off_line`,
      `on_line_less_exceptional` (codimension-counting content — substantive
      Voice2 result, but separate from the symmetry-agreement reformulation
      that LV-H-6 specifies; will likely be vendored separately when the
      exclusion-architecture transfer needs it)
    • `c2_rests_at_half`, `c2_unique_rest`, `c2_forces_half`
      (renamed wrappers, not load-bearing here)
    • `Voice2Derivation` (structure form, not needed for the paired theorem)
  The vendor-with-attribution pattern follows the PLACE TO STAND
  federation principle (each kernel independent; no Lake cross-dependency
  on SIDE-kernel).  The original is `SIDE-kernel/Kernel/Voice2.lean::
  symmetries_agree_iff`; this file reproduces only what is needed locally.

  Original author: J. York Seale.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace SIDEGRHTransfer
/-- **Conjugation map on the real part.** For s = σ + it,
    `conj(s) = σ - it`, so the real part is unchanged. -/
def conjugate_re (sigma : Real) : Real := sigma

/-- **Reflection map on the real part.** For the functional-equation
    reflection s ↦ 1 - s, the real part maps σ ↦ 1 - σ.
    (Same function as Voice3's `reflect`, redefined here matching the
    Voice2 source convention.) -/
def reflect_re (sigma : Real) : Real := 1 - sigma
/-- **Symmetries-agree characterization.** The conjugation and
    reflection maps agree on σ iff σ = 1/2.

    This is Voice2's `symmetries_agree_iff` vendored from
    `SIDE-kernel/Kernel/Voice2.lean`.  The algebraic fact is:
    σ = 1 - σ ⟺ σ = 1/2. -/
theorem symmetries_agree_iff (sigma : Real) :
    conjugate_re sigma = reflect_re sigma ↔ sigma = 1 / 2 := by
  unfold conjugate_re reflect_re
  constructor
  · intro h
    linarith
  · intro h
    rw [h]
    ring
/-- Forward direction of `symmetries_agree_iff` — extracted as
    a named lemma matching the original Voice2 convention. -/
theorem symmetries_agree_forward (sigma : Real) :
    conjugate_re sigma = reflect_re sigma → sigma = 1 / 2 :=
  (symmetries_agree_iff sigma).mp

end SIDEGRHTransfer
