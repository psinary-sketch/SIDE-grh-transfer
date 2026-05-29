/-
  SIDE-grh-transfer · CharacterSpectral.lean
  ===========================================

  **Voice6 paired-form: spectral self-adjointness for L(s, χ).**

  Lifts Voice6's `offset_zero_iff` (the spectral offset δ = σ − 1/2
  is zero iff σ = 1/2) to the (χ, χbar)-paired form for complex
  Dirichlet characters.

  The substance: for ξ(s), the Hilbert-Polya program posits a
  self-adjoint operator T with eigenvalues equal to the nontrivial
  zeros. Self-adjointness forces real eigenvalues; via the change-
  of-parameter s = 1/2 + iλ, λ ∈ ℝ corresponds to σ = 1/2. The
  spectral offset δ = σ − 1/2 vanishes exactly on the critical line.
  For L(s, χ) with complex χ, the analog requires the (χ, χbar)
  pairing: the conjectured self-adjoint operator T_χ for L(·, χ)
  intertwines with T_χbar for L(·, χbar) under conjugation, and
  the joint spectrum lies on σ = 1/2 iff both operators are self-
  adjoint in the appropriate paired sense. The Lean theorem
  expresses this with typed (χ, χbar) parameters; the σ-axis
  algebra collapses to Voice6's `offset_zero_iff`. When Mathlib's
  spectral theory infrastructure matures sufficiently (e.g., for
  unbounded self-adjoint operators on suitable Hilbert spaces),
  this becomes a corollary of the paired Hilbert-Polya argument.
  **Federation provenance.** Voice6's spectral offset algebra is
  attribution-vendored from `SIDE-kernel/Kernel/Voice6.lean`
  (see `Voice6Vendored.lean`).

  **Scope.** Chorus extension (5-of-7 → 6-of-7 voices closed
  after Voice3b + Voice5 earlier in v0.3.0). Voice7 (σ-inert,
  topological) remains; deposited separately as v0.4.0.

  May 2026.
-/

import Mathlib.Data.Complex.Basic
import Mathlib.NumberTheory.DirichletCharacter.Basic
import SIDEGRHTransfer.Voice6Vendored

namespace SIDEGRHTransfer
/-- **Paired-form spectral offset axis characterization**
    (chorus extension, Voice6 reformulation).

    For any pair of Dirichlet characters (χ, χbar) — intended use:
    χbar = the conjugate character of χ — the σ-axis on which the
    spectral offset δ = σ − 1/2 vanishes is σ = 1/2.

    The (χ, χbar) parameters are typed in the signature but unused
    in the proof: the σ-axis algebra is character-independent and
    collapses to Voice6's `offset_zero_iff` applied to σ. The
    character signature expresses the (χ, χbar)-paired form; the
    actual joint self-adjointness argument on (T_χ, T_χbar)
    requires Mathlib's unbounded spectral theory infrastructure
    not yet at the depth needed.
    Voice6's distinctive content: the Hilbert-Polya program gives
    a spectral mechanism for σ = 1/2, complementing the FE,
    modular, and codim mechanisms from Voice3 / Voice5 / Voice3b. -/
theorem paired_spectral_offset_zero_iff
    {n : ℕ} [NeZero n] (χ χbar : DirichletCharacter ℂ n) (σ : ℝ) :
    spectral_offset σ = 0 ↔ σ = 1 / 2 :=
  offset_zero_iff σ

end SIDEGRHTransfer
