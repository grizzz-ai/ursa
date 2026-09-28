# Fail-Closed Configuration Example

This synthetic TypeScript example shows a small workflow correction: malformed configuration used to
silently receive defaults and now fails closed. It uses Node.js 22.18.0 or newer and only syntax
supported by Node's built-in type stripping. The runtime executes the TypeScript directly; it does not
type-check it or provide full TypeScript compiler support.

The preserved baseline is commit `a3ec2004f5169450cc882abdab356564fbee534a`. From the repository root,
check out that exact revision and observe the silent fallback:

```bash
git switch --detach a3ec2004f5169450cc882abdab356564fbee534a
node --test --test-name-pattern='^shows malformed configuration silently receives defaults$' examples/config-validation/test/config.test.ts
```

The selected test passes and asserts the exact default object. The separate desired-behavior test shows
that the baseline does not fail closed:

```bash
node --test --test-name-pattern='^rejects malformed configuration$' examples/config-validation/test/config.test.ts
```

That command runs one test and fails with `Missing expected exception`. The final workflow state will
reject the same input. Return to the branch you were using and run the corrected suite:

```bash
git switch -
npm test
```

The final command runs six tests and reports six passes, zero failures, and zero skipped tests. The
tests cover valid input, a non-object value, a missing field, an unsupported mode, a fractional retry
limit, and a negative retry limit.

The example demonstrates one validation change and the repository's file-based workflow. It is not a
production configuration library, a TypeScript compiler setup, or a security certification.

The [workflow records](../../.ai-workflow/fail-closed-config/) were produced before the Ursa naming
change. Their recorded identities and hashes are preserved as evidence of that earlier run.
