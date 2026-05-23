import Lake
open Lake DSL

package sideGrhTransfer where
  leanOptions := #[]

-- Mathlib pinned to released stable upstream tag v4.29.1 for reproducibility.
-- Anyone who clones this repo can reproduce the build with the same
-- toolchain (v4.29.1, see lean-toolchain) and a cache pull from
-- leanprover-community Mathlib CI. The lemmas this kernel depends on
-- (DirichletCharacter.unit_norm_eq_one in Bounds.lean; ZMod.isUnit_prime_of_not_dvd
-- in Data/ZMod/Basic.lean) are stable, long-resident in this Mathlib release.
require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "5e932f97dd25535344f80f9dd8da3aab83df0fe6"

@[default_target]
lean_lib SIDEGRHTransfer where
  srcDir := "."
  globs := #[.submodules `SIDEGRHTransfer]
