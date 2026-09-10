# Fail-Closed Configuration Example

This synthetic TypeScript example begins with one deliberate defect: malformed configuration silently
falls back to `{ "mode": "safe", "retryLimit": 3 }`. It uses Node.js 22.18.0 or newer and only syntax
supported by Node's built-in type stripping. The runtime executes the TypeScript directly; it does not
type-check it or provide full TypeScript compiler support.

From the repository root, observe the silent fallback with one command:

```bash
node --test --test-name-pattern='^shows malformed configuration silently receives defaults$' examples/config-validation/test/config.test.ts
```

The selected test passes and asserts the exact default object. The separate desired-behavior test shows
that the baseline does not fail closed:

```bash
node --test --test-name-pattern='^rejects malformed configuration$' examples/config-validation/test/config.test.ts
```

That command runs one test and fails with `Missing expected exception`. The final workflow state will
replace this note with commands for both the pinned baseline commit and the corrected test suite.

The example demonstrates one validation change and the repository's file-based workflow. It is not a
production configuration library, a TypeScript compiler setup, or a security certification.
