/-
  SIDE-grh-transfer · Voice3Vendored.lean
  ==========================================

  Attribution-vendored from SIDE-kernel/Kernel/Voice3.lean
  (SIDE-kernel main HEAD 2c49ae6, file unchanged since
  pre-audit-arc baseline 2026-04-30, Phase S.5b LV-H-6 context).
  Vendored content is the trimmed subset needed for the
  (χ, χbar)-paired reformulation of the Symmetry voice:

    • `reflect`
    • `reflect_fixed_point_forward`
    • `reflect_fixed_iff`
  Skipped (not used by `paired_reflection_axis_invariant_iff`):

    • `reflect_involution` (algebraic helper, not load-bearing here)
    • `reflect_fixed_point_reverse` (corollary, folded inline in the iff)
    • `voice3_rests_at_half` (renamed wrapper of the reverse direction)
    • `voice3_unique_rest` (contrapositive wrapper)
    • `Voice3Derivation` (structure form, not needed for the paired theorem)
  The vendor-with-attribution pattern follows the PLACE TO STAND
  federation principle (each kernel independent; no Lake cross-dependency
  on SIDE-kernel).  The original is `SIDE-kernel/Kernel/Voice3.lean::
  reflect_fixed_iff`; this file reproduces only what is needed locally.

  Original author: J. York Seale.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace SIDEGRHTransfer
/-- **Voice3''s reflection map.** For s : ℝ, `reflect s = 1 - s`.
    Applied to σ-coordinates of complex s, this is the real part of
    the functional-equation reflection s ↦ 1 - s. -/
def reflect (s : Real) : Real := 1 - s

/-- Forward direction: a fixed point of reflection is σ = 1/2. -/
theorem reflect_fixed_point_forward (s : Real) :
    reflect s = s → s = 1 / 2 := by
  unfold reflect
  intro h
  linarith
/-- **Reflection-fixed-point characterization.** σ is fixed under
    `reflect` iff σ = 1/2. This is Voice3''s `reflect_fixed_iff`
    vendored from `SIDE-kernel/Kernel/Voice3.lean`. -/
theorem reflect_fixed_iff (s : Real) :
    reflect s = s ↔ s = 1 / 2 := by
  constructor
  · exact reflect_fixed_point_forward s
  · intro h
    unfold reflect
    rw [h]
    ring

end SIDEGRHTransfer
