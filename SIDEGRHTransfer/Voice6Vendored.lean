/-
  SIDE-grh-transfer · Voice6Vendored.lean
  ===========================================

  Attribution-vendored from SIDE-kernel/Kernel/Voice6.lean
  (SIDE-kernel main HEAD 2c49ae6, file unchanged since
  pre-audit-arc baseline 2026-04-30, Phase S.5b chorus
  extension context).  Vendored content is the trimmed
  subset needed for the (χ, χbar)-paired reformulation
  of the spectral self-adjointness voice:

    • `spectral_offset`         — σ ↦ σ − 1/2
    • `offset_zero_iff`         — spectral_offset σ = 0 ↔ σ = 1/2  (substance)
    • `self_adjoint_constraint` — predicate: spectral_offset σ = 0
    • `self_adjoint_forces_half` — forward direction
  Skipped (not used by `paired_spectral_offset_zero_iff`):

    • `self_adjoint_at_half` (corollary; trivial substitution)
    • `self_adjoint_violated_off_line` (contrapositive wrapper)
    • `c6_rests_at_half`, `c6_forces_half` (aliases)
    • `Voice6Derivation` (structure form)

  Voice6 says: the Hilbert-Polya program posits a self-adjoint
  operator T whose eigenvalues are the nontrivial zeros of ξ.
  Self-adjointness forces real eigenvalues; via the change-of-
  parameter s = 1/2 + iλ, this constrains σ = 1/2 (the spectral
  offset δ = σ − 1/2 must vanish). The algebraic core: the offset
  is zero iff σ = 1/2.
  Federation provenance: vendor-with-attribution per the PLACE
  TO STAND principle.  Original author: J. York Seale.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace SIDEGRHTransfer
/-- **Spectral offset.** How far σ is from the critical line:
    δ = σ − 1/2. Self-adjointness forces δ = 0 (real eigenvalues
    via s = 1/2 + iλ change of parameter). -/
noncomputable def spectral_offset (sigma : Real) : Real := sigma - 1 / 2

/-- **Zero spectral offset iff on the critical line.**  Voice6's
    main result; this is the iff `paired_spectral_offset_zero_iff`
    delegates to. -/
theorem offset_zero_iff (sigma : Real) :
    spectral_offset sigma = 0 ↔ sigma = 1 / 2 := by
  unfold spectral_offset
  constructor
  · intro h; linarith
  · intro h; rw [h]; ring
/-- **Self-adjointness condition (predicate form).** Encodes the
    Hilbert-Polya chain: self-adjoint T → real eigenvalues →
    λ real → δ = 0. We model the conclusion directly as a σ-level
    constraint. -/
def self_adjoint_constraint (sigma : Real) : Prop :=
  spectral_offset sigma = 0

/-- Self-adjointness forces σ = 1/2. -/
theorem self_adjoint_forces_half (sigma : Real) :
    self_adjoint_constraint sigma → sigma = 1 / 2 := by
  unfold self_adjoint_constraint
  exact (offset_zero_iff sigma).mp

end SIDEGRHTransfer
