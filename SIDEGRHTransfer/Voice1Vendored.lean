/-
  SIDE-grh-transfer · Voice1Vendored.lean
  ==========================================

  Attribution-vendored from SIDE-kernel/Kernel/Voice1.lean (commit 8a06885,
  Phase S.5b context).  Vendored content is the trimmed subset needed for
  the character-twist transfer:

    • `prime_as_real`
    • `prime_gt_one`
    • `rpow_injective`
    • `balance_theorem`

  Skipped (not used by `twisted_balance_at_unramified_prime`):

    • `balance_at_half` (corollary)
    • `voice_1_uniqueness` (variant)
    • `Voice1Derivation` (structure)

  The vendor-with-attribution pattern follows the PLACE TO STAND
  federation principle (each kernel independent; no Lake cross-dependency
  on SIDE-kernel).  The original is `SIDE-kernel/Kernel/Voice1.lean::
  balance_theorem`; this file reproduces only what is needed locally.

  Original author: J. York Seale.
-/

import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Data.Nat.Prime.Basic

namespace SIDEGRHTransfer

open Real

/-- Real-valued representation of a prime. -/
def prime_as_real (p : Nat) (_ : Nat.Prime p) : Real := (p : Real)

/-- Primes are greater than 1 (as reals). -/
lemma prime_gt_one {p : Nat} (hp : Nat.Prime p) : (1 : Real) < prime_as_real p hp := by
  unfold prime_as_real
  exact_mod_cast Nat.Prime.one_lt hp

/-- Real exponentiation by a fixed base p > 1 is injective in the exponent. -/
lemma rpow_injective {p : Real} (hp : 1 < p) :
    Function.Injective (fun x : Real => p ^ x) := by
  intro x y hxy
  rcases lt_trichotomy x y with hlt | heq | hgt
  · exact absurd hxy (ne_of_lt ((rpow_lt_rpow_left_iff hp).mpr hlt))
  · exact heq
  · exact absurd hxy (ne_of_gt ((rpow_lt_rpow_left_iff hp).mpr hgt))

/-- **Voice1's Euler-balance theorem.**  For any prime `p` and real `s`,
    the equation `p^(-s) = p^(-(1-s))` is equivalent to `s = 1/2`.

    This is the algebraic core of the SIDE Voice1 (Euler-balance)
    mechanism class: the multiplicative-place balance has its unique
    real-axis equilibrium at the critical line. -/
theorem balance_theorem (p : Nat) (hp : Nat.Prime p) (s : Real) :
    (prime_as_real p hp) ^ (-s) = (prime_as_real p hp) ^ (-(1 - s))
    ↔ s = 1 / 2 := by
  constructor
  · intro h_eq
    have hp_gt_one := prime_gt_one hp
    have inj := rpow_injective hp_gt_one
    have h_exp_eq : -s = -(1 - s) := inj h_eq
    linarith
  · intro h_sigma
    rw [h_sigma]
    ring_nf

end SIDEGRHTransfer
