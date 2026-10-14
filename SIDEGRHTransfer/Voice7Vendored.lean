/-
  SIDE-grh-transfer · Voice7Vendored.lean
  ===========================================

  Attribution-vendored from SIDE-kernel/Kernel/Voice7.lean
  (SIDE-kernel main HEAD 2c49ae6, file unchanged since
  pre-audit-arc baseline 2026-04-30, Phase S.5b chorus
  extension context).  Vendored content is the trimmed
  subset needed for the (χ, χbar)-paired reformulation
  of the topological-inertness voice:

    • `topological_contribution`        — σ ↦ 0 (constant)
    • `topological_constant`            — σ1 = σ2 invariance
    • `topological_no_sigma_preference` — σ-independence  (substance)
    • `topological_rests`               — predicate: contribution = 0
    • `c7_rests_everywhere`             — universal restful
  Skipped (not used by `paired_topological_no_sigma_preference`):

    • `c7_rests_at_half` (corollary of c7_rests_everywhere)
    • `c7_forces_half` (trivial tautology σ → σ = σ)
    • `c7_no_placement_force` (alias of topological_no_sigma_preference)

  Voice7 is STRUCTURALLY INVERTED relative to Voice1/2/3/3b/5/6.
  Voice7's vendored content is a constant-0 contribution function and its rfl consequences (constant in sigma, equal
  to its value at 1/2, the rest predicate at every sigma); the reading that this class cannot place zeros is the
  manuscript's, not compiled here.
  The Hadamard product / argument principle COUNTS zeros and
  RELATES locations to growth, but it does not PREFER any σ. The
  contribution is constant in σ.

  This inversion is essential for chorus exhaustiveness: SIDE
  closure requires accounting for ALL mechanism classes.

  Federation provenance: vendor-with-attribution per the PLACE
  TO STAND principle.  Original author: J. York Seale.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace SIDEGRHTransfer
/-- **Topological winding contribution to zero-placement.**
    σ-independent: the argument principle counts zeros regardless
    of which σ they're at. We model as a constant function — the
    topological mechanism contributes the same constraint at every σ. -/
def topological_contribution (_sigma : Real) : Real := 0

/-- The topological contribution is σ-independent (constant). -/
theorem topological_constant (sigma1 sigma2 : Real) :
    topological_contribution sigma1 = topological_contribution sigma2 := by
  unfold topological_contribution; rfl

/-- **σ-inertness: the topological class has no σ-preference.**
    The modelled topological contribution (defined as 0) has the same value at any sigma as at sigma = 1/2. -/
theorem topological_no_sigma_preference (sigma : Real) :
    topological_contribution sigma = topological_contribution (1 / 2 : Real) := by
  unfold topological_contribution; rfl
/-- Topological rest-state predicate: the contribution is zero
    (which it always is, since the contribution is constantly 0). -/
def topological_rests (sigma : Real) : Prop :=
  topological_contribution sigma = 0

/-- Voice7 rests everywhere. Since the topological contribution
    is constantly 0, the rest predicate holds at every σ. -/
theorem c7_rests_everywhere (sigma : Real) :
    topological_rests sigma := by
  unfold topological_rests topological_contribution; rfl

end SIDEGRHTransfer
