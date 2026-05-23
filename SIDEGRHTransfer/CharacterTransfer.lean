/-
  SIDE-grh-transfer · CharacterTransfer.lean
  =============================================

  **Twisted Euler-balance transfer at an unramified prime.**

  The Voice1 (Euler-balance) leg of the GRH 7-voice transfer, faithfully
  carried via Mathlib's DirichletCharacter API.

  This file does NOT prove GRH.  It establishes that one of the seven
  SIDE mechanism classes — the Euler-balance / multiplicative-place
  class C₂ — transfers cleanly from ξ(s) to L(s, χ) for any primitive
  Dirichlet character χ mod n at any unramified prime p ∤ n, because
  the magnitude |χ(p)| = 1 by Mathlib's `DirichletCharacter.
  unit_norm_eq_one`.  The remaining six voices and the exhaustiveness
  / exclusion architecture transfer are separate downstream targets.

  The faithfulness here is real and load-bearing: ‖χ ((p : ZMod n))‖ is
  a *computed* quantity from Mathlib's character API (combining
  `ZMod.isUnit_prime_of_not_dvd` to identify p coprime to n as a unit
  in ZMod n, and `DirichletCharacter.unit_norm_eq_one` which gives
  ‖χ a‖ = 1 at units via the standard root-of-unity step, internally
  using `pow_card_eq_one'`).  The theorem statement carries the magnitude
  through, and the proof shows it equals 1 from the Mathlib lemma —
  rather than positing |χ(p)| = 1 as a hypothesis.

  May 2026.
-/

import Mathlib.NumberTheory.DirichletCharacter.Bounds
import Mathlib.Data.ZMod.Basic
import SIDEGRHTransfer.Voice1Vendored

namespace SIDEGRHTransfer

open DirichletCharacter

/-- **Twisted Euler-balance transfer at an unramified prime.**

    For a Dirichlet character `χ : DirichletCharacter ℂ n` and a prime
    `p` with `p ∤ n` (the unramified case — where the Euler factor of
    L(s, χ) at p is active), the character-twisted Euler-balance equation

      `‖χ (p)‖ · p^(-σ) = ‖χ (p)‖ · p^(-(1-σ))   ↔   σ = 1/2`

    holds with equality forced uniquely at σ = 1/2.

    **L(s, χ) context.**  The Euler factor of L(s, χ) at an unramified
    prime p is `(1 - χ(p)·p^(-s))^(-1)`.  At a zero of L(s, χ), the
    local contribution `χ(p)·p^(-s)` and its functional-equation
    reflection `χ(p)·p^(-(1-s))` must align in magnitude — which,
    after extracting the common character-magnitude factor ‖χ(p)‖,
    reduces the comparison to `p^(-σ) = p^(-(1-σ))` — Voice1's
    `balance_theorem`, which forces σ = 1/2 uniquely.

    The substance of this theorem is therefore: **the character twist
    preserves the Euler balance because ‖χ(p)‖ = 1** at unramified
    primes (proved against Mathlib's `DirichletCharacter.
    unit_norm_eq_one`, not posited).  Without that magnitude fact, the
    `‖χ(p)‖` factor would not cancel and the balance would not transfer.

    **Ramified case (out of scope here).**  When `p ∣ n`, `χ(p) = 0` by
    `MulChar.map_nonunit`, and the Euler factor at p degenerates to 1
    (no s-dependent constraint).  Those primes contribute no balance
    information and are correctly excluded by the `¬ p ∣ n` hypothesis.

    **Scope.**  This is one of seven voices in the GRH transfer.  GRH
    as a whole — L(s, χ) has no off-line zeros — requires the full
    voice-set transferred AND the exhaustiveness/exclusion architecture
    transferred.  Voice3 (functional equation), in particular, requires
    a (χ, χ̄)-paired reformulation for complex χ (see LV-H-6).  This
    file closes the Voice1 (Euler-balance) leg only.

    Voice1's `balance_theorem` is attribution-vendored from
    `SIDE-kernel/Kernel/Voice1.lean`. -/
theorem twisted_balance_at_unramified_prime
    {n : ℕ} [NeZero n] (χ : DirichletCharacter ℂ n)
    (p : ℕ) (hp : Nat.Prime p) (hpn : ¬ p ∣ n)
    (s : ℝ) :
    ‖χ ((p : ZMod n))‖ * (prime_as_real p hp) ^ (-s)
      = ‖χ ((p : ZMod n))‖ * (prime_as_real p hp) ^ (-(1 - s))
    ↔ s = 1 / 2 := by
  -- Step 1: prime + unramified ⇒ (p : ZMod n) is a unit (Mathlib).
  have hu : IsUnit ((p : ZMod n)) := ZMod.isUnit_prime_of_not_dvd hp hpn
  -- Step 2: magnitude at a unit is 1 (Mathlib's `unit_norm_eq_one`,
  -- proved internally via `pow_card_eq_one'` — the root-of-unity step).
  have hχ : ‖χ ((p : ZMod n))‖ = 1 := by
    rw [← hu.unit_spec]
    exact χ.unit_norm_eq_one hu.unit
  -- Step 3: substitute, reduce to Voice1's balance_theorem.
  rw [hχ, one_mul, one_mul]
  exact balance_theorem p hp s

/-- Corollary: at σ = 1/2, the twisted Euler balance holds. -/
theorem twisted_balance_at_half
    {n : ℕ} [NeZero n] (χ : DirichletCharacter ℂ n)
    (p : ℕ) (hp : Nat.Prime p) (hpn : ¬ p ∣ n) :
    ‖χ ((p : ZMod n))‖ * (prime_as_real p hp) ^ (-(1 / 2 : ℝ))
      = ‖χ ((p : ZMod n))‖ * (prime_as_real p hp) ^ (-(1 - 1 / 2 : ℝ)) :=
  (twisted_balance_at_unramified_prime χ p hp hpn (1 / 2)).mpr rfl

end SIDEGRHTransfer
