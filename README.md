# SIDE-grh-transfer

Lean 4 kernel for the **Euler-balance voice + paired-form Symmetry voices** of GRH transfer — three of the seven mechanism-class voices of the SIDE method, faithfully transferred from ξ(s) to L(s, χ) via Mathlib''s `DirichletCharacter` API.

**J. York Seale** — https://orcid.org/0009-0008-7993-0310

---

## What it proves

### Voice1 (Euler-balance) — `CharacterTransfer.lean`
For a Dirichlet character χ mod n and a prime p ∤ n (the unramified case), the twisted Euler-balance equation

$$\|\chi(p)\| \cdot p^{-\sigma} = \|\chi(p)\| \cdot p^{-(1-\sigma)} \quad \Longleftrightarrow \quad \sigma = 1/2$$

holds, because **|χ(p)| = 1 is a theorem of Mathlib** (`DirichletCharacter.unit_norm_eq_one`) — not a posited hypothesis. The reduction is by genuine magnitude cancellation, proved against Mathlib''s character API.

### Voice3 (FE reflection, paired form) — `CharacterSymmetry.lean`

For any pair of Dirichlet characters (χ, χbar) — intended use: χbar = the conjugate character χ̄, paired by the functional equation Λ(s, χ) = ε(χ)·Λ(1−s, χbar) — the σ-axis `{ρ : ℂ | ρ.re = σ}` is invariant under the reflection ρ ↦ 1−ρ iff σ = 1/2.
The (χ, χbar) parameters are typed in the signature but unused in the current proof: the σ-axis algebra is character-independent and collapses to Voice3''s `reflect_fixed_iff`. The character signature expresses the (χ, χbar)-paired form that addresses the §20.1 looseness flagged by the audit-arc — the monograph''s "L(s, χ) satisfies its own functional equation" holds only for real χ; the correct general form pairs χ with its conjugate. The Lean typed-but-unused parameters are the hooks for when Mathlib''s L-series FE infrastructure matures and these proofs become genuine corollaries of FE-derived zero-pairing.
### Voice2 (conjugation symmetry-agreement, paired form) — `CharacterSymmetry.lean`

For any pair (χ, χbar), the σ-axis is the unique axis where conjugation and reflection agree on the real part — at σ = 1/2 both maps give back σ; elsewhere they disagree. Voice2 analog of the paired-reflection result; same character-typed signature, same algebra collapsing to Voice2''s `symmetries_agree_iff`.

## Scope

This is the **Voice1 (Euler-balance) + Voice3 (FE reflection, paired) + Voice2 (conjugation, paired)** legs of the GRH transfer — three of seven voices, plus none of the exclusion architecture. The remaining voices — Voice3b (Cauchy-Riemann codimension), Voice5 (modular), Voice6 (spectral), Voice7 (topological-trivial) — and the exhaustiveness/exclusion transfer to L(s, χ) are separate downstream targets.
GRH as a whole — that L(s, χ) has no off-line zeros — requires all seven voices transferred *and* the exclusion architecture transferred. Closing this kernel now closes Voice1, Voice3-paired, and Voice2-paired for L(s, χ); the rest remains open work. Voice2''s codimension-counting content (separate substantive result, not part of the symmetry-agreement reformulation that LV-H-6 specifies) will likely be vendored in a later module when the exclusion-architecture transfer needs it.

## Build

```bash
git clone https://github.com/psinary-sketch/SIDE-grh-transfer
cd SIDE-grh-transfer
lake exe cache get   # downloads pre-built Mathlib oleans from upstream CI cache
lake build           # compiles only this kernel''s modules; Mathlib comes from cache
```
**Toolchain** pinned in `lean-toolchain`: `leanprover/lean4:v4.29.1`.
**Mathlib** pinned in `lakefile.lean` to the released stable tag **`v4.29.1`** at commit `5e932f97dd25535344f80f9dd8da3aab83df0fe6` of `leanprover-community/mathlib4`. Cache coverage is complete (upstream CI publishes oleans for every released tag); reproduction does not require a local Mathlib build.

The Mathlib lemmas the proofs depend on:

**Voice1 (`CharacterTransfer.lean`):**
- `DirichletCharacter.unit_norm_eq_one` (`Mathlib/NumberTheory/DirichletCharacter/Bounds.lean:27`) — the value at a unit has norm 1, proved via `pow_card_eq_one''` (the standard root-of-unity argument).
- `ZMod.isUnit_prime_of_not_dvd` (`Mathlib/Data/ZMod/Basic.lean:824`) — for `p` prime and `¬ p ∣ n`, `(p : ZMod n)` is a unit.
**Voice3/Voice2 paired (`CharacterSymmetry.lean`):**
- `Complex.sub_re`, `Complex.one_re`, `Complex.ofReal_re` (`Mathlib/Data/Complex/Basic.lean`) — standard real-part computations for complex arithmetic. Used inside `simp` to reduce `(1 - (σ : ℂ)).re` to `1 - σ`.

All long-resident, stable lemmas — present at `v4.29.1` at the cited locations.

Verify zero `sorry` and zero custom axioms:

```bash
grep -rn "^\s*sorry\b" SIDEGRHTransfer/ --include="*.lean"   # expect: no matches
grep -rn "^axiom "      SIDEGRHTransfer/ --include="*.lean"   # expect: no matches
```

Verify against Lean-core axioms only:

```bash
lake env lean AxiomCheck.lean
# expected output: each of 5 theorems depends on axioms:
#   [propext, Classical.choice, Quot.sound]
# CRITICAL: no `sorryAx` in any list
```
## Federation context

This is the GRH-transfer member of the **PLACE TO STAND federation of kernels**. Each federation member is independent: own toolchain pin, own Mathlib pin, own Zenodo deposit, own version history. Cross-kernel content travels by **vendor-with-attribution**, not Lake cross-dependency.

The following files contain attribution-vendored content from `SIDE-kernel` (Phase S.5b context):

- `SIDEGRHTransfer/Voice1Vendored.lean` — `prime_as_real`, `prime_gt_one`, `rpow_injective`, `balance_theorem` from `SIDE-kernel/Kernel/Voice1.lean`
- `SIDEGRHTransfer/Voice3Vendored.lean` — `reflect`, `reflect_fixed_point_forward`, `reflect_fixed_iff` from `SIDE-kernel/Kernel/Voice3.lean`
- `SIDEGRHTransfer/Voice2Vendored.lean` — `conjugate_re`, `reflect_re`, `symmetries_agree_iff`, `symmetries_agree_forward` from `SIDE-kernel/Kernel/Voice2.lean`

Each file''s header notes the source path, commit hash (SIDE-kernel main HEAD), and what was vendored vs skipped. This kernel is **NOT an extension** of the SIDE-kernel RH flagship; it stands alone.
## Why Mathlib

Most SIDE-* kernels are vanilla Lean 4 (no Mathlib) — by design, to keep federation pieces independent and fast. This kernel is the explicit exception: `DirichletCharacter` lives in Mathlib, and the magnitude lemma we need for Voice1 (`unit_norm_eq_one`) IS the substance. Building against Mathlib here is the *faithful* path; without it, the |χ(p)| = 1 step would have to be posited as a hypothesis, which would defeat the point. The discipline correction (Phase S.5a) refused that shortcut.

The CharacterSymmetry.lean proofs use `Complex.sub_re`/`Complex.one_re`/`Complex.ofReal_re` from Mathlib''s complex arithmetic; the (χ, χbar)-paired form signatures use `DirichletCharacter ℂ n` from the same Mathlib infrastructure.
## Cross-references

- **Research-side anchors:** `FINDINGS_ADDITIONS_2026-05-21.md#grh-character-uniform` (Voice1 Euler-balance leg closed by this kernel); `FINDINGS_ADDITIONS_2026-05-21.md#monograph-grh-symmetry-loose-for-complex-chi` (§20.1 looseness fixed type-level by Voice3/Voice2 paired forms in this kernel).
- **Compile-list targets:** `LEAN_VERIFICATIONS_TODO_v0_1.md#LV-M-6` (Mathlib DirichletCharacter |χ(p)|=1 Euler-balance transfer — closed v0.1.0); `LEAN_VERIFICATIONS_TODO_v0_1.md#LV-H-6` (GRH Symmetry-voice χ ↔ χbar reformulation, Voice3 + Voice2 — closed v0.2.0).
- **Downstream open targets:** Voice3b/Voice5/Voice6/Voice7 transfers; exhaustiveness/exclusion architecture transfer; `LV-L-5` (Landau-Siegel, trivial-after-GRH, depends on LV-M-6 ✓ + LV-H-6 ✓ + downstream); Voice2 codimension-counting transfer.
- **State snapshot:** `STATE_2026-05-22.md` (audit-arc-end baseline).
- **Loom anchor:** `PLACE-papers/VERIFICATION_LOOM.md` rows L80-L81.
## Version history

- **v0.1.0** (2026-05-22): Voice1 (Euler-balance) leg only. `twisted_balance_at_unramified_prime`, `twisted_balance_at_half`, vendored `balance_theorem`. 3 substantive theorems, 0 sorry, 0 custom axioms. Tag `v0.1.0` at commit `27507a1`.
- **v0.2.0** (2026-05-28): Adds Voice3 (FE reflection, paired) and Voice2 (conjugation symmetry-agreement, paired) legs via `CharacterSymmetry.lean`, with vendoring through `Voice3Vendored.lean` and `Voice2Vendored.lean`. Adds `paired_reflection_axis_invariant_iff` and `paired_conjugation_real_axis_agree_iff`. AxiomCheck extended to verify all 5 substantive theorems. Total: 5 theorems, 0 sorry, 0 custom axioms.

## License

MIT.

## AI disclosure

*Computational workflow assisted by various LLM instances. Mathematical content, proof strategies, and editorial decisions are the author''s.*