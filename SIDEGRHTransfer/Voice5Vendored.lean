/-
  SIDE-grh-transfer · Voice5Vendored.lean
  ===========================================

  Attribution-vendored from SIDE-kernel/Kernel/Voice5.lean
  (SIDE-kernel main HEAD 2c49ae6, file unchanged since
  pre-audit-arc baseline 2026-04-30, Phase S.5b chorus
  extension context).  Vendored content is the trimmed
  subset needed for the (χ, χbar)-paired reformulation
  of the modular S-fixed-point voice:

    • `S_action`        — the S-generator action σ ↦ 1 − σ
    • `S_involution`    — S∘S = id
    • `S_fixed_point`   — S σ = σ ↔ σ = 1/2  (the substance)
    • `R_action`        — the R-generator action (σ-trivial)
    • `R_no_constraint` — R σ = σ for all σ  (R adds nothing)
    • `modular_forces_half` — forward direction of S_fixed_point
  Skipped (not used by `paired_modular_S_fixed_iff`):

    • `R_order_3` (trivially R^3 = id since R is identity on σ)
    • `modular_one_axis` (subsumed by S_fixed_point ∧ R_no_constraint)
    • `c5_rests_at_half`, `c5_active_off_line`, `c5_forces_half`
      (corollaries / contrapositive / alias)
    • `Voice5Derivation` (structure form)

  Voice5 says: the modular group PSL2(ℤ) ≅ ℤ/2 ∗ ℤ/3 has
  generators S (order 2, the involution σ ↦ 1−σ) and R = ST
  (order 3, σ-trivial). The S-generator's unique fixed point
  is σ = 1/2; R contributes no σ-constraint. Thus the modular
  structure contributes exactly one axis, at σ = 1/2.
  The R-triviality result is Voice5's distinctive content
  beyond Voice3 (which proves the same σ=1/2 fixed point via
  the FE reflection but doesn't address the order-3 generator).

  Federation provenance: vendor-with-attribution per the PLACE
  TO STAND principle.  Original author: J. York Seale.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace SIDEGRHTransfer
/-- **S-generator action on the Mellin parameter σ.**
    The modular S: τ ↦ −1/τ induces σ ↦ 1 − σ. Order 2 (involution). -/
def S_action (sigma : Real) : Real := 1 - sigma

/-- S is an involution: `S∘S = id`. -/
theorem S_involution (sigma : Real) :
    S_action (S_action sigma) = sigma := by
  unfold S_action; ring

/-- **S has a unique fixed point: σ = 1/2.**  Voice5's main result;
    this is the iff `paired_modular_S_fixed_iff` delegates to. -/
theorem S_fixed_point (sigma : Real) :
    S_action sigma = sigma ↔ sigma = 1 / 2 := by
  unfold S_action
  constructor
  · intro h; linarith
  · intro h; rw [h]; ring
/-- **R-generator action (order 3) on the Mellin parameter σ.**
    R = ST: τ ↦ −1/(τ + 1). On the upper half-plane this is
    rotation by 2π/3; on the Mellin parameter σ its net effect is
    the identity (it permutes Fourier coefficients of θ but does
    not change which σ-value the symmetry constrains). -/
def R_action (sigma : Real) : Real := sigma

/-- **R produces no σ-constraint.**  Voice5's distinctive
    content beyond Voice3: the order-3 modular generator
    contributes nothing to σ. -/
theorem R_no_constraint (sigma : Real) :
    R_action sigma = sigma := by
  unfold R_action; rfl

/-- Forward direction: the S-fixed condition forces σ = 1/2. -/
theorem modular_forces_half (sigma : Real) :
    S_action sigma = sigma → sigma = 1 / 2 :=
  (S_fixed_point sigma).mp

end SIDEGRHTransfer
