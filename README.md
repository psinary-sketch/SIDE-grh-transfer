# SIDE-grh-transfer

Lean 4 kernel for the **Euler-balance voice transfer** under primitive Dirichlet character twist — one of the seven mechanism-class voices of the SIDE method, faithfully transferred from ξ(s) to L(s, χ) via Mathlib's `DirichletCharacter` API.

**J. York Seale** — https://orcid.org/0009-0008-7993-0310

---

## What it proves

For a Dirichlet character χ mod n and a prime p ∤ n (the unramified case), the twisted Euler-balance equation

$$\|\chi(p)\| \cdot p^{-\sigma} = \|\chi(p)\| \cdot p^{-(1-\sigma)} \quad \Longleftrightarrow \quad \sigma = 1/2$$

holds, because **|χ(p)| = 1 is a theorem of Mathlib** (`DirichletCharacter.unit_norm_eq_one`) — not a posited hypothesis. The reduction is by genuine magnitude cancellation, proved against Mathlib's character API.

## Scope

This is the **Voice1 (Euler-balance)** leg of the GRH transfer, only. It establishes that one of the seven SIDE mechanism classes transfers cleanly to L(s, χ); it does NOT establish GRH as a whole. The remaining voices — Voice2 (conjugation), Voice3 (functional equation, see LV-H-6 for the χ↔χ̄ reformulation needed for complex χ), Voice3b (Cauchy-Riemann codimension), Voice5 (modular), Voice6 (spectral), Voice7 (topological-trivial) — and the exhaustiveness/exclusion transfer to L(s, χ) are separate downstream targets.

GRH as a whole — that L(s, χ) has no off-line zeros — requires all seven voices transferred *and* the exclusion architecture transferred. Closing this kernel moves Voice1 from argument-supported to kernel-verified for L(s, χ); the rest is open work.

## Build

```bash
git clone https://github.com/psinary-sketch/SIDE-grh-transfer
cd SIDE-grh-transfer
lake exe cache get   # downloads pre-built Mathlib oleans from upstream CI cache
lake build           # compiles only this kernel's 2 modules; Mathlib comes from cache
```

**Toolchain** pinned in `lean-toolchain`: `leanprover/lean4:v4.29.1`.
**Mathlib** pinned in `lakefile.lean` to the released stable tag **`v4.29.1`** at commit `5e932f97dd25535344f80f9dd8da3aab83df0fe6` of `leanprover-community/mathlib4`. Cache coverage is complete (upstream CI publishes oleans for every released tag); reproduction does not require a local Mathlib build.

The two Mathlib lemmas the proof depends on:

- `DirichletCharacter.unit_norm_eq_one` (`Mathlib/NumberTheory/DirichletCharacter/Bounds.lean:27`) — the value at a unit has norm 1, proved via `pow_card_eq_one'` (the standard root-of-unity argument).
- `ZMod.isUnit_prime_of_not_dvd` (`Mathlib/Data/ZMod/Basic.lean:824`) — for `p` prime and `¬ p ∣ n`, `(p : ZMod n)` is a unit.

Both are long-resident, stable lemmas — present at `v4.29.1` at exactly the cited line numbers.

Verify zero `sorry` and zero custom axioms:

```bash
grep -rn "^\s*sorry\b" SIDEGRHTransfer/ --include="*.lean"   # expect: no matches
grep -rn "^axiom "      SIDEGRHTransfer/ --include="*.lean"   # expect: no matches
```

Verify against Lean-core axioms only:

```bash
lake env lean AxiomCheck.lean
# expected output: each theorem depends on axioms: [propext, Classical.choice, Quot.sound]
# CRITICAL: no `sorryAx` in the list
```

## Federation context

This is the GRH-transfer member of the **PLACE TO STAND federation of kernels**. Each federation member is independent: own toolchain pin, own Mathlib pin, own Zenodo deposit, own version history. Cross-kernel content travels by **vendor-with-attribution**, not Lake cross-dependency.

`SIDEGRHTransfer/Voice1Vendored.lean` contains the trimmed Voice1 content — `prime_as_real`, `prime_gt_one`, `rpow_injective`, `balance_theorem` — vendored from `SIDE-kernel/Kernel/Voice1.lean` (Phase S.5b context: LV-M-6 build, May 22, 2026). The attribution is in the file header.

This kernel is **NOT an extension** of the SIDE-kernel RH flagship; it stands alone.

## Why Mathlib

Most SIDE-* kernels are vanilla Lean 4 (no Mathlib) — by design, to keep federation pieces independent and fast. This kernel is the explicit exception: `DirichletCharacter` lives in Mathlib, and the magnitude lemma we need (`unit_norm_eq_one`) IS the substance. Building against Mathlib here is the *faithful* path; without it, the |χ(p)| = 1 step would have to be posited as a hypothesis, which would defeat the point. The discipline correction (Phase S.5a) refused that shortcut.

## Cross-references

- **Research-side anchor:** `FINDINGS_ADDITIONS_2026-05-21.md#grh-character-uniform` (currently *argument-supported*; this kernel closes the Voice1 leg).
- **Compile-list target:** `LEAN_VERIFICATIONS_TODO_v0_1.md#LV-M-6` (Mathlib DirichletCharacter |χ(p)|=1 Euler-balance transfer).
- **Companion target:** `LV-H-6` — GRH Symmetry-voice χ↔χ̄ reformulation for complex Dirichlet characters (separate kernel, builds after this one).
- **State snapshot:** `STATE_2026-05-22.md` (audit-arc-end baseline).

## License

MIT.

## AI disclosure

*Computational workflow assisted by various LLM instances. Mathematical content, proof strategies, and editorial decisions are the author's.*
