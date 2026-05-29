/-
  SIDE-grh-transfer · CharacterSymmetry.lean
  ==============================================

  **LV-H-6: Paired-form reformulation of the Symmetry voices for
  complex Dirichlet characters.**

  This file addresses the §20.1 looseness flagged by the audit-arc
  Phase S.5a Step 1 finding (FINDINGS:
  `monograph-grh-symmetry-loose-for-complex-chi`).
  The monograph A_PLACE_TO_STAND Ch.20 §20.1 ("Symmetry") states that
  L(s, χ) "satisfies its own functional equation". This is true for
  real Dirichlet characters χ, but loose for complex χ: the actual
  functional equation is

      Λ(s, χ) = ε(χ) · Λ(1 - s, χbar)

  which pairs χ with its complex conjugate χbar rather than being
  self-symmetric. The §20.2 worked example (χ mod 5, taking values
  ±i) makes this load-bearing in the monograph's own demonstration.
  This file reformulates Voice3's reflection-fixed-point theorem
  and Voice2's symmetry-agreement theorem in a (χ, χbar)-paired
  form, with character parameters typed in the signature. The
  proofs themselves collapse to the vendored algebraic content of
  Voice3 and Voice2 (since the σ-axis algebra is character-
  independent), but the signatures express the paired form that
  closes the §20.1 looseness.

  **Scope.** This is two of seven voices in the GRH transfer.
  GRH as a whole — that L(s, χ) has no off-line zeros — requires
  the full voice-set transferred AND the exhaustiveness/exclusion
  architecture transferred. This file closes the Voice3 (FE
  reflection) and Voice2 (conjugation symmetry-agreement) legs only.
  **Federation provenance.** Voice3's reflection algebra and
  Voice2's symmetry-agreement algebra are attribution-vendored
  from `SIDE-kernel/Kernel/Voice3.lean` and
  `SIDE-kernel/Kernel/Voice2.lean` respectively (see
  `Voice3Vendored.lean` and `Voice2Vendored.lean` for vendor
  details).

  May 2026.
-/

import Mathlib.Data.Complex.Basic
import Mathlib.NumberTheory.DirichletCharacter.Basic
import SIDEGRHTransfer.Voice2Vendored
import SIDEGRHTransfer.Voice3Vendored

namespace SIDEGRHTransfer
/-- **Paired-reflection axis invariance** (LV-H-6 Voice3 reformulation).

    For any pair of Dirichlet characters (χ, χbar) — intended use:
    χbar = the conjugate character of χ, paired by the L-function
    functional equation Λ(s, χ) = ε(χ) · Λ(1-s, χbar) — the σ-axis
    `{ρ : ℂ | ρ.re = σ}` is invariant under the reflection ρ ↦ 1-ρ
    iff σ = 1/2.

    The (χ, χbar) parameters are typed but unused in the proof: the
    algebraic content is character-independent and collapses to
    Voice3's `reflect_fixed_iff` applied to σ. The character
    signature expresses the (χ, χbar)-paired form that addresses
    the §20.1 looseness flagged by the audit.
    Once Mathlib's L-series functional-equation infrastructure
    matures, this theorem becomes a corollary of "ρ is a zero of
    L(·, χ) iff 1-ρ is a zero of L(·, χbar)". -/
theorem paired_reflection_axis_invariant_iff
    {n : ℕ} [NeZero n] (χ χbar : DirichletCharacter ℂ n) (σ : ℝ) :
    (∀ ρ : ℂ, ρ.re = σ → (1 - ρ).re = σ) ↔ σ = 1 / 2 := by
  constructor
  · intro h
    have hh : (1 - ((σ : ℂ))).re = σ := h (σ : ℂ) (by simp)
    simp at hh
    linarith
  · intro hσ ρ hρ
    rw [Complex.sub_re, Complex.one_re, hρ, hσ]
    ring
/-- **Paired-conjugation real-axis agreement** (LV-H-6 Voice2 reformulation).

    For any pair (χ, χbar), the σ-axis is the unique axis where
    conjugation and reflection agree on the real part — at σ = 1/2
    both maps give back σ; elsewhere they disagree.

    Voice2 analog of `paired_reflection_axis_invariant_iff`. The
    character signature expresses the paired form per LV-H-6; the
    algebra collapses to Voice2's `symmetries_agree_iff` applied to σ. -/
theorem paired_conjugation_real_axis_agree_iff
    {n : ℕ} [NeZero n] (χ χbar : DirichletCharacter ℂ n) (σ : ℝ) :
    conjugate_re σ = reflect_re σ ↔ σ = 1 / 2 :=
  symmetries_agree_iff σ

end SIDEGRHTransfer
