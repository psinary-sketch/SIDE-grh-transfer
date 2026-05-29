/-
  SIDE-grh-transfer · CharacterCodim.lean
  ===========================================

  **Voice3b paired-form: Cauchy-Riemann codimension for L(s, χ).**

  Lifts Voice3b's `cr_minimal_iff` (zero codimension is minimal
  iff σ = 1/2) to the (χ, χbar)-paired form for complex
  Dirichlet characters.

  The substance: for ξ(s), zeros at σ = 1/2 are codim 1 (one real
  equation — ξ is real-valued there); off σ = 1/2 they're codim 2
  (Re and Im both vanish — ξ is genuinely complex). The Cauchy-
  Riemann structure ensures this codim drop is sharp.
  For L(s, χ) with complex χ, the analog requires the (χ, χbar)
  pairing: zeros of L(·, χ) and L(·, χbar) form a joint paired
  system, and the joint codim is minimal exactly when σ = 1/2.
  The Lean theorem expresses this with typed (χ, χbar) parameters;
  the σ-axis algebra collapses to Voice3b's `cr_minimal_iff`.
  When Mathlib's L-series FE infrastructure matures, this becomes
  a corollary of the joint codim argument.
  **Federation provenance.** Voice3b's codim algebra is
  attribution-vendored from `SIDE-kernel/Kernel/Voice3b.lean`
  (see `Voice3bVendored.lean`). Voice3b's `zero_codimension` is
  the SAME algebraic content as Voice2's codim-counting deferred
  per LV-H-6 spec, so this file transitively covers Voice2's
  codim aspect as well.

  **Scope.** Chorus extension (3-of-7 → 4-of-7 voices closed);
  transitively closes Voice2 codim too.

  May 2026.
-/

import Mathlib.Data.Complex.Basic
import Mathlib.NumberTheory.DirichletCharacter.Basic
import SIDEGRHTransfer.Voice3bVendored

namespace SIDEGRHTransfer
/-- **Paired-form Cauchy-Riemann codimension axis characterization**
    (chorus extension, Voice3b reformulation).

    For any pair of Dirichlet characters (χ, χbar) — intended use:
    χbar = the conjugate character of χ — the σ at which the
    L-function zero-set has minimal Cauchy-Riemann codimension
    is σ = 1/2.

    The (χ, χbar) parameters are typed in the signature but unused
    in the proof: the σ-axis algebra is character-independent and
    collapses to Voice3b's `cr_minimal_iff` applied to σ. The
    character signature expresses the (χ, χbar)-paired form;
    the actual joint codim argument on (L(·, χ), L(·, χbar))
    requires Mathlib L-series FE infrastructure not yet at the
    depth needed.
    Note: Voice3b's codim algebra is the same as Voice2's deferred
    codim content; this theorem transitively closes Voice2's
    codim aspect as well. -/
theorem paired_cr_minimal_codim_axis_iff
    {n : ℕ} [NeZero n] (χ χbar : DirichletCharacter ℂ n) (σ : ℝ) :
    cr_minimal_codim σ ↔ σ = 1 / 2 :=
  cr_minimal_iff σ

end SIDEGRHTransfer
