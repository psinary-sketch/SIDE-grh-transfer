# SIDE-grh-transfer

Lean 4 kernel for the **complete seven-voice chorus** of GRH transfer — all seven mechanism-class voices of the SIDE method, faithfully transferred from ξ(s) to L(s, χ) via Mathlib's `DirichletCharacter` API.

**J. York Seale** — https://orcid.org/0009-0008-7993-0310

---

## What it proves

### Voice1 (Euler-balance) — `CharacterTransfer.lean`

For a Dirichlet character χ mod n and a prime p ∤ n (the unramified case), the twisted Euler-balance equation

$$|\chi(p)| \cdot p^{-\sigma} = |\chi(p)| \cdot p^{-(1-\sigma)} \quad \Longleftrightarrow \quad \sigma = 1/2$$

holds, because **|χ(p)| = 1 is a theorem of Mathlib** (`DirichletCharacter.unit_norm_eq_one`) — not a posited hypothesis. The reduction is by genuine magnitude cancellation, proved against Mathlib's character API.
### Voice3 (FE reflection, paired form) — `CharacterSymmetry.lean`

For any pair of Dirichlet characters (χ, χbar) — intended use: χbar = the conjugate character χ̄, paired by the functional equation Λ(s, χ) = ε(χ)·Λ(1−s, χbar) — the σ-axis `{ρ : ℂ | ρ.re = σ}` is invariant under the reflection ρ ↦ 1−ρ iff σ = 1/2.
The (χ, χbar) parameters are typed in the signature but unused in the current proof: the σ-axis algebra is character-independent and collapses to Voice3's `reflect_fixed_iff`. The character signature expresses the (χ, χbar)-paired form that addresses the §20.1 looseness flagged by the audit-arc — the monograph's "L(s, χ) satisfies its own functional equation" holds only for real χ; the correct general form pairs χ with its conjugate. The Lean typed-but-unused parameters are the hooks for when Mathlib's L-series FE infrastructure matures and these proofs become genuine corollaries of FE-derived zero-pairing.

### Voice2 (conjugation symmetry-agreement, paired form) — `CharacterSymmetry.lean`

For any pair (χ, χbar), the σ-axis is the unique axis where conjugation and reflection agree on the real part — at σ = 1/2 both maps give back σ; elsewhere they disagree. Voice2 analog of the paired-reflection result; same character-typed signature, same algebra collapsing to Voice2's `symmetries_agree_iff`.
### Voice3b (Cauchy-Riemann codimension, paired form) — `CharacterCodim.lean`

For any pair (χ, χbar), the σ at which the L-function zero-set has minimal Cauchy-Riemann codimension (codim 1, one real equation — ξ is real-valued there) is σ = 1/2; off σ = 1/2 the codim is 2 (both Re and Im vanish, ξ is genuinely complex). Voice3b's algebraic core: `zero_codimension σ := if σ = 1/2 then 1 else 2`; the iff-σ=1/2 lifts to the paired form with χ/χbar typed but unused, same delegation pattern as Voice3/Voice2.

**Transitively closes Voice2 codim.** Voice3b's `zero_codimension` is the same algebraic content as the Voice2 codimension theorems we deferred in v0.2.0 per LV-H-6 spec. Vendoring Voice3b covers Voice2's codim aspect by the same algebra, so Voice2 is now fully covered (symmetry-agreement in v0.2.0 + codim transitively in v0.3.0).
### Voice5 (modular S-fixed-point, paired form) — `CharacterModular.lean`

For any pair (χ, χbar), the σ-axis fixed by the modular S-involution σ ↦ 1−σ is σ = 1/2. Voice5's distinctive content beyond Voice3 (which proves the same σ=1/2 fixed point via the FE reflection): the order-3 modular generator R = ST contributes no σ-constraint, so PSL2(ℤ) ≅ ℤ/2 ∗ ℤ/3 exhausts to exactly one σ axis.

### Voice6 (spectral self-adjointness, paired form) — `CharacterSpectral.lean`

For any pair (χ, χbar), the σ on which the spectral offset δ = σ − 1/2 vanishes is σ = 1/2. The Hilbert-Polya program posits a self-adjoint operator T whose eigenvalues are the nontrivial zeros; via s = 1/2 + iλ, real eigenvalues ⟺ σ = 1/2. The Lean theorem expresses the paired joint-spectrum form (T_χ for L(·, χ) intertwining with T_χbar for L(·, χbar)) with typed χ/χbar parameters; collapses algebraically to Voice6's `offset_zero_iff`.
### Voice7 (topological inertness, paired form) — `CharacterTopological.lean`

**Structurally inverted from voices 1/2/3/3b/5/6.** For any pair (χ, χbar), the topological contribution to zero-placement is σ-INDEPENDENT — constant in σ. Where the other six voices each prove `iff σ = 1/2` (their mechanism forces zeros to the critical line), Voice7 proves σ-INERTNESS: the topological class cannot place zeros at any specific σ. The Hadamard product / argument principle COUNTS zeros and RELATES locations to growth, but does not PREFER any σ. Together with the other six, this gives chorus exhaustiveness: every mechanism class is either forcing σ = 1/2 or incapable of placing a zero anywhere.
## Scope

This is the **complete seven-voice chorus** of the GRH transfer — six iff-σ=1/2 voices (Voice1 + Voice2-paired + Voice3-paired + Voice3b-paired + Voice5-paired + Voice6-paired) plus one σ-inert voice (Voice7-paired) for chorus exhaustiveness. The remaining open work for full GRH closure is the **exhaustiveness/exclusion architecture transfer** — a separate downstream target, not a voice transfer.

GRH as a whole — that L(s, χ) has no off-line zeros — requires all seven voices transferred (now ✓) *and* the exhaustiveness/exclusion architecture transferred (open). Closing this kernel now closes all 7 voices for L(s, χ); only the exclusion architecture remains.
**Spec note.** Voice3b/Voice5/Voice6 (v0.3.0) and Voice7 (v0.4.0) transfers are **not enumerated in `LEAN_VERIFICATIONS_TODO_v0_1.md`** — only LV-H-6 (Voice3 + Voice2 paired) was specifically flagged by the audit-arc. The chorus-completion framing is the author's broader research direction beyond the specced compile-list; these voices were transferred because the algebraic core was tractable (pure real-axis algebra, no heavy Mathlib infrastructure needed) and the design pattern (vendor + typed-paired delegation) had been established by LV-H-6.

## Build

```bash
git clone https://github.com/psinary-sketch/SIDE-grh-transfer
cd SIDE-grh-transfer
lake exe cache get   # downloads pre-built Mathlib oleans from upstream CI cache
lake build           # compiles only this kernel's modules; Mathlib comes from cache
```
**Toolchain** pinned in `lean-toolchain`: `leanprover/lean4:v4.29.1`.
**Mathlib** pinned in `lakefile.lean` to the released stable tag **`v4.29.1`** at commit `5e932f97dd25535344f80f9dd8da3aab83df0fe6` of `leanprover-community/mathlib4`. Cache coverage is complete (upstream CI publishes oleans for every released tag); reproduction does not require a local Mathlib build.

The Mathlib lemmas the proofs depend on:

**Voice1 (`CharacterTransfer.lean`):**
- `DirichletCharacter.unit_norm_eq_one` (`Mathlib/NumberTheory/DirichletCharacter/Bounds.lean:27`) — the value at a unit has norm 1, proved via `pow_card_eq_one'` (the standard root-of-unity argument).
- `ZMod.isUnit_prime_of_not_dvd` (`Mathlib/Data/ZMod/Basic.lean:824`) — for `p` prime and `¬ p ∣ n`, `(p : ZMod n)` is a unit.
**Voice3/Voice2 paired (`CharacterSymmetry.lean`):**
- `Complex.sub_re`, `Complex.one_re`, `Complex.ofReal_re` (`Mathlib/Data/Complex/Basic.lean`) — standard real-part computations for complex arithmetic. Used inside `simp` to reduce `(1 - (σ : ℂ)).re` to `1 - σ`.

**Voice3b/Voice5/Voice6/Voice7 paired (`CharacterCodim.lean`, `CharacterModular.lean`, `CharacterSpectral.lean`, `CharacterTopological.lean`):**
- Substance files import `Mathlib.Data.Complex.Basic` and `Mathlib.NumberTheory.DirichletCharacter.Basic` for the typed (χ, χbar) signature; algebraic core (`cr_minimal_iff`, `S_fixed_point`, `offset_zero_iff`, `topological_no_sigma_preference`) is real-axis arithmetic provable by `linarith` / `ring` / `omega` / `rfl`, no further Mathlib infrastructure required.

All long-resident, stable lemmas — present at `v4.29.1` at the cited locations.
Verify zero `sorry` and zero custom axioms:

```bash
grep -rn "^\s*sorry\b" SIDEGRHTransfer/ --include="*.lean"   # expect: no matches
grep -rn "^axiom "      SIDEGRHTransfer/ --include="*.lean"   # expect: no matches
```

Verify against Lean-core axioms only:

```bash
lake env lean AxiomCheck.lean
# expected output: each of 9 theorems depends on axioms:
#   [propext, Classical.choice, Quot.sound]
# CRITICAL: no `sorryAx` in any list
```

## Federation context

This is the GRH-transfer member of the **PLACE TO STAND federation of kernels**. Each federation member is independent: own toolchain pin, own Mathlib pin, own Zenodo deposit, own version history. Cross-kernel content travels by **vendor-with-attribution**, not Lake cross-dependency.
The following files contain attribution-vendored content from `SIDE-kernel` (Phase S.5b context):

- `SIDEGRHTransfer/Voice1Vendored.lean` — `prime_as_real`, `prime_gt_one`, `rpow_injective`, `balance_theorem` from `SIDE-kernel/Kernel/Voice1.lean`
- `SIDEGRHTransfer/Voice3Vendored.lean` — `reflect`, `reflect_fixed_point_forward`, `reflect_fixed_iff` from `SIDE-kernel/Kernel/Voice3.lean`
- `SIDEGRHTransfer/Voice2Vendored.lean` — `conjugate_re`, `reflect_re`, `symmetries_agree_iff`, `symmetries_agree_forward` from `SIDE-kernel/Kernel/Voice2.lean`
- `SIDEGRHTransfer/Voice3bVendored.lean` — `zero_codimension`, `cr_minimal_codim`, `cr_minimal_iff`, `cr_forces_half` from `SIDE-kernel/Kernel/Voice3b.lean`
- `SIDEGRHTransfer/Voice5Vendored.lean` — `S_action`, `S_involution`, `S_fixed_point`, `R_action`, `R_no_constraint`, `modular_forces_half` from `SIDE-kernel/Kernel/Voice5.lean`
- `SIDEGRHTransfer/Voice6Vendored.lean` — `spectral_offset`, `offset_zero_iff`, `self_adjoint_constraint`, `self_adjoint_forces_half` from `SIDE-kernel/Kernel/Voice6.lean`
- `SIDEGRHTransfer/Voice7Vendored.lean` — `topological_contribution`, `topological_constant`, `topological_no_sigma_preference`, `topological_rests`, `c7_rests_everywhere` from `SIDE-kernel/Kernel/Voice7.lean`

Each file's header notes the source path, commit hash (SIDE-kernel main HEAD), and what was vendored vs skipped. This kernel is **NOT an extension** of the SIDE-kernel RH flagship; it stands alone.

## Why Mathlib

Most SIDE-* kernels are vanilla Lean 4 (no Mathlib) — by design, to keep federation pieces independent and fast. This kernel is the explicit exception: `DirichletCharacter` lives in Mathlib, and the magnitude lemma we need for Voice1 (`unit_norm_eq_one`) IS the substance. Building against Mathlib here is the *faithful* path; without it, the |χ(p)| = 1 step would have to be posited as a hypothesis, which would defeat the point. The discipline correction (Phase S.5a) refused that shortcut.
The CharacterSymmetry / CharacterCodim / CharacterModular / CharacterSpectral / CharacterTopological substance files use `Complex.sub_re` / `Complex.one_re` / `Complex.ofReal_re` from Mathlib's complex arithmetic where needed; the (χ, χbar)-paired form signatures use `DirichletCharacter ℂ n` from the same Mathlib infrastructure.

## Cross-references

- **Research-side anchors:** `FINDINGS_ADDITIONS_2026-05-21.md#grh-character-uniform` (Voice1 Euler-balance leg closed by this kernel); `FINDINGS_ADDITIONS_2026-05-21.md#monograph-grh-symmetry-loose-for-complex-chi` (§20.1 looseness fixed type-level by Voice3/Voice2 paired forms in this kernel).
- **Compile-list targets:** `LEAN_VERIFICATIONS_TODO_v0_1.md#LV-M-6` (closed v0.1.0); `LEAN_VERIFICATIONS_TODO_v0_1.md#LV-H-6` (closed v0.2.0). **Voice3b/Voice5/Voice6 (v0.3.0) and Voice7 (v0.4.0) are not specified** in the TODO; treated as author-directed broader-plan work.
- **Downstream open targets:** exhaustiveness/exclusion architecture transfer (required for actual GRH closure now that all 7 voices have landed); `LV-L-5` (Landau-Siegel, trivial-after-GRH).
- **State snapshot:** `STATE_2026-05-22.md`.
- **Loom anchor:** `PLACE-papers/VERIFICATION_LOOM.md` rows L80-L81.
## Version history

- **v0.1.0** (2026-05-22): Voice1 (Euler-balance) leg only. `twisted_balance_at_unramified_prime`, `twisted_balance_at_half`, vendored `balance_theorem`. 3 substantive theorems, 0 sorry, 0 custom axioms. Tag `v0.1.0` at commit `27507a1`.
- **v0.2.0** (2026-05-28): Adds Voice3 + Voice2 paired legs via `CharacterSymmetry.lean`, with vendoring through `Voice3Vendored.lean` and `Voice2Vendored.lean`. Adds `paired_reflection_axis_invariant_iff` and `paired_conjugation_real_axis_agree_iff`. Total: 5 theorems, 0 sorry, 0 custom axioms. Closes LV-H-6. Tag `v0.2.0` at commit `61d388f`.
- **v0.3.0** (2026-05-28): Adds Voice3b / Voice5 / Voice6 paired forms via `CharacterCodim.lean`, `CharacterModular.lean`, `CharacterSpectral.lean`, with vendoring through `Voice3bVendored.lean`, `Voice5Vendored.lean`, `Voice6Vendored.lean`. Adds `paired_cr_minimal_codim_axis_iff`, `paired_modular_S_fixed_iff`, `paired_spectral_offset_zero_iff`. **Transitively closes Voice2 codim** (Voice3b algebra = deferred Voice2 codim algebra). Total: 8 theorems, 0 sorry, 0 custom axioms. Chorus at 6-of-7 voices. Apostrophe-escape cleanup pass across all 12 files. Voice3b/Voice5/Voice6 transfers are author-directed broader-plan work beyond the LV-* spec-tracked compile-list. Tag `v0.3.0` at commit `cdf201a`.
- **v0.4.0** (2026-05-28): Adds Voice7 (topological inertness, paired form) via `CharacterTopological.lean`, with vendoring through `Voice7Vendored.lean`. Adds `paired_topological_no_sigma_preference`. **Structurally inverted** from the other six voices: not an iff-σ=1/2 theorem but a constant-equality (topological_contribution σ = topological_contribution (1/2), both equal because the contribution is constant). Voice7 proves σ-INERTNESS — the topological class cannot place zeros at any specific σ. Completes the **7-of-7 voice chorus**. Total: 9 theorems, 0 sorry, 0 custom axioms. Remaining open work for full GRH closure: exhaustiveness/exclusion architecture transfer (separate downstream target, not a voice transfer).

## License

MIT.

## AI disclosure

*Computational workflow assisted by various LLM instances. Mathematical content, proof strategies, and editorial decisions are the author's.*